import 'package:appflutter/core/endereco.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/streams/enderecosbloc.dart';
import 'package:appflutter/telas/controller/cadastrarenderecocontroller.dart';
import 'package:appflutter/telas/controller/cadastrarusuariocontroller.dart';
import 'package:appflutter/telas/widgets/cadastrarendereco.dart';
import 'package:appflutter/telas/widgets/editarendereco.dart';
import 'package:appflutter/telas/widgets/enderecodetail.dart';
import 'package:appflutter/telas/widgets/novoendereco.dart';
import 'package:appflutter/telas/widgets/produtodetail.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListarEndereco extends StatefulWidget {
  Usuario usuario;

  ListarEndereco(this.usuario, {Key? key}) : super(key: key);

  @override
  _ListarEnderecoState createState() => _ListarEnderecoState();
}

class _ListarEnderecoState extends State<ListarEndereco> {
  late List<Endereco> enderecos;
  final _enderecosBloc = EnderecosBloc();

  @override
  void initState() {
    super.initState();
    _enderecosBloc.obterEnderecos(widget.usuario);
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Endereco>>(
        stream: _enderecosBloc.stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return const CircularProgressIndicator();
          }

          if(snapshot.hasError){
            return const Text("error");
          }

          enderecos = snapshot.data!;

          if(snapshot.hasData){
            print("TESTE");
            print(snapshot.data);
            return RefreshIndicator(
                child: Column(
                  children: [
                    Align(
                        child: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: (){
                              push(context, NovoEndereco(widget.usuario, _enderecosBloc));
                            }
                        ),
                        alignment: Alignment.centerRight
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: enderecos.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                width: 300,
                                child: ElevatedButton(
                                    onPressed: () {
                                      push(context, EditarEndereco(enderecos[index], _enderecosBloc, widget.usuario));
                                    },
                                    child: EnderecoDetail(enderecos[index]),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.white70.withOpacity(0.75)),
                                      overlayColor: MaterialStateProperty.all(Colors.cyanAccent),
                                      shape: MaterialStateProperty.all(BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))),
                                      side: MaterialStateProperty.all(const BorderSide(width: 0.1, style: BorderStyle.solid)),
                                      shadowColor: MaterialStateProperty.all(Colors.black),
                                    )
                                ),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    await CadastrarEnderecoController.excluirEndereco(enderecos[index]).then((value) {
                                      enderecos.remove(enderecos[index]);
                                      _enderecosBloc.obterEnderecos(widget.usuario).then((value) {
                                        enderecos = value;
                                      });
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  )
                              )
                            ],
                          );
                        }),
                  ],
                ),
                onRefresh: () => _enderecosBloc.obterEnderecos(widget.usuario)
            );
          }
          return Text("Something went wrong");
        }
        );
  }

  Future<List<Endereco>> _popularEnderecos() async {
    List<Endereco> enderecosList = [];
    FirebaseFirestore.instance.collection("endereco").where("usuario_id", isEqualTo: widget.usuario.id)
        .snapshots().listen((data) {
      for (var doc in data.docs) {
        Endereco endereco = Endereco.fromMap(doc);
        enderecosList.add(endereco);
      }
    });
    return enderecosList;
  }

  @override
  void dispose() {
    super.dispose();
    _enderecosBloc.dispose();
  }
}
