import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CadastrarEnderecoController {
  late final TextEditingController cepController;
  late final TextEditingController enderecoController;
  late final TextEditingController numeroController;
  late final TextEditingController cidadeController;
  late final TextEditingController bairroController;
  late final TextEditingController referenciaController;
  late String estado;
  CollectionReference get _enderecoCollection => FirebaseFirestore.instance.collection("endereco");
  final List<String> estados = [
    "Acre (AC)",
    "Alagoas (AL)",
    "Amapá (AP)",
    "Amazonas (AM)",
    "Bahia (BA)",
    "Ceará (CE)",
    "Distrito Federal (DF)",
    "Espírito Santo (ES)",
    "Goiás (GO)",
    "Maranhão (MA)",
    "Mato Grosso (MT)",
    "Mato Grosso do Sul (MS)",
    "Minas Gerais (MG)",
    "Pará (PA)",
    "Paraíba (PB)",
    "Paraná (PR)",
    "Pernambuco (PE)",
    "Piauí (PI)",
    "Rio de Janeiro (RJ)",
    "Rio Grande do Norte (RN)",
    "Rio Grande do Sul (RS)",
    "Rondônia (RO)",
    "Roraima (RR)",
    "Santa Catarina (SC)",
    "São Paulo (SP)",
    "Sergipe (SE)",
    "Tocantins (TO)"];

  CadastrarEnderecoController(){
    cepController = TextEditingController();
    enderecoController= TextEditingController();
    numeroController = TextEditingController();
    bairroController = TextEditingController();
    referenciaController = TextEditingController();
    cidadeController = TextEditingController();
  }
}