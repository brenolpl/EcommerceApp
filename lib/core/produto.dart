import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  late String id;
  late String nome;
  late String imagePath;
  late String categoria_id;
  late double preco_custo;
  late double preco_compra;
  late String descricao;

  Produto.fromMap(DocumentSnapshot map){
    id = map.id;
    imagePath = map['imagePath'];
    nome = map['nome'];
    preco_custo = map['preco_custo'];
    preco_compra = map['preco_compra'];
    descricao = map['descricao'];
    categoria_id = map['categoria_id'];
  }

  Produto();

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> data = {};
    data['imagePath'] = imagePath;
    data['categoria_id'] = categoria_id;
    data['preco_custo'] = preco_custo;
    data['preco_compra'] = preco_compra;
    data['descricao'] = descricao;
    data['nome'] = nome;
    return data;
  }
}