import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  String text;
  Function()? onClick;
  FocusNode? focusOutput;
  Color? color;
  bool showProgress;

  DefaultButton(
      {this.text = "Botão",
      this.onClick,
      this.focusOutput,
      this.color,
      this.showProgress = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: ElevatedButton(
        onPressed: onClick,
        child: showProgress
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                ),
              )
            : Text(
                text,
                style: TextStyle(color: color, fontSize: 18),
                textAlign: TextAlign.center,
              ),
        focusNode: focusOutput,
        style: ButtonStyle(
            shape: MaterialStateProperty.all(const StadiumBorder())
        ),
      ),
    );
  }
}
