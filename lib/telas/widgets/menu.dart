import 'dart:io';

import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/widgets/cadastrarusuario.dart';
import 'package:appflutter/telas/widgets/listarcategorias.dart';
import 'package:appflutter/telas/widgets/login.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  Usuario usuario;

  Menu(this.usuario, {Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Stream<QuerySnapshot> get stream => FirebaseFirestore.instance.collection("users").snapshots();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return const CircularProgressIndicator();
            }

            if(snapshot.hasError){
              return const Text("error");
            }

            if(snapshot.hasData){
              _atualizarUsuarioLogado(snapshot.data!);
              return ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text("Minha conta"),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () async {
                      pop(context);
                      push(context, CadastrarUsuario("Meu perfil", true, usuario: widget.usuario));
                    },
                    enabled: !widget.usuario.admin,

                  ),
                  ListTile(
                    leading: const Icon(Icons.category),
                    title: const Text("Categorias"),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () async {
                      pop(context);
                      push(context, ListarCategorias(widget.usuario));
                    }

                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text("Sair"),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      pop(context);
                      FirebaseAuth.instance.signOut();
                      push(context, const Login(), replace: true);
                    },
                  )
                ],
              );
            }
            return const CircularProgressIndicator();
          }
        ),
      ),
    );
  }

  _atualizarUsuarioLogado(QuerySnapshot data) {
    for(DocumentSnapshot doc in data.docs){
      if(doc.id == widget.usuario.id){
        widget.usuario = Usuario.fromMap(doc);
        break;
      }
    }
  }
}
