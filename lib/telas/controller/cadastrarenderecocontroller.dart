import 'package:appflutter/core/endereco.dart';
import 'package:appflutter/core/usuario.dart';
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

  static Future excluirEndereco(Endereco endereco) async {
    return FirebaseFirestore.instance.collection("endereco").doc(endereco.id).delete();
  }

  Future cadastrarNovoEndereco(Usuario usuario) async {
    Endereco endereco = Endereco();
    endereco = _setCamposEndereco(endereco);
    endereco.usuario_id = usuario.id;
    return FirebaseFirestore.instance.collection("endereco").add(endereco.toMap());
  }

  Endereco _setCamposEndereco(Endereco endereco){
    endereco.cep = cepController.text.trim();
    endereco.endereco = enderecoController.text.trim();
    endereco.estado = estado;
    endereco.bairro = bairroController.text.trim();
    endereco.numero = numeroController.text.trim();
    endereco.referencia = referenciaController.text.trim();
    endereco.cidade = cidadeController.text.trim();
    return endereco;
  }

  Future atualizarEndereco(Endereco endereco){
    endereco = _setCamposEndereco(endereco);
    return FirebaseFirestore.instance.collection("endereco").doc(endereco.id).update(endereco.toMap());
  }
}