import 'package:firebase_auth/firebase_auth.dart';

class Usuario {
  late String id;
  late String email;
  late String nome;
  late String imagePath;

  Usuario.fromMap(Map<String, dynamic> map){
    email = map['email'];
    nome = map['nome'];
  }

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> data = {};
    data['email'] = this.email;
    return data;
  }

  // Future<Usuario> getFutureUser(){
  //
  // }
}