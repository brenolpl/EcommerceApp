import 'package:appflutter/core/produto.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/controller/carrinhocontroller.dart';
import 'package:appflutter/telas/controller/homepagecontroller.dart';
import 'package:appflutter/telas/widgets/carrinho.dart';
import 'package:appflutter/telas/widgets/menu.dart';
import 'package:appflutter/telas/widgets/produto.dart';
import 'package:appflutter/telas/widgets/produtodetail.dart';
import 'package:appflutter/util/nav.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  late Usuario usuario;

  HomePage(this.usuario, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Produto>> produtosFuture;
  late HomePageController _homePageController;
  late CarrinhoController _carrinhoController;
  late List<Produto> produtos;

  @override
  void initState() {
    super.initState();
    produtosFuture = HomePageController.popular();
    _homePageController = HomePageController(widget.usuario);
    _carrinhoController = CarrinhoController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(widget.usuario),
      appBar: AppBar(
        title: const Text("EcommerceApp"),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () {setState((){});}),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              push(context, Carrinho(_carrinhoController));
            },
          )
        ],
      ),
      body: FutureBuilder<List<Produto>>(
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("ERRO");
            }
            if (snapshot.hasData) {
              produtos = snapshot.data!;
              print("PRODUTOS");
              print(produtos);
              return ListView.builder(
                  itemCount: produtos.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                        onPressed: () {
                          push(context, ProdutoDetail(produtos[index], _carrinhoController));
                        },
                        child: ProdutoWidget(produtos[index]),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white70.withOpacity(0.75)),
                          overlayColor: MaterialStateProperty.all(Colors.cyanAccent),
                          shape: MaterialStateProperty.all(BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))),
                          side: MaterialStateProperty.all(const BorderSide(width: 0.1, style: BorderStyle.solid)),
                          shadowColor: MaterialStateProperty.all(Colors.black),
                              )
                        );
                  });
            }

            return const Center(child: CircularProgressIndicator());
          },
          future: produtosFuture
      ),
    );
  }

/*
FutureBuilder(
        // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Text("ERRO");
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return Inicio();
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Text("CARREGANDO CARAI PERAI");
          }),
 */
}
