import 'package:appflutter/core/produto.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/controller/homepagecontroller.dart';
import 'package:appflutter/telas/widgets/carrinho.dart';
import 'package:appflutter/telas/widgets/menu.dart';
import 'package:appflutter/telas/widgets/produto.dart';
import 'package:appflutter/telas/widgets/produtoEdit.dart';
import 'package:appflutter/telas/widgets/produtodetail.dart';
import 'package:appflutter/util/nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'novoProduto.dart';

class AdmListaProduto extends StatefulWidget {
  Usuario userAdmin;
  AdmListaProduto(this.userAdmin, {Key? key}) : super(key: key);

  @override
  _AdmListaProduto createState() => _AdmListaProduto();
}

class _AdmListaProduto extends State<AdmListaProduto> {

  late Future<List<Produto>> produtosFuture;
  late List<Produto> produtos;
  late Produto produtonovo;

  @override
  void initState() {
    super.initState();
    produtosFuture = HomePageController.popular();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Menu(widget.userAdmin),
      appBar: AppBar(
        title: const Text("Lista de Produtos"),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: (){
                push(context, NovoProdutoWidget());
              }
          )
        ],

      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          push(context, NovoProdutoWidget());
        },),

      body:
          FutureBuilder<List<Produto>>(
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("ERRO");
            }
            if (snapshot.data != null) {
              produtos = snapshot.data!;
              print("PRODUTOS");
              print(produtos);

              return ListView.builder(
                  itemCount: produtos.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                        onPressed: () {
                          push(context, ProdutoEdit(produtos[index]));
                        },
                        child: detalProducts(produtos[index]),

                        style:
                          ButtonStyle(
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

  @override
  Widget detalProducts(Produto produto) {
    return Container(
      child: Row(
        children: [

          Column(
            children: [
              Image.asset(produto.imagePath, fit: BoxFit.contain, height: 160),
            ],
          ),
          Column(
            children: [
              Text("Nome: ${produto.nome}"),
              Text("Categoria: ${produto.categoria!.nome_categoria}"),
              Text("Custo: ${produto.preco_custo}"),
              Text("Venda: ${produto.preco_compra}"),

              Text("\nLucro: ${(produto.preco_compra - produto.preco_custo).toStringAsFixed(2)}")
            ],
          ),
        ],
      ),
    );
  }


  }










