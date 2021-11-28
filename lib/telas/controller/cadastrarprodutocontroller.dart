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
  late final TextEditingController categoriaController;
  late final TextEditingController precoCustoController;
  late final TextEditingController precoCompraController;
  late final TextEditingController descricaoController;
  CollectionReference get _produtoCollection => FirebaseFirestore.instance.collection("produto");
  CollectionReference get _categoriaCollection => FirebaseFirestore.instance.collection("categoria");


  CadastrarProdutoController(){
    nomeController = TextEditingController();
    imagePathController= TextEditingController();
    categoriaController = TextEditingController();
    precoCustoController = double.tryParse(TextEditingController().toString()) as TextEditingController;
    precoCompraController = double.tryParse(TextEditingController().toString()) as TextEditingController;
    descricaoController = TextEditingController();
  }


  void signUp(BuildContext context) async {

    if(formKey.currentState!.validate()) {
      //Categoria categoria = Categoria();
      Produto produto = Produto();
      setCamposProduto(produto);
      try {
        Future<DocumentReference> produtoFuture = _produtoCollection.add(
            produto.toMap());
        Future.wait([produtoFuture]).then((List<DocumentReference> value) {
          _gotoCriarProduto(context);
        });
      }on FirebaseAuthException catch (e){
        if(e.code == 'weak-password'){
          businessException("weak-password", context);
        }else if(e.code == 'email-already-in-use'){
          businessException("email-used", context);
        }
      }
    }
  }

   Future excluirProduto(Produto produto) async {
    return FirebaseFirestore.instance.collection("produtos").doc(produto.produtoId).delete();

  }

  setCamposProduto(Produto produto){
    produto.nome = nomeController.text.trim();
    produto.imagePath = imagePathController.text.trim();
    //produto.categoria = categoriaController.text.trim() as ProdutoCategoria?;
    produto.preco_custo = precoCustoController.text.trim() as double;
    produto.preco_compra = precoCompraController.text.trim() as double;
    produto.descricao = descricaoController.text.trim();

    return produto;
  }


  Future atualizarProduto(Produto produto){
    produto = setCamposProduto(produto);
    return FirebaseFirestore.instance.collection("produtos").doc(produto.produtoId).update(produto.toMap());
  }
  _gotoCriarProduto(BuildContext context){
    Produto? produto;
    //push(context, NovoProduto("SalvouRetornou", true));
  }

}