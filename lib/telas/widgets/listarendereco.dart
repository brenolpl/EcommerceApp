import 'package:appflutter/core/endereco.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/controller/cadastrarenderecocontroller.dart';
import 'package:appflutter/telas/widgets/editarendereco.dart';
import 'package:appflutter/telas/widgets/enderecodetail.dart';
import 'package:appflutter/telas/widgets/novoendereco.dart';
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
  Stream<QuerySnapshot> get stream => FirebaseFirestore.instance.collection("endereco").snapshots();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }

          if(snapshot.hasError){
            return const Text("error");
          }

          _obterEnderecos(snapshot.data!);

          if(snapshot.hasData){
            return RefreshIndicator(
                child: Column(
                  children: [
                    Align(
                        child: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: (){
                              push(context, NovoEndereco(widget.usuario));
                            }
                        ),
                        alignment: Alignment.centerRight
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: enderecos.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 300,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          push(context, EditarEndereco(enderecos[index]));
                                        },
                                        child: EnderecoDetail(enderecos[index]),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.white70.withOpacity(0.75)),
                                          overlayColor: MaterialStateProperty.all(Colors.deepOrange),
                                          shape: MaterialStateProperty.all(BeveledRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                          shadowColor: MaterialStateProperty.all(Colors.black),
                                        )
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        await CadastrarEnderecoController.excluirEndereco(enderecos[index]);
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                      )
                                  )
                                ],
                              ),
                              const SizedBox(height: 10)
                            ],
                          );
                        }),
                  ],
                ),
                onRefresh: () => _obterEnderecos(snapshot.data!)
            );
          }
          return Text("Something went wrong");
        }
        );
  }

  _obterEnderecos(QuerySnapshot data) {
    enderecos = [];
    for(DocumentSnapshot doc in data.docs){
      if(doc["usuario_id"] == widget.usuario.id){
        enderecos.add(Endereco.fromMap(doc));
      }
    }
  }
}
