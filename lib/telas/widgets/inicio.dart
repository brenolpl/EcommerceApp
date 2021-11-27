import 'package:appflutter/telas/controller/iniciocontroller.dart';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
   @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final InicioController _inicioController = InicioController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      alignment: Alignment.center,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/icon/fav-icon.png", fit: BoxFit.contain),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 100),
            child: const Text(
              "EcommerceApp",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  decoration: TextDecoration.none
              ),
            ),
          ),
          const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _inicioController.start(context);
  }
}
