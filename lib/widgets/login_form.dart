import 'package:diabits/db/operation.dart';
import 'package:diabits/models/usuario.dart';
import 'package:diabits/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Input_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  //const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '';
  String _password = '';
  int id = 0;
  String nombre = '';
  OperationDB _operationDB = OperationDB();
  late List<Usuario> _listUsers;
  late Usuario user;

  bool _existeUsuario(String e, String p) {
    bool existe = false;
    for (var n in _listUsers) {
      if (n.correo == e && n.password == p) {
        print("ID USUARIO LOGIN " + n.id_usuario.toString());
        guardarDatos(n.id_usuario, n.nombre, n.correo, n.password);
        user = n;
        existe = true;
      }
    }
    print(
        "####### metodo existeUsuario return>>> email: $e password: $p $existe");
    return existe;
  }

  Future<void> guardarDatos(id, nombre, email, password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setInt('id_usuario', id);
    await pref.setString('nombre', nombre);
    await pref.setString('email', email);
    await pref.setString('password', password);
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
                child: const Text(
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
    _getListUser();
    _operationDB.getUsers();
    super.initState();
    showData();
  }

  Future<void> showData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    id = await pref.getInt('id_usuario')!;
    _email = await pref.getString('email')!;
    _password = await pref.getString('password')!;
    nombre = await pref.getString('nombre')!;

    print('ID ' + id.toString() + ' Nombre ' + nombre);

    if (id != null) {
      Navigator.pushNamed(context, 'paginainicio');
    }
  }

  Future<List<Usuario>> _getListUser() async {
    _listUsers = await _operationDB.getUsers();
    return _listUsers;
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
                decoration: const BoxDecoration(
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
                          .then((value) => _getListUser());
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
