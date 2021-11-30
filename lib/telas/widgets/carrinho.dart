import 'package:appflutter/core/produto.dart';
import 'package:appflutter/telas/controller/carrinhocontroller.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'itemcarrinho.dart';

class Carrinho extends StatefulWidget {
  CarrinhoController _carrinhoController;

  Carrinho(this._carrinhoController);

  @override
  _CarrinhoState createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  late CarrinhoController _carrinhoController;
  @override
  void initState() {
    super.initState();
    _carrinhoController = widget._carrinhoController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: (){
              _carrinhoController.listaProdutos = [];
              pop(context);
            }
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    if(_carrinhoController.listaProdutos.isEmpty){
      return const Center(
        child: Text("Carrinho Vazio", textAlign: TextAlign.center, style: TextStyle(
            fontSize: 20
          )
        )
      );
    }else if(_carrinhoController.listaProdutos != []){
      return ListView(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: _carrinhoController.listaProdutos.length,
              itemBuilder: (context, index){
                return ItemCarrinho(_carrinhoController.listaProdutos[index]);
              }),
          //CarrinhoTotal(_carrinhoController)
          ElevatedButton(
            child: Text('Comprar: \R\$${_carrinhoController.totalCarrinho = _total()}', style: TextStyle(fontSize: 20.0)),
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all(const StadiumBorder())
            ),
            onPressed: () {
              _firebasedb();
            },

          ),
        ],
      );
    }else {
      return Text("erro");
    }
  }

  _total() {
    _carrinhoController.totalCarrinho = 0.0;
    _carrinhoController.listaProdutos.map((e) => _carrinhoController.totalCarrinho += e.preco_compra ).toList();
    return _carrinhoController.totalCarrinho;
  }

  _firebasedb() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final _CollectionReference = _firestore.collection("compras_usuario").doc("compras_usuario").collection("produtos_compra");
    final _DocumentReference = _firestore.collection("compras_usuario").doc("compras_usuario");
    final User user = auth.currentUser;
    final uid = user.uid;
    List<Produto> listaProdutos = _carrinhoController.listaProdutos.toSet().toList();

    List<Produto> listaProdutosOrdenados = _carrinhoController.listaProdutos;
    listaProdutosOrdenados.sort((a,b) => a.nome.compareTo(b.nome));

    for(int i = 0; i < listaProdutos.length; i++) {
      _verificarQtdItensRepetidos(listaProdutosOrdenados, listaProdutos[i], uid, _CollectionReference);
    }

    Map<String,dynamic> demoData = {
      "data_compra": DateTime.now().millisecondsSinceEpoch,
      "id_produtos_compra": _CollectionReference.id,
      "id_usuario" : user.uid,
      "total_compra": _carrinhoController.totalCarrinho,
    };
    _DocumentReference.set(demoData);

  }

  _verificarQtdItensRepetidos(List<Produto> produtos, Produto produto, String id, CollectionReference  postsRef) async {
    int qtd = 0;
    for(int i = 0; i < produtos.length; i++) {

      if(produto == produtos[i]) {
        qtd++;
      }
    }

    Map<String,dynamic> demoData = {
      "id_produto": produto.id,
      "quantidade": qtd,
    };
    postsRef.add(demoData);

  }
}
