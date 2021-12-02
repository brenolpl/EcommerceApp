import 'package:appflutter/core/carrinho.dart';
import 'package:appflutter/core/comprasusuario.dart';
import 'package:appflutter/core/endereco.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/widgets/usuario/compradetail.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ListarPedidos extends StatefulWidget {
  Usuario usuario;

  ListarPedidos(this.usuario, {Key? key}) : super(key: key);

  @override
  _ListarPedidosState createState() => _ListarPedidosState();
}

class _ListarPedidosState extends State<ListarPedidos> {
  Stream<QuerySnapshot> get streamCompra => FirebaseFirestore.instance.collection("compras_usuario").where("usuario_id", isEqualTo: widget.usuario.id).snapshots();
  NumberFormat formatter = NumberFormat.simpleCurrency();
  late Future future1;
  late Future future2;
  late List<ComprasUsuario> comprasUsuario;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus pedidos"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: streamCompra,
        builder: (context, snapshot){
            if(snapshot.hasError){
              return const Text("error");
            }

            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }

            _obterMeusPedidos(snapshot.data!);

            return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: comprasUsuario.length,
                itemBuilder: (context, index){
                  return Container(
                    margin: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      child: Text(formatter.format(comprasUsuario[index].total) + " - "+ _formatarData(comprasUsuario[index].dataCompra.toDate())),
                      onPressed: (){
                        push(context, CompraDetail(comprasUsuario[index]));
                        },
                    ),
                  );
                });
        },
      ),
    );
  }

  void _obterMeusPedidos(QuerySnapshot data) async {
    ComprasUsuario compra;
    comprasUsuario = [];
    for(DocumentSnapshot doc in data.docs){
      compra = ComprasUsuario.fromMap(doc);
      comprasUsuario.add(compra);
    }
  }

  String _formatarData(DateTime data){
    initializeDateFormatting("pt_BR", null);
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    return dateFormat.format(data);
  }
}
