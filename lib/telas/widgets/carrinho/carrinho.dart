import 'package:appflutter/core/carrinho.dart';
import 'package:appflutter/core/comprasusuario.dart';
import 'package:appflutter/core/endereco.dart';
import 'package:appflutter/core/itemcompra.dart';
import 'package:appflutter/core/produto.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/widgets/enderecos/novoendereco.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'itemcarrinho.dart';

class Carrinho extends StatefulWidget {
  Usuario? usuario;
  Carrinho({this.usuario});

  @override
  _CarrinhoState createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  NumberFormat formatter = NumberFormat.simpleCurrency();
  late List<String> produtosId;
  late List<Produto> produtos;
  late List<DocumentSnapshot> produtosReference;
  late List<CarrinhoCore> itensCarrinho;
  late double total;
  bool hasLoaded = false;
  late Endereco dropdownValue;
  late List<Endereco> enderecos;
  DocumentReference get user => FirebaseFirestore.instance.collection("users").doc(widget.usuario!.id);
  Stream<QuerySnapshot> get streamEndereco => FirebaseFirestore.instance.collection("endereco").where("usuario_id", isEqualTo: widget.usuario!.id).snapshots();
  Stream<QuerySnapshot> get streamCarrinho => user.collection("carrinho").snapshots();
  Stream<QuerySnapshot> get streamProdutos => FirebaseFirestore.instance.collection("produtos").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: streamCarrinho,
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Text("error");
          }

          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }

          _obterCarrinho(snapshot.data!);

          return StreamBuilder<QuerySnapshot>(
            stream: streamProdutos,
            builder: (context, snapshot){
              if(snapshot.hasError){
                return const Text("error");
              }

              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator());
              }

              _obterProdutos(snapshot.data!);

              return _body();
            }
          );
        },
      ),
    );
  }

  _body() {
    if(produtos.isEmpty){
      return const Center(
        child: Text("Carrinho Vazio", textAlign: TextAlign.center, style: TextStyle(
            fontSize: 20
          )
        )
      );
    }else if(produtos.isNotEmpty){
      return Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text("Selecione o endereço de envio: "),
            StreamBuilder<QuerySnapshot>(
              stream: streamEndereco,
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  return const Text("error");
                }

                if(!snapshot.hasData){
                  return const CircularProgressIndicator();
                }

                _obterEnderecos(snapshot.data!);

                if(enderecos.isEmpty){
                  return ElevatedButton(
                    child: const Text("Cadastrar Endereço"),
                    onPressed: (){
                      push(context, NovoEndereco(widget.usuario!));
                    },
                  );
                }

                return DropdownButton<Endereco>(
                  value: dropdownValue,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  onChanged: (Endereco? newValue) {
                    setState(() {
                      dropdownValue = newValue!;

                    });
                  },
                  items: enderecos
                      .map<DropdownMenuItem<Endereco>>((Endereco value) {
                    return DropdownMenuItem<Endereco>(
                      value: value,
                      child: Text(value.numero + ", " + value.endereco + ", "+ value.bairro, overflow: TextOverflow.ellipsis,),
                    );
                  }).toList(),
                );
              }
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: produtos.length,
                itemBuilder: (context, index){
                  return ItemCarrinho(produtos[index], itensCarrinho[index], widget.usuario!);
                }),
            ElevatedButton(
              child: Text("Finalizar Compra: " + formatter.format(total)),
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.deepOrange),
                  shape: MaterialStateProperty.all(const StadiumBorder())
              ),
              onPressed: () {
                _finalizarCompra();
                pop(context);
              },

            ),
          ],
        ),
      );
    }else {
      return const Text("erro");
    }
  }

  void _obterCarrinho(QuerySnapshot data) {
    itensCarrinho = data.docs.map((doc) => CarrinhoCore.fromMap(doc)).toList();
    produtosId = itensCarrinho.map((item) => item.produto_id).toList();
  }

  void _obterProdutos(QuerySnapshot data) {
    produtos = [];
    for(DocumentSnapshot doc in data.docs){
      produtosReference = data.docs;
      Produto produto = Produto.fromMap(doc);
      if(produtosId.contains(produto.id)){
        produtos.add(produto);
      }
    }
    _obterTotalProdutos();
  }

  void _obterTotalProdutos(){
    total = 0;
    for(CarrinhoCore item in itensCarrinho){
      total += item.total;
    }
  }

  void _finalizarCompra() async {
    ComprasUsuario compra = ComprasUsuario(widget.usuario!.id, Timestamp.now(), total);
    await FirebaseFirestore.instance.collection("compras_usuario").add(compra.toMap()).then((doc) async {
      for(int i = 0; i < produtos.length; i++){
        ItemCompra item = ItemCompra(itensCarrinho[i].quantidade, produtos[i].id);
        item.compra_usuario_id = doc.id;
        item.produto = produtosReference[i];
        await FirebaseFirestore.instance.collection("itens_compra").add(item.toMap());
      }
      await doc.collection("endereco_envio").add(dropdownValue.toMap());
    });
    
    await FirebaseFirestore.instance.collection("users").doc(widget.usuario!.id).collection("carrinho").get().then((data){
      for(DocumentSnapshot doc in data.docs){
        doc.reference.delete();
      }
    });
  }

  void _obterEnderecos(QuerySnapshot data) {
    enderecos = data.docs.map((doc) => Endereco.fromMap(doc)).toList();
    if(enderecos.isNotEmpty && !hasLoaded){
      dropdownValue = enderecos.first;
      hasLoaded = true;
    }
  }
}
