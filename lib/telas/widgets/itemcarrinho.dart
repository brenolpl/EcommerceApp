import 'package:appflutter/core/produto.dart';
import 'package:flutter/material.dart';

class ItemCarrinho extends StatefulWidget {
  Produto produto;

  ItemCarrinho(this.produto);

  @override
  _ItemCarrinhoState createState() => _ItemCarrinhoState();
}

class _ItemCarrinhoState extends State<ItemCarrinho> {

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
                  SizedBox(
                    width: 170,
                  ),
                  Text("${widget.produto.preco_compra}")
                ],
            ),
          ],
        ),
    );
  }
}
