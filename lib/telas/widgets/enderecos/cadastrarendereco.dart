import 'package:appflutter/core/endereco.dart';
import 'package:appflutter/telas/controller/cadastrarenderecocontroller.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastrarEndereco extends StatefulWidget {
  Endereco? endereco;
  bool readOnly;
  late CadastrarEnderecoController cadastrarEnderecoController;

  CadastrarEndereco({Key? key, controller, this.endereco, this.readOnly = false}) : super(key: key){
    if(controller == null) {
      cadastrarEnderecoController = CadastrarEnderecoController();
    }else{
      cadastrarEnderecoController = controller;
    }
    if(!readOnly){
      cadastrarEnderecoController.estado = cadastrarEnderecoController.estados.first;
    }
  }

  @override
  State<CadastrarEndereco> createState() => _CadastrarEnderecoState();
}

class _CadastrarEnderecoState extends State<CadastrarEndereco> {
  final cepMask = MaskTextInputFormatter(mask: "#####-###", filter: {"#": RegExp(r'[0-9]')});
  late String dropdownText;
  @override

  void initState() {
    super.initState();
    dropdownText = widget.cadastrarEnderecoController.estados.first;
    if(widget.endereco != null){
      widget.cadastrarEnderecoController.cepController.value = TextEditingValue(text: widget.endereco!.cep);
      widget.cadastrarEnderecoController.enderecoController.value = TextEditingValue(text: widget.endereco!.endereco);
      widget.cadastrarEnderecoController.cidadeController.value = TextEditingValue(text: widget.endereco!.cidade);
      widget.cadastrarEnderecoController.bairroController.value = TextEditingValue(text: widget.endereco!.bairro);
      widget.cadastrarEnderecoController.numeroController.value = TextEditingValue(text: widget.endereco!.numero);
      widget.cadastrarEnderecoController.referenciaController.value = TextEditingValue(text: widget.endereco!.referencia);
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
          controller: widget.cadastrarEnderecoController.cepController,
          readOnly: widget.readOnly,
          keyboardType: TextInputType.text,
          inputFormatters: [cepMask],
          validator: (String? text) {
            if (text!.isEmpty) {
              return "O Campo é obrigatório!";
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
          controller: widget.cadastrarEnderecoController.enderecoController,
          readOnly: widget.readOnly,
          keyboardType: TextInputType.text,
          validator: (String? text) {
            if (text!.isEmpty) {
              return "O Campo é obrigatório!";
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
          controller: widget.cadastrarEnderecoController.cidadeController,
          readOnly: widget.readOnly,
          keyboardType: TextInputType.text,
          validator: (String? text) {
            if (text!.isEmpty) {
              return "O Campo é obrigatório!";
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
          controller: widget.cadastrarEnderecoController.bairroController,
          readOnly: widget.readOnly,
          keyboardType: TextInputType.text,
          validator: (String? text) {
            if (text!.isEmpty) {
              return "O Campo é obrigatório!";
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
          controller: widget.cadastrarEnderecoController.numeroController,
          readOnly: widget.readOnly,
          keyboardType: TextInputType.number,
          validator: (String? text) {
            if (text!.isEmpty) {
              return "O Campo é obrigatório!";
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
              widget.cadastrarEnderecoController.estado = dropdownText;
            });
          },
          items: widget.cadastrarEnderecoController.estados
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        TextFormField(
          controller: widget.cadastrarEnderecoController.referenciaController,
          readOnly: widget.readOnly,
          keyboardType: TextInputType.text,
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
