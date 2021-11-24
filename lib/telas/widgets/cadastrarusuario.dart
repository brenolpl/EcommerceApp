
import 'package:appflutter/telas/controller/cadastrarusuariocontroller.dart';
import 'package:appflutter/telas/controller/logincontroller.dart';
import 'package:appflutter/util/businessexception.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/date_symbol_data_local.dart';

class CadastrarUsuario extends StatefulWidget {
  LoginController _loginController;

  CadastrarUsuario(this._loginController);

  @override
  _CadastrarUsuarioState createState() => _CadastrarUsuarioState();
}

class _CadastrarUsuarioState extends State<CadastrarUsuario> {
  late CadastrarUsuarioController _cadastrarUsuarioController;
  late String dropdownText;
  @override
  void initState() {
    _cadastrarUsuarioController = CadastrarUsuarioController();
    dropdownText = _cadastrarUsuarioController.estados.first;
  }

  @override
  Widget build(BuildContext context) {
    final maskCpf = MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});
    final dateMask = MaskTextInputFormatter(mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')});
    final phoneMask = MaskTextInputFormatter(mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')});
    final cepMask = MaskTextInputFormatter(mask: "#####-###", filter: {"#": RegExp(r'[0-9]')});
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar novo usuário", style: TextStyle(fontWeight: FontWeight.normal),),
      ),
      body: Form(
        key: _cadastrarUsuarioController.formKey,
        child: Container(
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Align(
               child: Text(
                 "Informações da conta",
                 textAlign: TextAlign.left,
               style: TextStyle(
                 fontSize: 17
                    )
               ),
                alignment: Alignment.centerLeft,
              ),
              TextFormField(
                controller: _cadastrarUsuarioController.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (String? text){
                  if(text!.isEmpty){
                    return "O Campo $text é obrigatório!";
                  }else if(!EmailValidator.validate(text)){
                    return "Digite um email válido!";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    )
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    )
                ),
                controller: _cadastrarUsuarioController.senhaController,
                validator: (String? text){
                    if(text!.isEmpty){
                      return "O campo $text é obrigatório";
                    }else if(!text.contains(RegExp("[A-Z0-9]"))) {
                      return "Sua senha precisa conter ao menos uma letra e um número";
                    }else if(text.length<8){
                      return "Sua senha precisa conter 8 ou mais caracteres";
                    }
                    return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              const Align(
                child: Text(
                    "Dados Pessoais",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 17
                    )
                ),
                alignment: Alignment.centerLeft,
              ),
              TextFormField(
                controller: _cadastrarUsuarioController.nomeController,
                validator: (String? text){
                  if(text!.isEmpty){
                    return "O Campo $text é obrigatório!";
                  }
                },
                decoration: const InputDecoration(
                    labelText: "Nome completo",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    )
                ),
              ),
              TextFormField(
                controller: _cadastrarUsuarioController.cpfController,
                inputFormatters: [maskCpf],
                validator: (String? text){
                  if(text!.isEmpty){
                    return "O Campo $text é obrigatório!";
                  }else if(!CPFValidator.isValid(text)){
                    return "CPF Inválido!";
                  }

                },
                decoration: const InputDecoration(
                    labelText: "CPF",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    )
                ),
              ),
              TextFormField(
                controller: _cadastrarUsuarioController.dataNascimentoController,
                inputFormatters: [dateMask],
                validator: (String? text){
                  print(text);
                  if(text != null && text.isNotEmpty){
                    try{
                      initializeDateFormatting("pt_BR", null);
                      var format = DateFormat('dd/MM/yyyy');
                      DateTime date = format.parse(text);
                      print(date);
                      if(DateTime.now().isBefore(date)){
                        return "Data de nascimento inválida!";
                      }
                    }on FormatException catch(ex){
                        businessException("unexpected", context);
                    }
                  }else if(text!.isEmpty){
                      return "O Campo $text é obrigatório!";
                  }
                },
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                    labelText: "Data de Nascimento",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    )
                ),
              ),
              TextFormField(
                controller: _cadastrarUsuarioController.telefoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [phoneMask],
                validator: (String? text){
                  if(text!.isEmpty){
                    return "O Campo $text é obrigatório!";
                  }
                },
                decoration: const InputDecoration(
                    labelText: "Telefone de contato",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    )
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Align(
                child: Text(
                    "Endereço",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 17
                    )
                ),
                alignment: Alignment.centerLeft,
              ),
              TextFormField(
                controller: _cadastrarUsuarioController.cepController,
                keyboardType: TextInputType.text,
                inputFormatters: [cepMask],
                validator: (String? text){
                  if(text!.isEmpty){
                    return "O Campo $text é obrigatório!";
                  }
                },
                decoration: const InputDecoration(
                    labelText: "CEP",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    )
                ),
              ),
              TextFormField(
                controller: _cadastrarUsuarioController.enderecoController,
                keyboardType: TextInputType.text,
                validator: (String? text){
                  if(text!.isEmpty){
                    return "O Campo $text é obrigatório!";
                  }
                },
                decoration: const InputDecoration(
                    labelText: "Endereço",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    )
                ),
              ),
              TextFormField(
                controller: _cadastrarUsuarioController.cidadeController,
                keyboardType: TextInputType.text,
                validator: (String? text){
                  if(text!.isEmpty){
                    return "O Campo $text é obrigatório!";
                  }
                },
                decoration: const InputDecoration(
                    labelText: "Cidade",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    )
                ),
              ),
              TextFormField(
                controller: _cadastrarUsuarioController.bairroController,
                keyboardType: TextInputType.text,
                validator: (String? text){
                  if(text!.isEmpty){
                    return "O Campo $text é obrigatório!";
                  }
                },
                decoration: const InputDecoration(
                    labelText: "Bairro",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    )
                ),
              ),
              TextFormField(
                controller: _cadastrarUsuarioController.numeroController,
                keyboardType: TextInputType.number,
                validator: (String? text){
                  if(text!.isEmpty){
                    return "O Campo $text é obrigatório!";
                  }
                },
                decoration: const InputDecoration(
                    labelText: "Número",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    )
                ),
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
                  });
                },
                items: _cadastrarUsuarioController.estados
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: _cadastrarUsuarioController.referenciaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Ponto de referência (opcional)",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    )
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 46,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(const StadiumBorder()),
                      backgroundColor: MaterialStateProperty.all(Colors.cyanAccent.withOpacity(0.65))
                  ),
                  child: const Text(
                    "Cadastrar",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.normal
                    ),
                  ),
                  onPressed: (){
                    _cadastrarUsuarioController.estado = dropdownText;
                    _cadastrarUsuarioController.signUp(context);
                  },
                ),
              )
            ],
          ),
          margin: const EdgeInsets.all(20),
        ),
      )
    );
  }
}
