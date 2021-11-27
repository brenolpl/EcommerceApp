import 'package:appflutter/core/endereco.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/streams/simplebloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnderecosBloc extends SimpleBloc<List<Endereco>>{
  Future<List<Endereco>> obterEnderecos(Usuario usuario) async {
    List<Endereco> enderecosList = [];
    FirebaseFirestore.instance.collection("endereco").where("usuario_id", isEqualTo: usuario.id)
        .snapshots().listen((data) {
      for (var doc in data.docs) {
        Endereco endereco = Endereco.fromMap(doc);
        enderecosList.add(endereco);
      }
    });
    add(enderecosList);
    return enderecosList;
  }

}