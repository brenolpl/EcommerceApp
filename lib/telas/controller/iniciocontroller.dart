import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/widgets/admlistaproduto.dart';
import 'package:appflutter/telas/widgets/login.dart';
import 'package:appflutter/telas/widgets/homepage.dart';
import 'package:appflutter/util/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class InicioController {
  void start(BuildContext context){
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if(user == null){
        push(context, const Login(), replace: true);
      }else{
        Usuario usuario;
        FirebaseFirestore.instance.collection("users").where("email", isEqualTo: "${user.email}")
        .snapshots()
        .listen((data) {
          usuario = Usuario.fromMap(data.docs[0]);
          if(usuario.admin){
            push(context, AdmListaProduto(usuario), replace: true);
          }else {
            push(context, HomePage(usuario), replace: true);
          }
        });
      }
    });

  }
}