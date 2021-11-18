import 'package:diabits/db/operation.dart';
import 'package:diabits/models/usuario.dart';
import 'package:diabits/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Input_text.dart';

class LoginForm extends StatefulWidget {
  //const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '';
  String _password = '';
  OperationDB _operationDB = OperationDB();

  bool _existeUsuario(String e, String p) {
    bool existe = _operationDB.existeUser(e, p);
    print(
        "####### metodo existeUsuario return>>> email: $e password: $p $existe");
    return existe;
  }

  _creacionPrimerUsuario() {
    _operationDB.insertUser(
        Usuario(nombre: 'user', correo: 'user@erydsoft', password: '1234'));
  }

  void _showAlertDialog(String titulo, String contenido) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(contenido),
            actions: <Widget>[
              MaterialButton(
                child: Text(
                  "CERRAR",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    _operationDB.getUsers();
    super.initState();
  }

  _summit() {
    final isoOK = _formKey.currentState!.validate();

    if (isoOK) {
      //Navigator.pushNamed(context, 'recordatorio');
      //bool existeRegistro = _existeUsuario('user@erydsoft', '1234');
      print("###### $_email    $_password");
      if (_existeUsuario(_email, _password)) {
        Navigator.pushNamed(context, 'paginainicio');
      } else {
        _showAlertDialog("Inicio de Sesión", "El usuario no existe");
      }
    }
    return isoOK;
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
                  onPressed: _summit,
                  color: Colors.blue.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: responsive.dp(2)),
              /*MaterialButton(
                padding: EdgeInsets.symmetric(vertical: 10),
                onPressed: () {},
                child: Text(
                  '¿Tienes problemas para iniciar sesión?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: responsive.dp(responsive.isTablet ? 2 : 1.8),
                  ),
                ),
              ),*/
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
                    onPressed: () {
                      Navigator.pushNamed(context, 'nuevousuario')
                          .then((value) => _existeUsuario(_email, _password));
                    },
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
