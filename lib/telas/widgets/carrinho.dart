import 'package:appflutter/telas/controller/carrinhocontroller.dart';
import 'package:appflutter/util/nav.dart';
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
      return ListView.builder(
          itemCount: _carrinhoController.listaProdutos.length,
          itemBuilder: (context, index){
            return ItemCarrinho(_carrinhoController.listaProdutos[index]);
        });
    }else {
      return Text("erro");
    }
  }
}
