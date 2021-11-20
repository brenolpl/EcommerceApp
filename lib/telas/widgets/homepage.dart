import 'package:appflutter/core/produto.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/controller/homepagecontroller.dart';
import 'package:appflutter/telas/widgets/menu.dart';
import 'package:appflutter/telas/widgets/produto.dart';
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
  late List<Produto> produtos;

  @override
  void initState() {
    super.initState();
    produtosFuture = HomePageController.popular();
    _homePageController = HomePageController(widget.usuario);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Menu(),
        appBar: AppBar(
          title: const Text("EcommerceApp"),
        ),
        body: FutureBuilder<List<Produto>>(
          builder: (context, snapshot) {
              if(snapshot.hasError){
                  return Text("ERRO");
              }
              if(snapshot.data !=null) {
                produtos = snapshot.data!;
                print("PRODUTOS");
                print(produtos);
                return ListView.builder(
                    itemCount: produtos.length,
                    itemBuilder: (context, index) {
                      return ProdutoWidget(produtos[index]);
                    });
              }

              return Expanded(child: CircularProgressIndicator());
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
