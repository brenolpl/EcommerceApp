import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutoCategoria {
  late String id;
  late String nome;

  ProdutoCategoria.fromMap(DocumentSnapshot map){
    id = map.id;
    nome = map['nome'];
  }
}