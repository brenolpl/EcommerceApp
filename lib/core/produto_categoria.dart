import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutoCategoria {
  late String id;
  late String nome;

  ProdutoCategoria();

  ProdutoCategoria.fromMap(DocumentSnapshot map){
    id = map.id;
    nome = map['nome'];
  }


  @override
  bool operator == (dynamic other) => other != null && other is ProdutoCategoria && this.id == other.id;

  @override
  int get hashCode => super.hashCode;
}