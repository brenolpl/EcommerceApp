
import 'dart:ui';

import 'package:appflutter/core/produto.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/controller/cadastrarenderecocontroller.dart';
import 'package:appflutter/telas/controller/cadastrarprodutocontroller.dart';
import 'package:appflutter/telas/controller/cadastrarusuariocontroller.dart';
import 'package:appflutter/telas/widgets/enderecos/cadastrarendereco.dart';
import 'package:appflutter/telas/widgets/enderecos/listarendereco.dart';
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

class NovoProduto extends StatefulWidget {
  String appBarTitle;
  bool readOnly;
  Produto? produto;
  //NovoProduto(this.appBarTitle, this.readOnly, {Key? key, this.produto}) : super(key: key);
  NovoProduto(this.appBarTitle, this.readOnly, {this.produto});
  @override
  _CadastrarProdutoState createState() => _CadastrarProdutoState();
}

class _CadastrarProdutoState extends State<NovoProduto> {
  //bool hideSenha = false;
  bool editandoProduto = false;
  late CadastrarProdutoController _cadastrarProdutoController;
  //late CadastrarEnderecoController _cadastrarEnderecoController;
  //final maskCpf = MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});
  //final dateMask = MaskTextInputFormatter(mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')});
  //final phoneMask = MaskTextInputFormatter(mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')});
  Stream<QuerySnapshot> get stream => FirebaseFirestore.instance.collection("produto").snapshots();


  @override
  void initState() {
    super.initState();
    _cadastrarProdutoController = CadastrarProdutoController();
    //_cadastrarProdutoController = CadastrarEnderecoController();
    if(widget.produto != null) {
      _cadastrarProdutoController.imagePathController.value = TextEditingValue(text: widget.produto!.imagePath);
      _cadastrarProdutoController.nomeController.value = TextEditingValue(text: widget.produto!.nome);
      _cadastrarProdutoController.categoriaController.value = TextEditingValue(text: widget.produto!.categoria!.nome);
      _cadastrarProdutoController.precoCustoController.value = TextEditingValue(text: widget.produto!.preco_custo.toString());
      _cadastrarProdutoController.precoCompraController.value = TextEditingValue(text: widget.produto!.preco_compra.toString());
      _cadastrarProdutoController.descricaoController.value = TextEditingValue(text: widget.produto!.descricao);

      //_cadastrarProdutoController.nomeController.value = TextEditingValue(text: widget.usuario!.nome);
      //_cadastrarProdutoController.cpfController.value = TextEditingValue(text: widget.usuario!.cpf);
      //initializeDateFormatting("pt_BR", null);
      //DateFormat formatter = DateFormat("dd/MM/yyyy");
      //String date = formatter.format(widget.usuario!.dataNascimento.toDate());
      //_cadastrarUsuarioController.dataNascimentoController.value = TextEditingValue(text: date);
      //_cadastrarUsuarioController.telefoneController.value = TextEditingValue(text: widget.usuario!.telefone);
    }
    /*if(widget.readOnly){
      hideSenha = true;
    }*/
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.appBarTitle, style: const TextStyle(fontWeight: FontWeight.normal)),
          actions: [
            widget.readOnly ? IconButton(icon: const Icon(Icons.edit), onPressed: (){setState((){widget.readOnly = false; editandoProduto = true;});}) : Container()
          ],
        ),

        body: Form(
          key: _cadastrarProdutoController.formKey,
          child: StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return const Center(child: CircularProgressIndicator());
                }

                if(snapshot.hasData){
                  if(widget.produto != null) _obterProduto(snapshot.data!);
                }

                double? valor;
                return Container(
                  margin: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      /*const Align(
                        child: Text(
                            "Informações da conta",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 17
                            )
                        ),
                        alignment: Alignment.centerLeft,
                      ),*/
                      TextFormField(
                        controller: _cadastrarProdutoController.imagePathController,
                        keyboardType: TextInputType.url,
                        //readOnly: hideSenha,
                        validator: (String? text){
                          if(text!.isEmpty){
                            return "O Campo é obrigatório!";
                          }
                          return null;
                        },
                      ),
                      /*!hideSenha ? TextFormField(
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
                      ),*/
                      TextFormField(
                        controller: _cadastrarProdutoController.nomeController,
                        readOnly: widget.readOnly,
                        validator: (String? text){
                          if(text!.isEmpty){
                            return "O Campo é obrigatório!";
                          }
                        },
                        decoration: const InputDecoration(
                            labelText: "Nome Produto",
                            labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            )
                        ),
                      ),
                      TextFormField(
                        controller: _cadastrarProdutoController.categoriaController,
                        readOnly: widget.readOnly,
                        //inputFormatters: [maskCpf],
                        validator: (String? text){
                          if(text!.isEmpty){
                            return "O Campo é obrigatório!";
                          }
                        },
                        decoration: const InputDecoration(
                            labelText: "Categoria",
                            labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            )
                        ),
                      ),
                      TextFormField(
                        controller: _cadastrarProdutoController.precoCustoController,
                        readOnly: widget.readOnly,
                        //inputFormatters: [],
                        validator: (String? text){
                          if(text!.isEmpty){
                            return "O Campo é obrigatório!";
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Valor de Compra",
                            labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            )
                        ),
                      ),
                      TextFormField(
                        controller: _cadastrarProdutoController.precoCompraController,
                        readOnly: widget.readOnly,
                        //inputFormatters: [],
                        validator: (String? text){
                          if(text!.isEmpty){
                            return "O Campo é obrigatório!";
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Valor de Venda",
                            labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      /*!editandoProduto? const Align(
                        child: Text(
                            "Endereço",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 17
                            )
                        ),
                        alignment: Alignment.centerLeft,
                      ): Container(),*/
                      //!widget.readOnly && !editandoUsuario? CadastrarEndereco(controller: _cadastrarEnderecoController) : !editandoUsuario? ListarEndereco(widget.usuario!):Container(),
                      !widget.readOnly ? SizedBox(
                        height: 46,
                        child: !editandoProduto? ElevatedButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(Colors.deepOrange),
                              shape: MaterialStateProperty.all(const StadiumBorder()),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.cyanAccent.withOpacity(0.65))),
                          child: const Text(
                            "Cadastrar Produto",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                          onPressed: () {
                            _cadastrarProdutoController.signUp(context);
                          },
                        ) :
                        ElevatedButton(
                          onPressed: (){
                            _atualizarProduto(snapshot.data!);
                            editandoProduto = false;
                            widget.readOnly = true;
                            //pop(context);
                          },
                          child: const Text(
                              "Salvar Alteração"
                          ),
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.deepOrange),
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

  _obterProduto(QuerySnapshot data) {
    for(DocumentSnapshot doc in data.docs){
      if(doc.id == widget.produto!.produtoId){
        widget.produto = Produto.fromMap(doc);
        break;
      }
    }
  }

  _atualizarProduto(QuerySnapshot data) {
    widget.produto = _cadastrarProdutoController.setCamposProduto(widget.produto!);
    FirebaseFirestore.instance.collection("produto").doc(widget.produto!.produtoId).update(widget.produto!.toMap());
    for(DocumentSnapshot doc in data.docs){
      if(doc.id == widget.produto!.produtoId){
        widget.produto = Produto.fromMap(doc);
        break;
      }
    }
  }


}
