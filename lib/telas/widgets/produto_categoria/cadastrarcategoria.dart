import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CadastrarCategoria extends StatefulWidget {
  const CadastrarCategoria({Key? key}) : super(key: key);

  @override
  _CadastrarCategoriaState createState() => _CadastrarCategoriaState();
}

class _CadastrarCategoriaState extends State<CadastrarCategoria> {
  late TextEditingController nome;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nome = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova Categoria"),
      ),
      body: Form(
        key: formKey,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: nome,
                keyboardType: TextInputType.text,
                validator: (String? text) {
                  if (text!.isEmpty) {
                    return "O Campo é obrigatório!";
                  }
                },
                decoration: const InputDecoration(
                    labelText: "Nome",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    )),
              ),
              const SizedBox(height: 15,),
              ElevatedButton(
                onPressed: () {
                  if(formKey.currentState!.validate()){
                    _cadastrarNovaCategoria();
                    pop(context);
                  }
                },
                child: const Text("Cadastrar categoria"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  overlayColor: MaterialStateProperty.all(Colors.deepOrange),
                  shape: MaterialStateProperty.all(BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))),
                  side: MaterialStateProperty.all(const BorderSide(width: 0.1, style: BorderStyle.solid)),
                  shadowColor: MaterialStateProperty.all(Colors.black),
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  void _cadastrarNovaCategoria() async {
    await FirebaseFirestore.instance.collection("produtos_categoria").add({"nome": nome.text.trim()});
  }
}
