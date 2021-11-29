import 'package:appflutter/core/produto_categoria.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/controller/carrinhocontroller.dart';
import 'package:appflutter/telas/widgets/produto_categoria/cadastrarcategoria.dart';
import 'package:appflutter/telas/widgets/produto_categoria/listarprodutoporcategoria.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListarCategorias extends StatefulWidget {
  Usuario usuario;
  final CarrinhoController _carrinhoController;

  ListarCategorias(this.usuario, this._carrinhoController, {Key? key}) : super(key: key);

  @override
  _ListarCategoriasState createState() => _ListarCategoriasState();
}

class _ListarCategoriasState extends State<ListarCategorias> {
  late List<ProdutoCategoria> categorias = [];
  Stream<QuerySnapshot> get stream => FirebaseFirestore.instance.collection("produtos_categoria").snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categorias"),
        actions: [
          widget.usuario.admin ? IconButton(icon: const Icon(Icons.add), onPressed: (){push(context, const CadastrarCategoria());}) : Container()
        ],
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }

          if(snapshot.hasError){
            return const Text("error");
          }

          _obterCategorias(snapshot.data!);

          return ListView.builder(
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        push(context, ListarProdutoPorCategoria(categorias[index], widget._carrinhoController));
                      },
                      child: Text(categorias[index].nome, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                      style:
                      ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
                        overlayColor: MaterialStateProperty.all(Colors.deepOrange),
                        shape: MaterialStateProperty.all(BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))),
                        side: MaterialStateProperty.all(const BorderSide(width: 0.1, style: BorderStyle.solid)),
                        shadowColor: MaterialStateProperty.all(Colors.black),

                      )
                  ),
                );
              });
        },
      ),
    );
  }

  _obterCategorias(QuerySnapshot data) {
    categorias = data.docs.map((doc) => ProdutoCategoria.fromMap(doc)).toList();
  }
}
