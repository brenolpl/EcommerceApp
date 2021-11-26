import 'package:appflutter/core/endereco.dart';
import 'package:appflutter/telas/controller/cadastrarenderecocontroller.dart';
import 'package:flutter/material.dart';

class EnderecoDetail extends StatelessWidget {
  Endereco endereco;

  EnderecoDetail(this.endereco, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                endereco.cep,
                style: const TextStyle(
                  color: Colors.black
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                endereco.endereco,
                style: const TextStyle(
                    color: Colors.black
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                endereco.numero,
                style: const TextStyle(
                    color: Colors.black
                ),
              )
            ],
          ),
          Row(
            children: [
              Text(
                endereco.bairro,
                style: const TextStyle(
                    color: Colors.black
                ),
              )
            ],
          ),
          Row(
            children: [
              Text(
                endereco.cidade,
                style: const TextStyle(
                    color: Colors.black
                ),
              )
            ],
          ),
          Row(
            children: [
              Text(
                endereco.estado,
                style: const TextStyle(
                    color: Colors.black
                ),
              )
            ],
          )
        ],
      )
    );
  }
}
