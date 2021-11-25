import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page, {bool replace = false}){
  if(replace){
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => page));
  }
  return Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => page));
}

void pop(BuildContext context, {String mensagem = ""}){
  if(mensagem.isEmpty){
    Navigator.of(context).pop();
  }else{
    Navigator.pop(context, mensagem);
  }
}