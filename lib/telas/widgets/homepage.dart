import 'package:appflutter/core/produto.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/widgets/carrinho/carrinho.dart';
import 'package:appflutter/telas/widgets/menu.dart';
import 'package:appflutter/telas/widgets/produtos/produto.dart';
import 'package:appflutter/telas/widgets/produtos/produtodetail.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  late Usuario usuario;

  HomePage(this.usuario, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      drawer: Menu(widget.usuario),
      appBar: AppBar(
        title: !search ? const Text("EcommerceApp") : TextField(
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
          !search?IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              push(context, Carrinho(usuario: widget.usuario));
            },
          ): Container(),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
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
                      return Container(
                        margin: const EdgeInsets.only(bottom: 7),
                        child: ElevatedButton(
                            onPressed: () {
                              push(context, ProdutoDetail(produtos[index], widget.usuario));
                            },
                            child: ProdutoWidget(produtos[index]),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white70.withOpacity(0.75)),
                              overlayColor: MaterialStateProperty.all(Colors.deepOrange),
                              shape: MaterialStateProperty.all(BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))),
                              side: MaterialStateProperty.all(const BorderSide(width: 0.1, style: BorderStyle.solid)),
                              shadowColor: MaterialStateProperty.all(Colors.black),
                                  )
                            ),
                      );
                    });
              }

              return const Center(child: CircularProgressIndicator());
            },
        ),
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
