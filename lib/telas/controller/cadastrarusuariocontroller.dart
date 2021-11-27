import 'package:appflutter/core/endereco.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/controller/cadastrarenderecocontroller.dart';
import 'package:appflutter/telas/widgets/homepage.dart';
import 'package:appflutter/util/businessexception.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadastrarUsuarioController {
  late final formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController senhaController;
  late final TextEditingController nomeController;
  late final TextEditingController cpfController;
  late final TextEditingController dataNascimentoController;
  late final TextEditingController telefoneController;
  late CadastrarEnderecoController _cadastrarEnderecoController;
  CollectionReference get _usersCollection => FirebaseFirestore.instance.collection("users");
  CollectionReference get _enderecoCollection => FirebaseFirestore.instance.collection("endereco");


  CadastrarUsuarioController(){
    emailController = TextEditingController();
    senhaController = TextEditingController();
    nomeController = TextEditingController();
    cpfController = TextEditingController();
    dataNascimentoController = TextEditingController();
    telefoneController = TextEditingController();
  }

  void signUp(BuildContext context, CadastrarEnderecoController cadastrarEnderecoController) async {
    _cadastrarEnderecoController = cadastrarEnderecoController;
    if(formKey.currentState!.validate()){
      Endereco endereco = Endereco();
      Usuario usuario = Usuario();
      setCamposUsuario(usuario);
      endereco.cep = _cadastrarEnderecoController.cepController.text.trim();
      endereco.endereco = _cadastrarEnderecoController.enderecoController.text.trim();
      endereco.estado = _cadastrarEnderecoController.estado;
      endereco.bairro = _cadastrarEnderecoController.bairroController.text.trim();
      endereco.numero = _cadastrarEnderecoController.numeroController.text.trim();
      endereco.referencia = _cadastrarEnderecoController.referenciaController.text.trim();
      endereco.cidade = _cadastrarEnderecoController.cidadeController.text.trim();
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: usuario.email, password: senhaController.text.trim());
        Future<DocumentReference> usersFuture = _usersCollection.add(usuario.toMap());
        Future<DocumentReference> enderecoFuture = _enderecoCollection.add(endereco.toMap());
        Future.wait([usersFuture, enderecoFuture]).then((List<DocumentReference> value) {
          usuario.id = value[0].id;
          endereco.id = value[1].id;
          _usersCollection.doc(usuario.id).update({"endereco_id": endereco.id});
          _enderecoCollection.doc(endereco.id).update({"usuario_id": usuario.id});
          _gotoHomePage(usuario, context);
        });
      }on FirebaseAuthException catch (e){
        if(e.code == 'weak-password'){
          businessException("weak-password", context);
        }else if(e.code == 'email-already-in-use'){
          businessException("email-used", context);
        }
      }
    }
  }

  setCamposUsuario(Usuario usuario){
    usuario.admin = false;
    usuario.email = emailController.text.trim();
    usuario.nome = nomeController.text.trim();
    usuario.cpf = cpfController.text.trim();
    DateFormat formatter = DateFormat("dd/MM/yyyy");
    usuario.dataNascimento = Timestamp.fromDate(formatter.parse(dataNascimentoController.text.trim()));
    usuario.telefone = telefoneController.text.trim();
    return usuario;
  }

  _gotoHomePage(Usuario usuario, BuildContext context){
      push(context, HomePage(usuario), replace: true);
  }
}