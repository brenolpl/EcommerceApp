import 'package:appflutter/core/produto.dart';
import 'package:appflutter/core/produto_categoria.dart';
import 'package:appflutter/core/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageController{
  late Usuario usuario;

  HomePageController(this.usuario);
/*
INSERT INTO product (sku, name, description, image_url, active, units_in_stock, unit_price, category_id,date_created) VALUES ('BOOK-TECH-1016', 'Exploring React.js', 'Learn React.js at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1016.png', 1, 100, 27.99, 1, NOW());
INSERT INTO product (sku, name, description, image_url, active, units_in_stock, unit_price, category_id,date_created) VALUES ('BOOK-TECH-1017', 'Advanced Techniques in React.js', 'Learn React.js at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1017.png', 1, 100, 13.99, 1, NOW());
INSERT INTO product (sku, name, description, image_url, active, units_in_stock, unit_price, category_id,date_created) VALUES ('BOOK-TECH-1018', 'Introduction to C#', 'Learn C# at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1018.png', 1, 100, 26.99, 1, NOW());
INSERT INTO product (sku, name, description, image_url, active, units_in_stock, unit_price, category_id,date_created) VALUES ('BOOK-TECH-1019', 'Crash Course in JavaScript', 'Learn JavaScript at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1019.png', 1, 100, 13.99, 1, NOW());
INSERT INTO product (sku, name, description, image_url, active, units_in_stock, unit_price, category_id,date_created) VALUES ('BOOK-TECH-1020', 'Introduction to Machine Learning', 'Learn Machine Learning at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1020.png', 1, 100, 19.99, 1, NOW());
INSERT INTO product (sku, name, description, image_url, active, units_in_stock, unit_price, category_id,date_created) VALUES ('BOOK-TECH-1021', 'Become a Guru in Java', 'Learn Java at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1021.png', 1, 100, 18.99, 1, NOW());
INSERT INTO product (sku, name, description, image_url, active, units_in_stock, unit_price, category_id,date_created) VALUES ('BOOK-TECH-1022', 'Introduction to Python', 'Learn Python at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1022.png', 1, 100, 26.99, 1, NOW());
INSERT INTO product (sku, name, description, image_url, active, units_in_stock, unit_price, category_id,date_created) VALUES ('BOOK-TECH-1023', 'Advanced Techniques in C#', 'Learn C# at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1023.png', 1, 100, 22.99, 1, NOW());
INSERT INTO product (sku, name, description, image_url, active, units_in_stock, unit_price, category_id,date_created) VALUES ('BOOK-TECH-1024', 'The Expert Guide to Machine Learning', 'Learn Machine Learning at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!', 'assets/images/products/books/book-luv2code-1024.png', 1, 100, 16.99, 1, NOW());
 */
  static Future<List<Produto>> popular() async{
    List<Produto> produtosList = [];
    late ProdutoCategoria produtoCategoria;
    late Produto produto;
    FirebaseFirestore.instance.collection("produtos_categoria").where("nome", isEqualTo: "Livros")
    .snapshots()
        .listen((data) {
      produtoCategoria = ProdutoCategoria.fromMap(data.docs[0]);
    });
    FirebaseFirestore.instance.collection("produtos").snapshots().listen((data) {
      data.docs.forEach((element) {
        produto = Produto.fromMap(element);
        produto.categoria = produtoCategoria;
        produtosList.add(produto);
      });
    });
    return produtosList;
  }
}