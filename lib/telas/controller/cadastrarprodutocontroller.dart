import 'package:appflutter/core/endereco.dart';
import 'package:appflutter/core/endereco.dart';
import 'package:appflutter/core/produto.dart';
import 'package:appflutter/core/produto_categoria.dart';
import 'package:appflutter/core/usuario.dart';
//import 'package:appflutter/telas/widgets/novoProduto.dart';
import 'package:appflutter/util/businessexception.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CadastrarProdutoController {
  late final formKey = GlobalKey<FormState>();
  late final TextEditingController nomeController;
  late final TextEditingController imagePathController;
  late final TextEditingController precoCustoController;
  late final TextEditingController precoCompraController;
  late final TextEditingController descricaoController;
  late ProdutoCategoria categoriaController;
  CollectionReference get produtoCollection => FirebaseFirestore.instance.collection("produtos");
  CollectionReference get categoriaCollection => FirebaseFirestore.instance.collection("categoria");


  CadastrarProdutoController(){
    nomeController = TextEditingController();
    imagePathController= TextEditingController();
    precoCustoController = TextEditingController();
    precoCompraController = TextEditingController();
    descricaoController = TextEditingController();
  }

  setCamposProduto(Produto produto){
    produto.nome = nomeController.text.trim();
    produto.imagePath = imagePathController.text.trim();
    produto.preco_custo = double.parse(precoCustoController.text.trim());
    produto.preco_compra = double.parse(precoCompraController.text.trim());
    produto.descricao = descricaoController.text.trim();
    produto.categoria_id = categoriaController.id;
    return produto;
  }


  void cadastrarProduto() {
    if(formKey.currentState!.validate()){
      Produto produto = setCamposProduto(Produto());
      FirebaseFirestore.instance.collection("produtos").add(produto.toMap());
    }
  }
}