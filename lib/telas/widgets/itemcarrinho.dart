import 'package:appflutter/core/produto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemCarrinho extends StatefulWidget {
  Produto produto;

  ItemCarrinho(this.produto);

  @override
  _ItemCarrinhoState createState() => _ItemCarrinhoState();
}

class _ItemCarrinhoState extends State<ItemCarrinho> {
  NumberFormat formatter = NumberFormat.simpleCurrency();
  @override
  Widget build(BuildContext context) {
    int dropdownValue = 1;
    return Container(
        child: Column(
          children: [
            Row(
                children: [
                  Image.asset(widget.produto.imagePath, fit: BoxFit.contain, width: 100),
                  Text(widget.produto.nome),
                  const SizedBox(
                    width: 170,
                  ),
                  Text("${formatter.format(widget.produto.preco_compra)}")
                ],
            ),
          ],
        ),
    );
  }
}
