import 'package:diabits/db/operation.dart';
import 'package:diabits/models/usuario.dart';
import 'package:diabits/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Input_text.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '';
  String _password = '';

  _summit() {
    //metodo que ejecuta las validaciones que pongas en el form
    final isoOK = _formKey.currentState!.validate();
    //print("form isOK $isoOK");
    OperationDB.insert(Usuarios(
        id_usuario: '1',
        nombre: 'user',
        correo: 'user@erydsoft',
        password: '1234'));
    OperationDB.usuarios();
    print("login");
    if (isoOK) {
      print(_email);
      print(_password);
      Navigator.pushNamed(context, 'recordatorio');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Positioned(
      bottom: 0,
      child: Container(
        constraints: BoxConstraints(
          //ancho del dispositivo si es tablet 430 si no ancho-30
          maxWidth: responsive.isTablet ? 430 : responsive.width - 30,
        ),
        child: Form(
          key: _formKey, //ayuda a validar los campos. se usa en sumit
          child: Column(
            children: <Widget>[
              InputText(
                keyboardType: TextInputType.emailAddress,
                fontSize: responsive.dp(responsive.isTablet ? 1.9 : 1.6),
                onChanged: (text) {
                  this._email = text;
                },
                validator: (text) {
                  if (!text!.contains('@')) {
                    return "Correo electrónico inválido";
                  }
                  return null;
                },
                label: 'CORREO ELECTRÓNICO',
              ),
              SizedBox(height: responsive.dp(2)),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InputText(
                        obscureText: true,
                        borderEnabled: false,
                        fontSize:
                            responsive.dp(responsive.isTablet ? 1.9 : 1.6),
                        onChanged: (text) {
                          this._password = text;
                        },
                        validator: (text) {
                          if (text!.trim().length == 0) {
                            return "Contraseña inválida";
                          }
                          return null;
                        },
                        label: 'CONTRASEÑA',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: responsive.dp(5)),
              SizedBox(
                width: responsive.width * 0.50,
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Ingresar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(2),
                    ),
                  ),
                  onPressed: this._summit,
                  color: Colors.blue.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: responsive.dp(2)),
              MaterialButton(
                padding: EdgeInsets.symmetric(vertical: 10),
                onPressed: () {},
                child: Text(
                  '¿Tienes problemas para iniciar sesión?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: responsive.dp(responsive.isTablet ? 2 : 1.8),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '¿Nuevo aquí?',
                    style: TextStyle(
                      fontSize: responsive.dp(1.8),
                      color: Colors.black,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Text(
                      'Registrate ahora',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: responsive.dp(1.8),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: responsive.dp(8)),
            ],
          ),
        ),
      ),
    );
  }
}
