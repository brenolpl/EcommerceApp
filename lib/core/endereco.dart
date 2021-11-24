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
  late String? usuario_id;

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
  }
}