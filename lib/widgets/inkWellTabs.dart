// ignore_for_file: file_names, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';

class InkTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Function()? onTap;
  final double? width;
  final double? heigth;
  final double? fontSize;
  final String? label;

  const InkTextFormField(
      {Key? key,
      this.controller,
      this.onTap,
      this.width,
      this.heigth,
      this.fontSize,
      this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(label!),
        InkWell(
          onTap: onTap,
          child: InputDecorator(
            decoration: const InputDecoration(enabled: true),
            child: Localizations(
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
                    style: TextStyle(fontSize: fontSize),
                    textAlign: TextAlign.center,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: controller,
                    onSaved: (String? val) {},
                    decoration: const InputDecoration(
                      disabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.only(top: 0.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
