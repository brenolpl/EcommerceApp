import 'package:appflutter/core/produto.dart';
import 'package:appflutter/core/produto_categoria.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageController{
  late Usuario usuario;

  HomePageController(this.usuario);
}