import 'package:appflutter/core/produto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProdutoWidget extends StatelessWidget {
  Produto produto;
  NumberFormat formatter = NumberFormat.simpleCurrency();
  ProdutoWidget(this.produto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Image.asset(produto.imagePath, fit: BoxFit.contain, width: 220),
          ],
        ),
        Column(
          children: [
            Text(
                produto.nome,
                style: const TextStyle(
                  color: Colors.black
                ),
            ),
            Text(
                formatter.format(produto.preco_compra).toString(),
                style: const TextStyle(
                    color: Colors.black
                ),
            )
          ],
        ),
      ],
    );
  }
}
