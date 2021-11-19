import 'package:appflutter/core/produto.dart';
import 'package:flutter/material.dart';

class ProdutoWidget extends StatelessWidget {
  Produto produto;

  ProdutoWidget(this.produto);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Image.asset(produto.imagePath, fit: BoxFit.contain, width: 220),
            ],
          ),
          Column(
            children: [
              Text(produto.nome),
              Text("${produto.preco_custo}"),
              Text("Api do frete aqui")
            ],
          )
        ],
      ),
    );
  }
}
