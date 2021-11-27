import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void businessException(String ex, BuildContext? context){
  String mensagem;
  switch(ex){
    case 'invalid':
      mensagem = "Usuario inválido";
      break;
    case 'not-found':
      mensagem = "Usuario não cadastrado";
      break;
    case 'weak-password':
      mensagem = "Senha muito fraca";
      break;
    case 'email-used':
      mensagem = "Email em uso";
      break;
    case 'signup-failed':
      mensagem = "Erro ao criar usuario";
      break;
    default:
      mensagem = "Ocorreu um erro inesperado, contate o administrado!";
      break;
  }
  Fluttertoast.showToast(msg: mensagem, gravity: ToastGravity.CENTER, textColor: Colors.red, backgroundColor: Colors.black12, timeInSecForIosWeb: 10);
}