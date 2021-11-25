import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/widgets/admlistaproduto.dart';
import 'package:appflutter/telas/widgets/homepage.dart';
import 'package:appflutter/util/businessexception.dart';
import 'package:appflutter/util/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginController {
  final emailController = TextEditingController();
  final passwdController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final passwordFocus = FocusNode();
  final buttonFocus = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _usersCollection => FirebaseFirestore.instance.collection("users");

  void signIn(BuildContext context) async{
    if(formkey.currentState!.validate()){
      String email = emailController.text.trim();
      String password = passwdController.text.trim();
      try{
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
        _gotoHomePage(userCredential.user, context);
      }on FirebaseAuthException catch (e){
        if (e.code == 'user-not-found'){
          businessException("not-found", context);
        }else if(e.code == 'wrong-password'){
          businessException('invalid', context);
        }
      }
    }
  }

  void signUp(BuildContext context) async {
    if(formkey.currentState!.validate()){
      String email = emailController.text.trim();
      String password = passwdController.text.trim();

      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        _usersCollection.add({
          'email': email,
        }).then((value) => _gotoHomePage(userCredential.user, context)).catchError((onError) => businessException("signup-failed", context));
      }on FirebaseAuthException catch (e){
        if(e.code == 'weak-password'){
          businessException("weak-password", context);
        }else if(e.code == 'email-already-in-use'){
          businessException("email-used", context);
        }
      }
    }
  }

  _gotoHomePage(User user, BuildContext context){
    _usersCollection.where("email", isEqualTo: "${user.email}").snapshots()
        .listen((data) {
        Usuario usuario = Usuario.fromMap(data.docs[0]);
        if(usuario.admin){
          push(context, AdmListaProduto(usuario), replace: true);
        }else{
          push(context, HomePage(usuario), replace: true);
        }
    });
  }
}
