import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/controller/cadastrarenderecocontroller.dart';
import 'package:appflutter/telas/widgets/cadastrarendereco.dart';
import 'package:appflutter/util/nav.dart';
import 'package:flutter/material.dart';

class NovoEndereco extends StatefulWidget {
  Usuario usuario;
  NovoEndereco(this.usuario, {Key? key}) : super(key: key);

  @override
  _NovoEnderecoState createState() => _NovoEnderecoState();
}

class _NovoEnderecoState extends State<NovoEndereco> {
  late CadastrarEnderecoController _cadastrarEnderecoController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _cadastrarEnderecoController = CadastrarEnderecoController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar novo endereço"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              CadastrarEndereco(controller: _cadastrarEnderecoController),
              ElevatedButton(
                onPressed: (){
                  if(formKey.currentState!.validate()) {
                    _cadastrarEnderecoController.cadastrarNovoEndereco(
                        widget.usuario).then((value) {
                          pop(context);
                    });
                  }
                },
                child: const Text("Novo Endereço"),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(const StadiumBorder())
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
