import 'package:appflutter/core/usuario.dart';
import 'package:appflutter/telas/controller/homepagecontroller.dart';
import 'package:appflutter/telas/widgets/menu.dart';
import 'package:appflutter/telas/widgets/profile.dart';
import 'package:appflutter/util/nav.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  late Usuario usuario;
  HomePage(this.usuario, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageController _homePageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: const Text("EcommerceApp"),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _homePageController = HomePageController(widget.usuario);
  }
}
