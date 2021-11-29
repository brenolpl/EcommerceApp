import 'package:appflutter/core/produto.dart';
import 'package:flutter/material.dart';

class AdmProdutoDetail extends StatelessWidget {
  Produto produto;

  AdmProdutoDetail(this.produto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Image.asset(produto.imagePath, fit: BoxFit.contain, height: 160),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nome: ${produto.nome}",
                    style: const TextStyle(
                        color: Colors.black
                    ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text("Custo: ${produto.preco_custo}",
                  style: const TextStyle(
                      color: Colors.black
                  ),
                ),
                Text("Venda: ${produto.preco_compra}",
                  style: const TextStyle(
                      color: Colors.black
                  ),
                ),
                Text("\nLucro: ${(produto.preco_compra - produto.preco_custo).toStringAsFixed(2)}",
                  style: const TextStyle(
                      color: Colors.black
                  ),
                )
              ],
            ),
          ),
        ],
      );
  }
}