import 'package:appflutter/core/endereco.dart';
import 'package:flutter/material.dart';

class EnderecoDetail extends StatelessWidget {
  Endereco endereco;

  EnderecoDetail(this.endereco, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Text(
                      endereco.cep,
                      style: const TextStyle(
                          color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      endereco.endereco,
                      style: const TextStyle(
                          color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      endereco.numero,
                      style: const TextStyle(
                          color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      endereco.bairro,
                      style: const TextStyle(
                          color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      endereco.cidade,
                      style: const TextStyle(
                          color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      endereco.estado,
                      style: const TextStyle(
                          color: Colors.black
                      ),
                    )
              ],
            ),
          )
        ],
      )
    );
  }
}
