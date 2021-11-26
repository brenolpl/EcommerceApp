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
  bool readOnly = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Endereço"),
        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  readOnly = !readOnly;
                });
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: Container(
          margin: const EdgeInsets.all(20),
          child: ListView(
            children: [
              CadastrarEndereco(endereco: widget.endereco, readOnly: readOnly),
              !readOnly ? Container(
                width: 350,
                height: 45,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        readOnly = true;
                      });
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
