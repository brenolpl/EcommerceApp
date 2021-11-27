
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/streams/editarusuariobloc.dart';
import 'package:appflutter/telas/controller/cadastrarenderecocontroller.dart';
import 'package:appflutter/telas/controller/cadastrarusuariocontroller.dart';
import 'package:appflutter/telas/widgets/cadastrarendereco.dart';
import 'package:appflutter/telas/widgets/listarendereco.dart';
import 'package:appflutter/util/businessexception.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/date_symbol_data_local.dart';

class CadastrarUsuario extends StatefulWidget {
  String appBarTitle;
  bool readOnly;
  Usuario? usuario;
  CadastrarUsuario(this.appBarTitle, this.readOnly, {this.usuario = null});

  @override
  _CadastrarUsuarioState createState() => _CadastrarUsuarioState();
}

class _CadastrarUsuarioState extends State<CadastrarUsuario> {
  bool hideSenha = false;
  bool editandoUsuario = false;
  late CadastrarUsuarioController _cadastrarUsuarioController;
  late CadastrarEnderecoController _cadastrarEnderecoController;
  final maskCpf = MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});
  final dateMask = MaskTextInputFormatter(mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')});
  final phoneMask = MaskTextInputFormatter(mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')});
  Stream<QuerySnapshot> get stream => FirebaseFirestore.instance.collection("users").snapshots();


  @override
  void initState() {
    super.initState();
    _cadastrarUsuarioController = CadastrarUsuarioController();
    _cadastrarEnderecoController = CadastrarEnderecoController();
    if(widget.usuario != null) {
      _cadastrarUsuarioController.emailController.value = TextEditingValue(text: widget.usuario!.email);
      _cadastrarUsuarioController.nomeController.value = TextEditingValue(text: widget.usuario!.nome);
      _cadastrarUsuarioController.cpfController.value = TextEditingValue(text: widget.usuario!.cpf);
      initializeDateFormatting("pt_BR", null);
      DateFormat formatter = DateFormat("dd/MM/yyyy");
      String date = formatter.format(widget.usuario!.dataNascimento.toDate());
      _cadastrarUsuarioController.dataNascimentoController.value = TextEditingValue(text: date);
    _cadastrarUsuarioController.telefoneController.value = TextEditingValue(text: widget.usuario!.telefone);
    }
    if(widget.readOnly){
      hideSenha = true;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle, style: const TextStyle(fontWeight: FontWeight.normal)),
        actions: [
          widget.readOnly ? IconButton(icon: const Icon(Icons.refresh), onPressed: () {setState((){});}) : Container(),
          widget.readOnly ? IconButton(icon: const Icon(Icons.edit), onPressed: (){setState((){widget.readOnly = false; editandoUsuario = true;});}) : Container()
        ],
      ),
      body: Form(
        key: _cadastrarUsuarioController.formKey,
        child: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              _obterUsuario(snapshot.data!);
            }

            return Container(
              margin: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Align(
                    child: Text(
                        "Informações da conta",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 17
                        )
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  TextFormField(
                    controller: _cadastrarUsuarioController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    readOnly: hideSenha,
                    validator: (String? text){
                      if(text!.isEmpty){
                        return "O Campo $text é obrigatório!";
                      }else if(!EmailValidator.validate(text)){
                        return "Digite um email válido!";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        )
                    ),
                  ),
                  !hideSenha ? TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        )
                    ),
                    controller: _cadastrarUsuarioController.senhaController,
                    validator: (String? text){
                      if(text!.isEmpty){
                        return "O campo $text é obrigatório";
                      }else if(!text.contains(RegExp("[A-Z0-9]"))) {
                        return "Sua senha precisa conter ao menos uma letra e um número";
                      }else if(text.length<8){
                        return "Sua senha precisa conter 8 ou mais caracteres";
                      }
                      return null;
                    },
                  ): Container(),
                  const SizedBox(
                    height: 25,
                  ),
                  const Align(
                    child: Text(
                        "Dados Pessoais",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 17
                        )
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  TextFormField(
                    controller: _cadastrarUsuarioController.nomeController,
                    readOnly: widget.readOnly,
                    validator: (String? text){
                      if(text!.isEmpty){
                        return "O Campo $text é obrigatório!";
                      }
                    },
                    decoration: const InputDecoration(
                        labelText: "Nome completo",
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        )
                    ),
                  ),
                  TextFormField(
                    controller: _cadastrarUsuarioController.cpfController,
                    readOnly: widget.readOnly,
                    inputFormatters: [maskCpf],
                    validator: (String? text){
                      if(text!.isEmpty){
                        return "O Campo $text é obrigatório!";
                      }else if(!CPFValidator.isValid(text)){
                        return "CPF Inválido!";
                      }

                    },
                    decoration: const InputDecoration(
                        labelText: "CPF",
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        )
                    ),
                  ),
                  TextFormField(
                    controller: _cadastrarUsuarioController.dataNascimentoController,
                    readOnly: widget.readOnly,
                    inputFormatters: [dateMask],
                    validator: (String? text){
                      if(text != null && text.isNotEmpty){
                        try{
                          initializeDateFormatting("pt_BR", null);
                          var format = DateFormat('dd/MM/yyyy');
                          DateTime date = format.parse(text);
                          if(DateTime.now().isBefore(date)){
                            return "Data de nascimento inválida!";
                          }
                        }on FormatException catch(ex){
                          businessException("unexpected", context);
                        }
                      }else if(text!.isEmpty){
                        return "O Campo $text é obrigatório!";
                      }
                    },
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                        labelText: "Data de Nascimento",
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        )
                    ),
                  ),
                  TextFormField(
                    controller: _cadastrarUsuarioController.telefoneController,
                    readOnly: widget.readOnly,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [phoneMask],
                    validator: (String? text){
                      if(text!.isEmpty){
                        return "O Campo $text é obrigatório!";
                      }
                    },
                    decoration: const InputDecoration(
                        labelText: "Telefone de contato",
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        )
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  !editandoUsuario? const Align(
                    child: Text(
                        "Endereço",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 17
                        )
                    ),
                    alignment: Alignment.centerLeft,
                  ): Container(),
                  !widget.readOnly && !editandoUsuario? CadastrarEndereco(controller: _cadastrarEnderecoController) : !editandoUsuario? ListarEndereco(widget.usuario!):Container(),
                  !widget.readOnly ? Container(
                    height: 46,
                    child: !editandoUsuario? ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(const StadiumBorder()),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.cyanAccent.withOpacity(0.65))),
                      child: const Text(
                        "Cadastrar",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                      onPressed: () {
                        _cadastrarUsuarioController.signUp(context, _cadastrarEnderecoController);
                      },
                    ) :
                    ElevatedButton(
                      onPressed: (){
                        _obterUsuario(snapshot.data!);
                        editandoUsuario = false;
                        widget.readOnly = true;
                        pop(context);
                      },
                      child: const Text(
                        "Salvar"
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(const StadiumBorder()),
                      ),
                    ),
                  ) :
                  Container(),

                ],
              ),
            );
          }
        ),
      )
    );
  }

  _obterUsuario(QuerySnapshot data) {
    for(DocumentSnapshot doc in data.docs){
      if(doc.id == widget.usuario!.id){
        widget.usuario = Usuario.fromMap(doc);
        break;
      }
    }
  }
}
