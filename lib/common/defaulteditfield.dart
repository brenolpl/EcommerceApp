import 'package:flutter/material.dart';

class DefaultEditField extends StatelessWidget {
  String text;
  String tip;
  bool password;
  TextEditingController? controller;
  FormFieldValidator<String>? validator;
  TextInputType inputType;
  FocusNode? focusOutput;
  FocusNode? focusInput;

  DefaultEditField(
    this.text,
    {
    this.tip = "",
    this.controller,
    this.inputType = TextInputType.text,
    this.validator,
    this.password = false,
    this.focusOutput,
    this.focusInput
    }){
    //mesma coisa que if(validator == null)
      validator ??= (text){
          if(text!.isEmpty){
            return "O campo $text é obrigatório!";
          }
        };
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: password,
      controller: controller,
      keyboardType: inputType,
      textInputAction: TextInputAction.next,
      focusNode: focusOutput,
      onFieldSubmitted: (text){
        FocusScope.of(context).requestFocus(focusInput);
      },
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: tip,
        labelStyle: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        )
      ),
    );
  }
}
