import 'dart:async';

import 'package:appflutter/core/carrinho.dart';
import 'package:appflutter/core/produto.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProdutoDetail extends StatelessWidget {
  Produto produto;
  Usuario usuario;
  NumberFormat formatter = NumberFormat.simpleCurrency();
  ProdutoDetail(this.produto, this.usuario, {Key? key}) : super(key: key);

  CollectionReference get _carrinhoCollection => FirebaseFirestore.instance.collection("users").doc(usuario.id).collection("carrinho");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Image.asset(produto.imagePath, fit: BoxFit.contain, width: 250),
            Text(produto.nome, textAlign: TextAlign.center, style: const TextStyle(fontSize: 25),),
            const SizedBox(height: 10),
            Container(
              child: Text(produto.descricao, style: const TextStyle(fontSize: 15)),
              margin: const EdgeInsets.only(left: 10),
            ),
            Container(
              child: Text(
                    formatter.format(produto.preco_compra),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 30,
                    ),
                  ),
              padding: const EdgeInsets.all(10),
            ),
            SizedBox(
              height: 45,
              child: ElevatedButton(
                child: const Text("Adicionar ao carrinho"),
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.deepOrange),
                  shape: MaterialStateProperty.all(const StadiumBorder())
                ),
                onPressed: () {
                  _adicionarProdutoAoCarrinho();
                  pop(context);
                },
              ),
            )
            ],
          ),
      )
      );
  }

  _adicionarProdutoAoCarrinho() {
    CarrinhoCore itemCarrinho = CarrinhoCore(produto.id, 1, produto.preco_compra*1);
    bool hasItem = false;
    _carrinhoCollection.where("produto_id", isEqualTo: produto.id).snapshots().listen((data) {
      if(data.docs.isNotEmpty) hasItem = true;
    });
    if(!hasItem){
      _carrinhoCollection.add(itemCarrinho.toMap());
    }
  }
}
