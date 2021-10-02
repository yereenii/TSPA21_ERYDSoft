// ignore_for_file: file_names

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
    return Localizations(
      locale: const Locale('en', 'US'),
      delegates: const <LocalizationsDelegate<dynamic>>[
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
      ],
      child: MediaQuery(
        data: const MediaQueryData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: TextFormField(
            keyboardType: keyboardType, //tipo de teclado
            obscureText: obscureText,
            onChanged: onChanged, //obtiene el texto del campo
            validator: validator,
            style: TextStyle(
              fontSize: fontSize,
            ),
            decoration: InputDecoration(
              labelText: label,
              enabledBorder: borderEnabled
                  ? const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black12,
                      ),
                    )
                  : InputBorder.none,
              //suffix: Text("Forgot Password"), //solo cuando el elemento tiene el foco de atencion
              contentPadding: const EdgeInsets.symmetric(vertical: 7),
              labelStyle: const TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
