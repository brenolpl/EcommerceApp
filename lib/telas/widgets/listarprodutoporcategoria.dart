import 'package:appflutter/core/produto_categoria.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListarCategorias extends StatefulWidget {
  ListarCategorias({Key? key}) : super(key: key);

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
                  margin: const EdgeInsets.all(20),
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        //push(context, ProdutoEdit(produtos[index]));
                      },
                      child: Text(categorias[index].nome_categoria),
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
