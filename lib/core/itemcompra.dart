import 'package:cloud_firestore/cloud_firestore.dart';

class ItemCompra {
  late String compra_usuario_id;
  late String id;
  late DocumentSnapshot produto;
  late DocumentReference produtoReference;
  late int quantidade;

  ItemCompra(this.quantidade, produto);

  ItemCompra.fromMap(DocumentSnapshot map){
    id = map.id;
    compra_usuario_id = map['compra_usuario_id'];
    produtoReference = map['produto'];
    quantidade = map['quantidade'];
  }

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> data = {};
    data['produto'] = produto.reference;
    data['quantidade'] = quantidade;
    data['compra_usuario_id'] = compra_usuario_id;
    return data;
  }
}