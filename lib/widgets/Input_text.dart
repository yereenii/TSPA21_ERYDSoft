import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool borderEnabled; //esconde el border

  const InputText({
    Key? key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.borderEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: this.keyboardType, //tipo de teclado
      obscureText: this.obscureText,
      decoration: InputDecoration(
        border: this.borderEnabled ? null : InputBorder.none,
        //suffix: Text("Forgot Password"), //solo cuando el elemento tiene el foco de atencion
        labelText: this.label,
        labelStyle: TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
