import 'package:appflutter/core/produto.dart';

class CarrinhoController {
  late List<Produto> listaProdutos;
  late double totalCarrinho;

  CarrinhoController(){
    listaProdutos = [];
    totalCarrinho = 0.0;
  }
}