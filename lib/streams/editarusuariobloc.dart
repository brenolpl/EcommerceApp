import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/streams/simplebloc.dart';
import 'package:appflutter/telas/controller/cadastrarusuariocontroller.dart';
import 'package:appflutter/util/businessexception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class EditarUsuarioBloc extends SimpleBloc<Usuario> {
  Future<Usuario> atualizarUsuario(Usuario usuario, CadastrarUsuarioController usuarioController) async {
    try {
      usuario.admin = false;
      usuario.email = usuarioController.emailController.text.trim();
      usuario.nome = usuarioController.nomeController.text.trim();
      usuario.cpf = usuarioController.cpfController.text.trim();
      initializeDateFormatting("pt_BR", null);
      DateFormat formatter = DateFormat("dd/MM/yyyy");
      usuario.dataNascimento = Timestamp.fromDate(formatter.parse(usuarioController.dataNascimentoController.text.trim()));
      usuario.telefone = usuarioController.telefoneController.text.trim();
      FirebaseFirestore.instance.collection("users").doc(usuario.id).update(
          usuario.toMap()).then((value) {
        return usuario;
      });
    }on FirebaseException catch (ex){
        businessException(ex.message, null);
    }
    return usuario;
  }
}