import 'package:appflutter/core/produto.dart';
import 'package:appflutter/telas/controller/carrinhocontroller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProdutoDetail extends StatelessWidget {
  Produto produto;
  NumberFormat formatter = NumberFormat.simpleCurrency();
  CarrinhoController _carrinhoController;

  ProdutoDetail(this.produto, this._carrinhoController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
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
            padding: EdgeInsets.all(10),
          ),
          ElevatedButton(
            child: Text("Comprar"),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const StadiumBorder())
            ),
            onPressed: () {
              _carrinhoController.listaProdutos.add(produto);
            },
          )
          ],
        )
      );
  }
}
