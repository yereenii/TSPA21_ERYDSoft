import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/Input_text.dart';
import 'package:flutter/material.dart';

class NewUserLoginForm extends StatefulWidget {
  //const NewUserLoginForm({ Key? key }) : super(key: key);

  @override
  _NewUserLoginFormState createState() => _NewUserLoginFormState();
}

class _NewUserLoginFormState extends State<NewUserLoginForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _nombre = '';
  String _correo = '';
  String _password = '';
  String _passwordAux = '';
  String _campoObligatorio = 'Campo obligatorio';
  String _contrasenaNocoincide = 'LA CONTRASEÑA NO COINCIDE';
  String _labelNombreUsuario = 'NOMBRE';
  String _labelCorreoUsuario = 'CORREO ELECTRÓNICO';
  String _labelPassword = 'CONTRASEÑA';
  String _labelBtnAgregar = 'CREAR USUARIO';
  String _labelBtnCancelar = 'CANCELAR';

  _agregarUsuario() {
    final isoOK = _formKey.currentState!.validate();

    if (isoOK) {
      //"Agregar"
    }
  }

  _cancelar() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Positioned(
      top: responsive.height * 0.01,
      bottom: 0,
      child: Container(
        constraints: BoxConstraints(
          //ancho del dispositivo si es tablet 430 si no ancho-30
          maxWidth: responsive.isTablet ? 430 : responsive.width - 30,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              InputText(
                keyboardType: TextInputType.text,
                fontSize: responsive.dp(responsive.isTablet ? 1.9 : 1.6),
                onChanged: (text) {
                  this._nombre = text;
                },
                validator: (text) {
                  if (text!.trim().length == 0) {
                    return _campoObligatorio;
                  }
                  return null;
                },
                label: _labelNombreUsuario,
              ),
              SizedBox(height: responsive.dp(2)),
              InputText(
                  keyboardType: TextInputType.text,
                  fontSize: responsive.dp(responsive.isTablet ? 1.9 : 1.6),
                  onChanged: (text) {
                    this._correo = text;
                  },
                  validator: (text) {
                    if (!text!.contains('@')) {
                      return "Correo electrónico inválido";
                    }
                    return null;
                  },
                  label: _labelCorreoUsuario),
              SizedBox(height: responsive.dp(2)),
              InputText(
                keyboardType: TextInputType.text,
                fontSize: responsive.dp(responsive.isTablet ? 1.9 : 1.6),
                onChanged: (text) {
                  this._passwordAux = text;
                },
                validator: (text) {
                  if (text!.trim().length == 0) {
                    return _campoObligatorio;
                  } else if (_password != text) {
                    return _contrasenaNocoincide;
                  }
                  return null;
                },
                label: _labelPassword,
              ),
              SizedBox(height: responsive.dp(2)),
              InputText(
                keyboardType: TextInputType.text,
                fontSize: responsive.dp(responsive.isTablet ? 1.9 : 1.6),
                onChanged: (text) {
                  this._password = text;
                },
                validator: (text) {
                  if (text!.trim().length == 0) {
                    return _campoObligatorio;
                  } else if (_passwordAux != text) {
                    return _contrasenaNocoincide;
                  }
                  return null;
                },
                label: 'CONFIRMAR ' + _labelPassword,
              ),
              SizedBox(height: responsive.dp(2)),
              SizedBox(height: responsive.dp(5)),
              SizedBox(
                width: responsive.width * 0.50,
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    _labelBtnAgregar,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(2),
                    ),
                  ),
                  onPressed: _agregarUsuario,
                  color: Colors.blue.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: responsive.dp(2)),
              SizedBox(
                width: responsive.width * 0.50,
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    _labelBtnCancelar,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(2),
                    ),
                  ),
                  onPressed: _cancelar,
                  color: Colors.red.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
