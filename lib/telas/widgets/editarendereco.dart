import 'package:appflutter/core/endereco.dart';
import 'package:appflutter/telas/controller/cadastrarusuariocontroller.dart';
import 'package:appflutter/telas/widgets/cadastrarendereco.dart';
import 'package:flutter/material.dart';

class EditarEndereco extends StatefulWidget {
  Endereco endereco;

  EditarEndereco(this.endereco, {Key? key}) : super(key: key);

  @override
  _EditarEnderecoState createState() => _EditarEnderecoState();
}

class _EditarEnderecoState extends State<EditarEndereco> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Endereço")
      ),
      body: Container(
          margin: EdgeInsets.all(20),
          child: CadastrarEndereco(CadastrarUsuarioController(), endereco: widget.endereco)
      ),
    );
  }
}
