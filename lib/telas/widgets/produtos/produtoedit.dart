import 'package:appflutter/common/defaultbutton.dart';
import 'package:appflutter/common/defaulteditfield.dart';
import 'package:appflutter/core/produto.dart';
import 'package:appflutter/telas/controller/carrinhocontroller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProdutoEdit extends StatelessWidget {
  Produto produto;
  //NumberFormat formatter = NumberFormat.simpleCurrency();

  ProdutoEdit(this.produto);
  Stream<QuerySnapshot> get stream => FirebaseFirestore.instance.collection("produtos").snapshots();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Produto"),
          actions: [
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  //Realizar exclusão do produto
                }
            )
          ],
        ),
        body:StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Text("deu erro");
            }

            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }

            if(snapshot.hasData){
              //_obterProduto(widget.produto)
            }

            return Form(
            //key: ProdutoEdit(produto),
              child: Container(
              padding: const EdgeInsets.all(15),
              child:
              ListView(
                children: [

                  Text("PRODUTO - ID: " + produto.produtoId, style: const TextStyle(fontSize: 18)),
                  Image.asset(
                      produto.imagePath,
                      width: 160,
                      height: 160,
                      alignment: Alignment.center),
                    SizedBox(
                        child: RaisedButton(
                            child: Text("Editar Imagem"),
                            onPressed: () {
                              //_carrinhoController.listaProdutos.add(produto);
                            },
                        )
                      ),
                  TextFormField(
                    initialValue: produto.nome,
                    decoration: InputDecoration(labelText: 'Nome'),
                  ),
                  TextFormField(
                    initialValue: produto.preco_custo.toString(),
                    decoration: InputDecoration(labelText: 'Valor de Compra'),
                  ),
                  TextFormField(
                    initialValue: produto.preco_compra.toString(),
                    decoration: InputDecoration(labelText: 'Valor de Venda'),
                  ),
                  MyStatefulWidget(),
                  TextFormField(
                    maxLines: 3,
                    maxLength: 130,
                    initialValue: produto.descricao,
                    decoration: InputDecoration(labelText: 'Descrição'),
                  ),

                  ElevatedButton(
                    child: Text("Salvar Alteração"),
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.deepOrange),
                        shape: MaterialStateProperty.all(const StadiumBorder())
                    ),
                    onPressed: () {
                      //_carrinhoController.listaProdutos.add(produto);
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
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'Seleciona Categoria';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(

      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_sharp),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Seleciona Categoria', 'Categoria1', 'Categoria2', 'Categoria3','Categoria4']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}