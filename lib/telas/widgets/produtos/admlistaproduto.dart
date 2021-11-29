import 'package:appflutter/core/produto.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/controller/carrinhocontroller.dart';
import 'package:appflutter/telas/widgets/menu.dart';
import 'package:appflutter/telas/widgets/produtos/admprodutodetail.dart';
import 'package:appflutter/telas/widgets/produtos/novoproduto.dart';
import 'package:appflutter/telas/widgets/produtos/produtoedit.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdmListaProduto extends StatefulWidget {
  late Usuario userAdmin;

  AdmListaProduto(this.userAdmin, {Key? key}) : super(key: key);

  @override
  _AdmListaProdutoState createState() => _AdmListaProdutoState();
}

class _AdmListaProdutoState extends State<AdmListaProduto> {
  late Future<List<Produto>> produtosFuture;
  late TextEditingController _searchController;
  late List<Produto> produtos;
  Icon icon = const Icon(Icons.search);
  bool search = false;

  Stream<QuerySnapshot> get stream => FirebaseFirestore.instance.collection("produtos").snapshots();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(widget.userAdmin, CarrinhoController()),
      appBar: AppBar(
        title: !search ? const Text("Lista de Produtos") : TextField(
          style: const TextStyle(
              color: Colors.white
          ),
          controller: _searchController,
          onSubmitted: (String? text){
            if(text != null && text.isNotEmpty){
              _pesquisarProduto(text);
              setState((){});
            }
          },
          decoration: const InputDecoration(
              hintText: 'procurar produto',
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              )
          ),
        ),
        actions: [
          IconButton(
            icon: icon,
            onPressed: (){
              search = !search;
              if(search){
                icon = const Icon(Icons.cancel);
                _searchController.value = const TextEditingValue(text: "");
              }else{
                icon = const Icon(Icons.search);
              }
              setState((){});
            },
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          push(context, NovoProduto());
        },),
      body: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("ERRO");
          }
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            if(!search) _obterProdutos(snapshot.data!);
            return ListView.builder(
                itemCount: produtos.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                      onPressed: () {
                        push(context, ProdutoEdit(produtos[index]));

                      },
                      child: AdmProdutoDetail(produtos[index]),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white70.withOpacity(0.75)),
                        overlayColor: MaterialStateProperty.all(Colors.deepOrange),
                        shape: MaterialStateProperty.all(BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))),
                        side: MaterialStateProperty.all(const BorderSide(width: 0.1, style: BorderStyle.solid)),
                        shadowColor: MaterialStateProperty.all(Colors.black),
                      )
                  );
                });
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _obterProdutos(QuerySnapshot data){
    produtos = data.docs.map((doc) => Produto.fromMap(doc)).toList();
  }

  _pesquisarProduto(String text) {
    FirebaseFirestore.instance.collection("produtos")
        .snapshots()
        .listen((data) {
      List<Produto> produtosList = [];
      for(DocumentSnapshot doc in data.docs){
        if(doc['nome'].toString().toLowerCase().contains(text.toLowerCase())){
          produtosList.add(Produto.fromMap(doc));
        }
      }
      produtos = produtosList;
    });
  }



}
