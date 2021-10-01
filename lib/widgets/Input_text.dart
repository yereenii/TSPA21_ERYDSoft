import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool borderEnabled; //esconde el border
  final double fontSize;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const InputText({
    Key? key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.borderEnabled = true,
    this.fontSize = 15,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: this.keyboardType, //tipo de teclado
      obscureText: this.obscureText,
      onChanged: this.onChanged, //obtiene el texto del campo
      validator: this.validator,
      style: TextStyle(
        fontSize: this.fontSize,
      ),
      decoration: InputDecoration(
        labelText: this.label,
        enabledBorder: this.borderEnabled
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black12,
                ),
              )
            : InputBorder.none,
        //suffix: Text("Forgot Password"), //solo cuando el elemento tiene el foco de atencion
        contentPadding: EdgeInsets.symmetric(vertical: 7),
        labelStyle: TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
