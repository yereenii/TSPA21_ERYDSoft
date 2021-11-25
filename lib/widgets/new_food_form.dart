// ignore_for_file: avoid_print
import 'package:diabits/db/operation.dart';
import 'package:diabits/models/alimento.dart';
import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Input_text.dart';

class NewFoodForm extends StatefulWidget {
  const NewFoodForm({Key? key}) : super(key: key);

  @override
  _NewFoodForm createState() => _NewFoodForm();
}

class _NewFoodForm extends State<NewFoodForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _nombre = "";
  String _descropcion = "";
  bool _harmful = false;
  OperationDB _operationDB = OperationDB();
  int id_user = -1;

  _summit() {
    //metodo que ejecuta las validaciones que pongas en el form
    final isoOK = _formKey.currentState!.validate();
    print("form isOK $isoOK");

    if (isoOK) {
      print(_nombre);
      print(_descropcion);
      print(_harmful);
      _insertarAlimento();
      _regresarAlimentos();
    }
  }

  _insertarAlimento() {
    _operationDB.inserAlimento(Alimento(
        nombreAlimento: _nombre,
        nota: _descropcion,
        danino: _harmful,
        idUsuario: id_user));
    //_operationDB.getAlimentos();
  }

  _regresarAlimentos() {
    setState(() {
      Navigator.pop(context, 'alimento');
    });
  }

  @override
  void initState() {
    _harmful = false;
    super.initState();
  }

  getIdUsuario() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    id_user = await pref.getInt('id_usuario')!;
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
      constraints: BoxConstraints(
        //ancho del dispositivo si es tablet 430 si no ancho-30
        maxWidth: responsive.isTablet ? 430 : responsive.width - 30,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            InputText(
              keyboardType: TextInputType.emailAddress,
              fontSize: responsive.dp(responsive.isTablet ? 1.9 : 1.6),
              onChanged: (text) {
                _nombre = text;
              },
              validator: (text) {
                if (text!.isEmpty) {
                  return "Nombre inválido";
                }
                return null;
              },
              label: 'Nombre del Alimento',
            ),
            SizedBox(height: responsive.dp(2)),
            /*************************************** */
            InputText(
              keyboardType: TextInputType.emailAddress,
              fontSize: responsive.dp(responsive.isTablet ? 1.9 : 1.6),
              onChanged: (text) {
                _descropcion = text;
              },
              validator: (text) {
                if (text!.isEmpty) {
                  return "Dscripción inválida";
                }
                return null;
              },
              label: 'Descripcion',
            ),
            /*************************************** */
            SizedBox(height: responsive.dp(2)),
            /*************************************** */
            SizedBox(
              width: responsive.width * 1,
              child: Row(
                children: <Widget>[
                  const Text('Dañino'),
                  Checkbox(
                      value: _harmful,
                      onChanged: (bool? value) {
                        setState(() {
                          _harmful = value!;
                        });
                      })
                ],
              ),
            ),
            /*************************************** */
            SizedBox(height: responsive.dp(2)),
            SizedBox(
              width: responsive.width * 0.50,
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Agregar',
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
            SizedBox(
              width: responsive.width * 0.50,
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: responsive.dp(2),
                  ),
                ),
                onPressed: _regresarAlimentos,
                color: Colors.red.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: responsive.dp(2)),
          ],
        ),
      ),
    );
  }
}
