import 'package:appflutter/common/defaultbutton.dart';
import 'package:appflutter/common/defaulteditfield.dart';
import 'package:appflutter/telas/controller/logincontroller.dart';
import 'package:appflutter/telas/widgets/usuario/cadastrarusuario.dart';
import 'package:appflutter/util/nav.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EcommerceApp"),
      ),
      body: _body(),
    );
  }
  @override
  void initState() {
    super.initState();
    _loginController = LoginController();
  }

  _body(){
    return Form(
      key: _loginController.formkey,
      child: Container(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: [
              DefaultEditField(
                "Login",
                tip: "Email",
                controller: _loginController.emailController,
                inputType: TextInputType.emailAddress,
                focusInput: _loginController.passwordFocus,
              ),
              const SizedBox(
                height: 14,
              ),
              DefaultEditField(
                  "Senha",
                  tip: "Senha",
                  password: true,
                  validator: (text){
                    if(text!.isEmpty){
                      return "O campo $text é obrigatório";
                    }else if(!text.contains(RegExp("[A-Z0-9]"))) {
                      return "Sua senha precisa conter ao menos uma letra e um número";
                    }else if(text.length<8){
                      return "Sua senha precisa conter 8 ou mais caracteres";
                    }
                    return null;
                  },
                  controller: _loginController.passwdController,
                  focusOutput: _loginController.passwordFocus,
                  inputType: TextInputType.emailAddress,
                  focusInput: _loginController.passwordFocus
              ),
              const SizedBox(
                height: 10,
              ),
              DefaultButton(
                text: 'LOGIN',
                color: Colors.white,
                onClick: (){
                    _loginController.signIn(context);
                },
                focusOutput: _loginController.buttonFocus,
              ),
              Container(
                height: 46,
                margin: const EdgeInsets.only(top: 20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(60),
                  onTap: (){
                    push(context, CadastrarUsuario("Cadastrar novo usuário", false));
                  },
                  child: const Text(
                    "SIGN UP",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepOrange,
                    )
                  ),
                ),
              )
            ],
          ),
      )
    );
  }
}
