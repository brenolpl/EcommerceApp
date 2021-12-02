import 'package:appflutter/core/produto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'endereco.dart';

class ComprasUsuario {
  late String id;
  late String usuario_id;
  late Timestamp dataCompra;
  Endereco? endereco_envio;
  List<Produto>? produtosComprados;
  late double total;

  ComprasUsuario(this.usuario_id, this.dataCompra, this.total);

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> data = {};
    data['usuario_id'] = usuario_id;
    data['dataCompra'] = dataCompra;
    data['total'] = total;
    return data;
  }

  ComprasUsuario.fromMap(DocumentSnapshot map){
    id = map.id;
    usuario_id = map['usuario_id'];
    dataCompra = map['dataCompra'];
    total = map['total'];
  }
}