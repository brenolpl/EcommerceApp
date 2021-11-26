import 'package:appflutter/telas/widgets/inicio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  Intl.defaultLocale = 'pt_BR';
}

class MyApp extends StatelessWidget {
  MaterialColor primaryBlack = const MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(0xFF000000),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryBlack,
        // Define o tema para claro ou escuro
        brightness: Brightness.light,
        // Define a cor de fundo padrão para Containers
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FutureBuilder(
        // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Text("ERRO");
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return Inicio();
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
              color: Colors.cyan,
            );
          }),
    );

  }
}