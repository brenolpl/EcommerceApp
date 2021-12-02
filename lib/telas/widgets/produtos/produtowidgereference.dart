import 'package:appflutter/core/produto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProdutoWidgetReference extends StatefulWidget {
  DocumentReference produtoReference;

  ProdutoWidgetReference(this.produtoReference, {Key? key}) : super(key: key);

  @override
  _ProdutoWidgetReferenceState createState() => _ProdutoWidgetReferenceState();
}

class _ProdutoWidgetReferenceState extends State<ProdutoWidgetReference> {
  NumberFormat formatter = NumberFormat.simpleCurrency();
  Stream<DocumentSnapshot> get stream => widget.produtoReference.snapshots();
  late Produto produto;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: stream,
      builder: (context, snapshot){
        if(snapshot.hasError){
          return const Text("erro");
        }

        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator());
        }

        produto = Produto.fromMap(snapshot.data!);

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
      },
    );
  }
}
