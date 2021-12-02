import 'package:appflutter/core/produto.dart';
import 'package:appflutter/core/produto_categoria.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/widgets/carrinho/carrinho.dart';
import 'package:appflutter/telas/widgets/produtos/produto.dart';
import 'package:appflutter/telas/widgets/produtos/produtodetail.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListarProdutoPorCategoria extends StatefulWidget {
  ProdutoCategoria produtoCategoria;
  Usuario usuario;

  ListarProdutoPorCategoria(this.produtoCategoria, this.usuario, {Key? key}) : super(key: key);


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
              push(context, Carrinho());
            },
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot){
            if(!snapshot.hasData) return const Center(child: CircularProgressIndicator());

            if(snapshot.hasError) return const Text("error");

            _listarProdutos(snapshot.data!);

            return ListView.builder(
                itemCount: produtos.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 7),
                    child: ElevatedButton(
                        onPressed: () {
                          push(context, ProdutoDetail(produtos[index], widget.usuario));
                        },
                        child: ProdutoWidget(produtos[index]),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white70.withOpacity(0.75)),
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
      ),
    );
  }

  _listarProdutos(QuerySnapshot data) {
    for(DocumentSnapshot doc in data.docs){
      if(doc['categoria_id'] == widget.produtoCategoria.id){
        produtos.add(Produto.fromMap(doc));
      }
    }
  }
}
