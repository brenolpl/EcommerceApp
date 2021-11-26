import 'package:appflutter/core/endereco.dart';
import 'package:flutter/material.dart';

class EnderecoDetail extends StatelessWidget {
  Endereco endereco;

  EnderecoDetail(this.endereco, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(endereco.estado),
    );
  }
}
