import 'package:appflutter/core/produto.dart';
import 'package:appflutter/core/produto_categoria.dart';
import 'package:appflutter/telas/controller/cadastrarprodutocontroller.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProdutoEdit extends StatefulWidget {
  Produto produto;

  ProdutoEdit(this.produto);

  @override
  State<ProdutoEdit> createState() => _ProdutoEditState();
}

class _ProdutoEditState extends State<ProdutoEdit> {
  Stream<QuerySnapshot> get streamProduto => FirebaseFirestore.instance.collection("produtos").snapshots();
  Stream<QuerySnapshot> get streamCategorias => FirebaseFirestore.instance.collection("produtos_categoria").snapshots();
  late final CadastrarProdutoController _cadastrarProdutoController;

  bool hasLoaded = false;
  List<ProdutoCategoria> categorias = [];
  late ProdutoCategoria dropdownValue;


  @override
  void initState() {
    _cadastrarProdutoController = CadastrarProdutoController();
    _cadastrarProdutoController.nomeController.value = TextEditingValue(text: widget.produto.nome);
    _cadastrarProdutoController.precoCustoController.value = TextEditingValue(text: widget.produto.preco_custo.toString());
    _cadastrarProdutoController.precoCompraController.value = TextEditingValue(text: widget.produto.preco_compra.toString());
    _cadastrarProdutoController.descricaoController.value = TextEditingValue(text: widget.produto.descricao);
    _cadastrarProdutoController.imagePathController.value = TextEditingValue(text: widget.produto.imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Produto"),
          actions: [
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: (){
                  _excluirProduto();
                  pop(context);
                }
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: streamProduto,
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return const Text("deu erro");
            }

            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }

            _obterProduto(snapshot.data!);

            return Form(
              key: _cadastrarProdutoController.formKey,
              child: Container(
              padding: const EdgeInsets.all(15),
              child:
              ListView(
                children: [

                  Text("PRODUTO - ID: " + widget.produto.id, style: const TextStyle(fontSize: 18)),
                  Image.asset(
                      widget.produto.imagePath,
                      width: 160,
                      height: 160,
                      alignment: Alignment.center),
                  TextFormField(
                    controller: _cadastrarProdutoController.imagePathController,
                    decoration: const InputDecoration(labelText: 'Caminho da imagem'),
                  ),
                  TextFormField(
                    controller: _cadastrarProdutoController.nomeController,
                    decoration: const InputDecoration(labelText: 'Nome'),
                  ),
                  TextFormField(
                    controller: _cadastrarProdutoController.precoCustoController,
                    decoration: const InputDecoration(labelText: 'Valor de Compra'),
                  ),
                  TextFormField(
                    controller: _cadastrarProdutoController.precoCompraController,
                    decoration: const InputDecoration(labelText: 'Valor de Venda'),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: streamCategorias,
                    builder: (context, snapshot){
                      if(snapshot.hasError){
                        return const Text("error");
                      }

                      if(!snapshot.hasData){
                        return const Center(child: CircularProgressIndicator());
                      }

                      _obterCategorias(snapshot.data!);

                      return DropdownButtonFormField<ProdutoCategoria>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (ProdutoCategoria? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            _cadastrarProdutoController.categoriaController = dropdownValue;
                          });
                        },
                        items: categorias
                            .map<DropdownMenuItem<ProdutoCategoria>>((ProdutoCategoria value) {
                          return DropdownMenuItem<ProdutoCategoria>(
                            value: value,
                            child: Text(value.nome),
                          );
                        }).toList(),
                      );
                    }
                  ),
                  TextFormField(
                    controller: _cadastrarProdutoController.descricaoController,
                    maxLines: 3,
                    maxLength: 130,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                  ),

                  ElevatedButton(
                    child: const Text("Salvar Alteração"),
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.deepOrange),
                        shape: MaterialStateProperty.all(const StadiumBorder())
                    ),
                    onPressed: () {
                      _atualizarProduto(widget.produto);
                    },
                  )
                ],
              ),
            ),
            );
          }
        ),
    );
  }

  void _obterProduto(QuerySnapshot data){
    for(DocumentSnapshot doc in data.docs){
      if(doc.id == widget.produto.id){
        widget.produto = Produto.fromMap(doc);
      }
    }
  }

  void _obterCategorias(QuerySnapshot data) {
    categorias = data.docs.map((doc) => ProdutoCategoria.fromMap(doc)).toList();
    if(!hasLoaded){
      hasLoaded = true;
      for(ProdutoCategoria categoria in categorias){
        if(categoria.id == widget.produto.categoria_id){
          dropdownValue = categoria;
          _cadastrarProdutoController.categoriaController = dropdownValue;
        }
      }

    }
  }

  atualizarProduto(Produto produto){

  }

  void _excluirProduto() async {
    await _cadastrarProdutoController.produtoCollection.doc(widget.produto.id).delete();
  }

  void _atualizarProduto(Produto produto) async {
    produto = _cadastrarProdutoController.setCamposProduto(produto);
    await _cadastrarProdutoController.produtoCollection.doc(widget.produto.id).update(produto.toMap());
  }
}