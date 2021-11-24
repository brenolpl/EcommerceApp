import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'endereco.dart';

class Usuario {
  late String id;
  late String email;
  late String nome;
  late String senha;
  late String cpf;
  late DateTime dataNascimento;
  late String telefone;
  late String? endereco_id;
  late bool admin;

  Usuario();

  Usuario.fromMap(DocumentSnapshot map){
    id = map.id;
    email = map['email'];
    nome = map['nome'];
    cpf = map['cpf'];
    dataNascimento = map['dataNascimento'];
    telefone = map['telefone'];
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