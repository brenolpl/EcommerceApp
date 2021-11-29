import 'package:appflutter/core/produto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProdutoWidget extends StatelessWidget {
  Produto produto;
  NumberFormat formatter = NumberFormat.simpleCurrency();
  ProdutoWidget(this.produto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Image.asset(produto.imagePath, fit: BoxFit.contain, width: 220),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                  produto.nome,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.black
                  ),
              ),
              const SizedBox(height: 10),
              Text(
                  formatter.format(produto.preco_compra).toString(),
                  style: const TextStyle(
                      color: Colors.deepOrange,
                    fontSize: 20
                  ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
