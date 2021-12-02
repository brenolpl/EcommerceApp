import 'package:cloud_firestore/cloud_firestore.dart';

class CarrinhoCore {
  late String id;
  late String produto_id;
  late int quantidade;
  late double total;

  CarrinhoCore.fromMap(DocumentSnapshot map){
    id = map.id;
    produto_id = map['produto_id'];
    quantidade = map['quantidade'];
    total = map['total'];
  }

  CarrinhoCore.fromMapSemTotal(DocumentSnapshot map){
    id = map.id;
    produto_id = map['produto_id'];
    quantidade = map['quantidade'];
  }

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> data = {};
    data['produto_id'] = produto_id;
    data['quantidade'] = quantidade;
    data['total'] = total;
    return data;
  }

  CarrinhoCore(this.produto_id, this.quantidade, this.total);


}