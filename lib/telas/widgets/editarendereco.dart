import 'package:appflutter/core/endereco.dart';
import 'package:appflutter/telas/controller/cadastrarenderecocontroller.dart';
import 'package:appflutter/telas/widgets/cadastrarendereco.dart';
import 'package:appflutter/util/nav.dart';
import 'package:flutter/material.dart';

class EditarEndereco extends StatefulWidget {
  Endereco endereco;

  EditarEndereco(this.endereco, {Key? key}) : super(key: key);

  @override
  _EditarEnderecoState createState() => _EditarEnderecoState();
}

class _EditarEnderecoState extends State<EditarEndereco> {
  bool readOnly = false;
  late CadastrarEnderecoController _cadastrarEnderecoController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    _cadastrarEnderecoController = CadastrarEnderecoController();
    _cadastrarEnderecoController.estado = widget.endereco.estado;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Endereço"),

      ),
      body: Container(
          margin: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Form(
                key: formKey,
                child: CadastrarEndereco(controller: _cadastrarEnderecoController, endereco: widget.endereco, readOnly: readOnly),
              ),
              !readOnly ? Container(
                width: 350,
                height: 45,
                child: ElevatedButton(
                    onPressed: () async {
                      if(formKey.currentState!.validate()){
                        _cadastrarEnderecoController.atualizarEndereco(widget.endereco).then((value) {
                          pop(context);
                        });
                      }
                    },
                    child: const Text(
                        "Salvar",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18
                      ),
                    ),
                    style:
                    ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green.withOpacity(0.90)),
                      overlayColor: MaterialStateProperty.all(Colors.cyanAccent),
                      shape: MaterialStateProperty.all(const StadiumBorder()),
                      side: MaterialStateProperty.all(const BorderSide(width: 0.2, style: BorderStyle.solid)),
                      shadowColor: MaterialStateProperty.all(Colors.black),
                    )

                ),
              ) : Container()
            ],
          )
      ),
    );
  }
}
