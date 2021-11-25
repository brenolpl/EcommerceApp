import 'dart:io';

import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/widgets/editprofile.dart';
import 'package:appflutter/telas/widgets/login.dart';
import 'package:appflutter/util/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  Usuario usuario;

  Menu(this.usuario, {Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Editar Perfil"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () async {
                pop(context);
                push(context, EditProfile(widget.usuario));
              },
              enabled: !widget.usuario.admin,

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
        ),
      ),
    );
  }
}
