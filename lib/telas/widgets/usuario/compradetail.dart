import 'package:appflutter/core/comprasusuario.dart';
import 'package:appflutter/core/itemcompra.dart';
import 'package:appflutter/core/produto.dart';
import 'package:appflutter/telas/widgets/produtos/produtowidgereference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompraDetail extends StatefulWidget {
  ComprasUsuario compra;

  CompraDetail(this.compra, {Key? key}) : super(key: key);

  @override
  _CompraDetailState createState() => _CompraDetailState();
}

class _CompraDetailState extends State<CompraDetail> {
  late List<ItemCompra> itensCompra;
  Stream<QuerySnapshot> get stream => FirebaseFirestore.instance.collection("itens_compra").where("compra_usuario_id", isEqualTo: widget.compra.id).snapshots();
  late List<Produto> produtos;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Pedidos"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Text("error");
          }

          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          _obterProdutosComprados(snapshot.data!);

          return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: itensCompra.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(20),
                  child: ProdutoWidgetReference(itensCompra[index].produtoReference)
                );
              });
        },
      ),
    );
  }

  void _obterProdutosComprados(QuerySnapshot data) {
      itensCompra = data.docs.map((e) => ItemCompra.fromMap(e)).toList();
  }
}
