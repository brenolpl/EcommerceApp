import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutoCategoria {
  late String categoria_id;
  late String nome;

  ProdutoCategoria.fromMap(DocumentSnapshot map){
    categoria_id = map.id;
    nome = map['nome'];
  }
}