import 'package:appflutter/core/endereco.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/controller/cadastrarusuariocontroller.dart';
import 'package:appflutter/telas/widgets/cadastrarendereco.dart';
import 'package:appflutter/telas/widgets/editarendereco.dart';
import 'package:appflutter/telas/widgets/enderecodetail.dart';
import 'package:appflutter/telas/widgets/produtodetail.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListarEndereco extends StatefulWidget {
  Usuario? usuario;

  ListarEndereco(this.usuario, {Key? key}) : super(key: key);

  @override
  _ListarEnderecoState createState() => _ListarEnderecoState();
}

class _ListarEnderecoState extends State<ListarEndereco> {
  late Future<List<Endereco>> _enderecosFuture;
  late CollectionReference _enderecoCollection;
  late List<Endereco> enderecos;

  @override
  void initState() {
    super.initState();
    _enderecosFuture = _popularEnderecos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Endereco>>(
      // Initialize FlutterFire:
        future: _enderecosFuture,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Text("ERRO");
          }

          // Once complete, show your application
          if (snapshot.hasData) {
            enderecos = snapshot.data!;
            return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: enderecos.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                      onPressed: () {
                        push(context, EditarEndereco(enderecos[index]));
                      },
                      child: EnderecoDetail(enderecos[index]),
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

          // Otherwise, show something whilst waiting for initialization to complete
          return Container(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
            color: Colors.cyan,
          );
        });
  }

  Future<List<Endereco>> _popularEnderecos() async {
    List<Endereco> enderecosList = [];
    FirebaseFirestore.instance.collection("endereco").where("usuario_id", isEqualTo: widget.usuario!.id)
        .snapshots().listen((data) {
      for (var doc in data.docs) {
        Endereco endereco = Endereco.fromMap(doc);
        enderecosList.add(endereco);
      }
    });
    return enderecosList;
  }
}
