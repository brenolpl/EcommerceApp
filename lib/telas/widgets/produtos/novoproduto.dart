
import 'dart:ui';
import 'package:appflutter/core/produto_categoria.dart';
import 'package:appflutter/telas/controller/cadastrarprodutocontroller.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NovoProduto extends StatefulWidget {
  const NovoProduto({Key? key}) : super(key: key);
  @override
  _CadastrarProdutoState createState() => _CadastrarProdutoState();
}

class _CadastrarProdutoState extends State<NovoProduto> {
  late CadastrarProdutoController _cadastrarProdutoController;
  List<ProdutoCategoria> categorias = [];
  late ProdutoCategoria dropdownValue;
  bool hasLoaded = false;

  Stream<QuerySnapshot> get stream => FirebaseFirestore.instance.collection("produtos_categoria").snapshots();

  @override
  void initState() {
    super.initState();
    _cadastrarProdutoController = CadastrarProdutoController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Novo produto", style: TextStyle(fontWeight: FontWeight.normal)),
        ),

        body: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return const Text("error");
            }

            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }

            _obterCategorias(snapshot.data!);

            return Form(
              key: _cadastrarProdutoController.formKey,
              child: Container(
                margin: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _cadastrarProdutoController.imagePathController,
                      keyboardType: TextInputType.url,
                      validator: (String? text){
                        if(text!.isEmpty){
                          return "O Campo é obrigatório!";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Caminho da imagem",
                          labelStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          )
                      ),
                    ),
                    TextFormField(
                      controller: _cadastrarProdutoController.nomeController,
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
                    DropdownButtonFormField<ProdutoCategoria>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (ProdutoCategoria? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          _cadastrarProdutoController.categoriaController = dropdownValue;
                        });
                      },
                      items: categorias
                          .map<DropdownMenuItem<ProdutoCategoria>>((ProdutoCategoria value) {
                        return DropdownMenuItem<ProdutoCategoria>(
                          value: value,
                          child: Text(value.nome),
                        );
                      }).toList(),
                    ),
                    TextFormField(
                      controller: _cadastrarProdutoController.precoCustoController,
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
                    TextFormField(
                      controller: _cadastrarProdutoController.descricaoController,
                      validator: (String? text){
                        if(text!.isEmpty){
                          return "O Campo é obrigatório!";
                        }
                      },
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: "Descrição",
                          labelStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          )
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            _cadastrarProdutoController.cadastrarProduto();
                            pop(context);
                          },
                          child: const Text(
                            "Cadastrar",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 18
                            ),
                          ),
                          style:
                          ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.black),
                            overlayColor: MaterialStateProperty.all(Colors.deepOrange),
                            shape: MaterialStateProperty.all(const StadiumBorder()),
                            side: MaterialStateProperty.all(const BorderSide(width: 0.2, style: BorderStyle.solid)),
                            shadowColor: MaterialStateProperty.all(Colors.black),
                          )

                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        )
    );
  }

  void _obterCategorias(QuerySnapshot data) {
    categorias = data.docs.map((doc) => ProdutoCategoria.fromMap(doc)).toList();
    if(!hasLoaded){
      dropdownValue = categorias.first;
      _cadastrarProdutoController.categoriaController = dropdownValue;
      hasLoaded = true;
    }
  }
}
