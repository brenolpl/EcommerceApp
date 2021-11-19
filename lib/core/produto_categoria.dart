import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutoCategoria {
  late String categoria_id;
  late String nome_categoria;

  ProdutoCategoria.fromMap(DocumentSnapshot map){
    categoria_id = map.id;
    nome_categoria = map['nome'];
  }
}