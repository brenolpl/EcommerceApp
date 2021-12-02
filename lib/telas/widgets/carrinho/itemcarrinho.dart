import 'package:appflutter/core/carrinho.dart';
import 'package:appflutter/core/produto.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemCarrinho extends StatefulWidget {
  Produto produto;
  CarrinhoCore itemCarrinho;
  Usuario usuario;
  ItemCarrinho(this.produto, this.itemCarrinho, this.usuario, {Key? key}) : super(key: key);

  @override
  _ItemCarrinhoState createState() => _ItemCarrinhoState();
}

class _ItemCarrinhoState extends State<ItemCarrinho> {
  List<int> quantidade = [0, 1, 2, 3, 4, 5];
  late int dropdownValue;
  late double _total;

  Stream<QuerySnapshot> get stream => FirebaseFirestore.instance.collection("users").doc(widget.usuario.id).collection("carrinho").snapshots();

  NumberFormat formatter = NumberFormat.simpleCurrency();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return const Text("error");
        }

        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator());
        }

        _obterItemCarrinho(snapshot.data!);

        return Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 3,
              child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(widget.produto.imagePath, fit: BoxFit.contain, width: 100, height: 100,)
                      )
            ),
            Expanded(
              flex: 4,
              child: Text(widget.produto.nome, overflow: TextOverflow.ellipsis,),
            ),
            Expanded(
              child: DropdownButtonFormField<int>(
                value: dropdownValue,
                onChanged: (int? newValue) {
                  setState(() {
                    if(newValue == 0){
                      showAlertDialog(context);
                    }else {
                      _atualizarQuantidade(newValue!);
                    }
                  });
                },
                items: quantidade
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              )
            ),
            Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                      formatter.format(widget.itemCarrinho.total).toString()
                  ),
                )
            )
          ],
        );
      }
    );
  }

  void _obterItemCarrinho(QuerySnapshot data) {
    for(DocumentSnapshot doc in data.docs){
      if(doc.id == widget.itemCarrinho.id){
        widget.itemCarrinho = CarrinhoCore.fromMap(doc);
        dropdownValue = widget.itemCarrinho.quantidade;
        _total = widget.produto.preco_compra * dropdownValue;
        break;
      }
    }
  }

  void _atualizarQuantidade(int i) {
    widget.itemCarrinho.quantidade = i;
    widget.itemCarrinho.total = widget.produto.preco_compra * i;
    FirebaseFirestore.instance.collection("users").doc(widget.usuario.id).collection("carrinho").doc(widget.itemCarrinho.id).update(widget.itemCarrinho.toMap());
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancelar"),
      onPressed:  () {
        pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Excluir"),
      onPressed:  () {
        FirebaseFirestore.instance.collection("users").doc(widget.usuario.id).collection("carrinho").doc(widget.itemCarrinho.id).delete();
        pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Excluir item"),
      content: const Text("Tem certeza que deseja remover este item do carrinho?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
