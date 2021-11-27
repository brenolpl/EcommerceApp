import 'package:appflutter/core/produto_categoria.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  late String produtoId;
  late String nome;
  late String imagePath;
  late Timestamp dataInclusao;
  late ProdutoCategoria? categoria;
  late double preco_custo;
  late double preco_compra;
  late String descricao;

  Produto.fromMap(DocumentSnapshot map){
    produtoId = map.id;
    imagePath = map['imagePath'];
    nome = map['nome'];
    dataInclusao = map['dataInclusao'];
    preco_custo = map['preco_custo'];
    preco_compra = map['preco_compra'];
    descricao = map['descricao'];
  }

  Produto();

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> data = {};
    data['imagePath'] = imagePath;
    data['categoria'] = categoria;
    data['preco_custo'] = preco_custo;
    data['preco_compra'] = preco_compra;
    data['descricao'] = descricao;
    data['dataInclusao'] = dataInclusao;
    return data;
  }
}