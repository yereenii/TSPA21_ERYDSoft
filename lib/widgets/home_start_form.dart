// ignore_for_file: avoid_print

//import 'package:diabits/main.dart';
import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/inkWellTabs.dart';
import 'package:flutter/material.dart';

class HomeStartForm extends StatefulWidget {
  const HomeStartForm({Key? key}) : super(key: key);

  @override
  _HomeStartForm createState() => _HomeStartForm();
}

class _HomeStartForm extends State<HomeStartForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _recordatorioController = TextEditingController();
  final TextEditingController _alimentoController = TextEditingController();
  final TextEditingController _sabiasQueController = TextEditingController();

  @override
  void initState() {
    _recordatorioController.text = "Recordatorios";
    _alimentoController.text = "Alimentos";
    _sabiasQueController.text = "¿Sabias que?";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Positioned(
      child: Container(
        constraints: BoxConstraints(
          //ancho del dispositivo si es tablet 430 si no ancho-30
          maxWidth: responsive.isTablet ? 430 : responsive.width - 30,
        ),
        child: Form(
          key: _formKey, //ayuda a validar los campos. se usa en sumit
          child: Column(
            children: <Widget>[
              SizedBox(height: responsive.dp(2)),
              /*************************************** */
              SizedBox(
                width: responsive.width * 0.50,
                child: Column(
                  children: [
                    InkTextFormField(
                      onTap: () async =>
                          Navigator.pushNamed(context, 'recordatorio'),
                      label: "",
                      controller: _recordatorioController,
                      fontSize: responsive.dp(responsive.isTablet ? 1.9 : 1.6),
                      width: responsive.width / 1.7,
                      heigth: responsive.height / 15,
                    ),
                  ],
                ),
              ),

              /*************************************** */
              SizedBox(height: responsive.dp(2)),
              /*************************************** */
              SizedBox(
                width: responsive.width * 0.50,
                child: Column(
                  children: [
                    InkTextFormField(
                      //onTap: () async => _selectTime(context),
                      label: "",
                      controller: _alimentoController,
                      fontSize: responsive.dp(responsive.isTablet ? 1.9 : 1.6),
                      width: responsive.width / 1.7,
                      heigth: responsive.height / 15,
                    ),
                  ],
                ),
              ),
              /*************************************** */
              SizedBox(height: responsive.dp(2)),
              /*************************************** */
              SizedBox(
                width: responsive.width * 0.50,
                child: Column(
                  children: [
                    InkTextFormField(
                      //onTap: () async => _selectTime(context),
                      label: "",
                      controller: _sabiasQueController,
                      fontSize: responsive.dp(responsive.isTablet ? 1.9 : 1.6),
                      width: responsive.width / 1.7,
                      heigth: responsive.height / 15,
                    ),
                  ],
                ),
              ),
              /*************************************** */
              SizedBox(height: responsive.dp(2)),
              SizedBox(height: responsive.dp(2)),
            ],
          ),
        ),
      ),
    );
  }
}
