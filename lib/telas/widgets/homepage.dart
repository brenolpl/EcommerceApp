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
  List<Produto> produtos = HomePageController.popular();
  late HomePageController _homePageController;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: const Text("EcommerceApp"),
      ),
      body: ListView.builder(
          itemCount: produtos.length,
          itemBuilder: (context, index) {
            return ProdutoWidget(produtos[index]);
          })
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
  @override
  void initState() {
    super.initState();
    _homePageController = HomePageController(widget.usuario);
  }
}
