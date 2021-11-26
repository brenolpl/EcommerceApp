import 'package:appflutter/core/endereco.dart';
import 'package:appflutter/telas/controller/cadastrarusuariocontroller.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastrarEndereco extends StatefulWidget {
  CadastrarUsuarioController _cadastrarUsuarioController;
  Endereco? endereco;

  CadastrarEndereco(this._cadastrarUsuarioController, {this.endereco});

  @override
  State<CadastrarEndereco> createState() => _CadastrarEnderecoState();
}

class _CadastrarEnderecoState extends State<CadastrarEndereco> {
  final cepMask = MaskTextInputFormatter(mask: "#####-###", filter: {"#": RegExp(r'[0-9]')});
  late String dropdownText;
  @override

  void initState() {
    super.initState();
    dropdownText = widget._cadastrarUsuarioController.estados.first;
    if(widget.endereco != null){
      widget._cadastrarUsuarioController.cepController.value = TextEditingValue(text: widget.endereco!.cep);
      widget._cadastrarUsuarioController.enderecoController.value = TextEditingValue(text: widget.endereco!.endereco);
      widget._cadastrarUsuarioController.cidadeController.value = TextEditingValue(text: widget.endereco!.cidade);
      widget._cadastrarUsuarioController.bairroController.value = TextEditingValue(text: widget.endereco!.bairro);
      widget._cadastrarUsuarioController.numeroController.value = TextEditingValue(text: widget.endereco!.numero);
      widget._cadastrarUsuarioController.referenciaController.value = TextEditingValue(text: widget.endereco!.referencia);
      dropdownText = widget.endereco!.estado;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        TextFormField(
          controller: widget._cadastrarUsuarioController.cepController,
          keyboardType: TextInputType.text,
          inputFormatters: [cepMask],
          validator: (String? text) {
            if (text!.isEmpty) {
              return "O Campo $text é obrigatório!";
            }
          },
          decoration: const InputDecoration(
              labelText: "CEP",
              labelStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              )),
        ),
        TextFormField(
          controller: widget._cadastrarUsuarioController.enderecoController,
          keyboardType: TextInputType.text,
          validator: (String? text) {
            if (text!.isEmpty) {
              return "O Campo $text é obrigatório!";
            }
          },
          decoration: const InputDecoration(
              labelText: "Endereço",
              labelStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              )),
        ),
        TextFormField(
          controller: widget._cadastrarUsuarioController.cidadeController,
          keyboardType: TextInputType.text,
          validator: (String? text) {
            if (text!.isEmpty) {
              return "O Campo $text é obrigatório!";
            }
          },
          decoration: const InputDecoration(
              labelText: "Cidade",
              labelStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              )),
        ),
        TextFormField(
          controller: widget._cadastrarUsuarioController.bairroController,
          keyboardType: TextInputType.text,
          validator: (String? text) {
            if (text!.isEmpty) {
              return "O Campo $text é obrigatório!";
            }
          },
          decoration: const InputDecoration(
              labelText: "Bairro",
              labelStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              )),
        ),
        TextFormField(
          controller: widget._cadastrarUsuarioController.numeroController,
          keyboardType: TextInputType.number,
          validator: (String? text) {
            if (text!.isEmpty) {
              return "O Campo $text é obrigatório!";
            }
          },
          decoration: const InputDecoration(
              labelText: "Número",
              labelStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              )),
        ),
        DropdownButtonFormField<String>(
          value: dropdownText,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          onChanged: (String? newValue) {
            setState(() {
              dropdownText = newValue!;
              widget._cadastrarUsuarioController.estado = dropdownText;
            });
          },
          items: widget._cadastrarUsuarioController.estados
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        TextFormField(
          controller: widget._cadastrarUsuarioController.referenciaController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              labelText: "Ponto de referência (opcional)",
              labelStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              )),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }


}
