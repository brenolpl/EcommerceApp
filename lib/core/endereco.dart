import 'package:cloud_firestore/cloud_firestore.dart';

class Endereco {
  late String id;
  late String cep;
  late String endereco;
  late String numero;
  late String referencia;
  late String bairro;
  late String cidade;
  late String estado;
  String usuario_id = "";

  Endereco();

  Endereco.fromMap(DocumentSnapshot map){
    id = map.id;
    cep = map['cep'];
    endereco = map['endereco'];
    numero = map['numero'];
    referencia = map['referencia'];
    bairro = map['bairro'];
    cidade = map['cidade'];
    estado = map['estado'];
    if(map.data().containsKey("usuario_id")){
      usuario_id = map['usuario_id'];
    }
  }

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> data = {};
    data['cep'] = cep;
    data['endereco'] = endereco;
    data['estado'] = estado;
    data['bairro'] = bairro;
    data['numero'] = numero;
    data['referencia'] = referencia;
    data['cidade'] = cidade;
    if(usuario_id != ""){
      data['usuario_id'] = usuario_id;
    }
    return data;
  }
}