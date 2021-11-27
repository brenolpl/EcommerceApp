import 'package:appflutter/core/produto.dart';
import 'package:appflutter/core/produto_categoria.dart';
import 'package:appflutter/telas/controller/carrinhocontroller.dart';
import 'package:appflutter/telas/widgets/carrinho.dart';
import 'package:appflutter/telas/widgets/produtos/produto.dart';
import 'package:appflutter/telas/widgets/produtos/produtodetail.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListarProdutoPorCategoria extends StatefulWidget {
  ProdutoCategoria produtoCategoria;
  final CarrinhoController _carrinhoController;

  ListarProdutoPorCategoria(this.produtoCategoria, this._carrinhoController, {Key? key}) : super(key: key);


  @override
  _ListarProdutoPorCategoriaState createState() => _ListarProdutoPorCategoriaState();
}

class _ListarProdutoPorCategoriaState extends State<ListarProdutoPorCategoria> {
  List<Produto> produtos = [];
  Stream<QuerySnapshot> get stream => FirebaseFirestore.instance.collection("produtos").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.produtoCategoria.nome),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              push(context, Carrinho(widget._carrinhoController));
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot){
          if(!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          if(snapshot.hasError) return const Text("error");

          _listarProdutos(snapshot.data!);

          return ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                    onPressed: () {
                      push(context, ProdutoDetail(produtos[index], widget._carrinhoController));
                    },
                    child: ProdutoWidget(produtos[index]),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white70.withOpacity(0.75)),
                      overlayColor: MaterialStateProperty.all(Colors.deepOrange),
                      shape: MaterialStateProperty.all(BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))),
                      side: MaterialStateProperty.all(const BorderSide(width: 0.1, style: BorderStyle.solid)),
                      shadowColor: MaterialStateProperty.all(Colors.black),
                    )
                );
              });
        },
      ),
    );
  }

  _listarProdutos(QuerySnapshot data) {
    for(DocumentSnapshot doc in data.docs){
      DocumentReference docRef = doc["categoria_id"];
      if(docRef.id == widget.produtoCategoria.id){
        produtos.add(Produto.fromMap(doc));
      }
    }
  }
}
