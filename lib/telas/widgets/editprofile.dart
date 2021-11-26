import 'package:appflutter/core/usuario.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  Usuario usuario;

  EditProfile(this.usuario);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu Perfil"),
      ),
    );
  }
}
