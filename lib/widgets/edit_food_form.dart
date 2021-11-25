// ignore_for_file: avoid_print
import 'package:diabits/db/operation.dart';
import 'package:diabits/models/alimento.dart';
import 'package:diabits/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Input_text.dart';

class EditFoodForm extends StatefulWidget {
  final Alimento? alimento;
  const EditFoodForm({Key? key, this.alimento}) : super(key: key);

  @override
  _EditFoodForm createState() => _EditFoodForm(alimento: alimento);
}

class _EditFoodForm extends State<EditFoodForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Alimento? alimento;
  int _idAlimento = 0;
  String _nombre = "";
  String _descripcion = "";
  bool _harmful = false;
  OperationDB _operationDB = OperationDB();
  int id_user = -1;

  _EditFoodForm({this.alimento});

  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  _summit() {
    //metodo que ejecuta las validaciones que pongas en el form
    final isoOK = _formKey.currentState!.validate();
    print("form isOK $isoOK");
    if (isoOK) {
      print(_nombre);
      print(_descripcion);
      print(_harmful);
      _editarAlimento();
      _regresarAlimentos();
    }
  }

  _editarAlimento() {
    _operationDB.editA(Alimento(
        idAlimento: _idAlimento,
        nombreAlimento: _nombre,
        nota: _descripcion,
        danino: _harmful,
        idUsuario: id_user));
    //_operationDB.getAlimentos();
  }

  _regresarAlimentos() {
    Navigator.pop(context, 'alimentos');
  }

  @override
  void initState() {
    _idAlimento = alimento!.idAlimento!;
    _nombreController.text = alimento!.nombreAlimento.toString();
    _descripcionController.text = alimento!.nota.toString();
    _harmful = alimento!.danino;
    getIdUsuario();
    super.initState();
  }

  getIdUsuario() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    id_user = await pref.getInt('id_usuario')!;
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    //initState();
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
              controller: _nombreController,
              keyboardType: TextInputType.emailAddress,
              fontSize: responsive.dp(responsive.isTablet ? 1.9 : 1.6),
              /*onChanged: (_nombre) {
                _nombre = _nombreController.text;
                print(_nombre);
              },*/
              validator: (text) {
                _nombre = _nombreController.text;
                if (text!.isEmpty) {
                  return "Nombre inválido";
                }
                return null;
              },
              label: 'Nombre Alimento',
            ),
            SizedBox(height: responsive.dp(2)),
            /*************************************** */
            InputText(
              controller: _descripcionController,
              keyboardType: TextInputType.emailAddress,
              fontSize: responsive.dp(responsive.isTablet ? 1.9 : 1.6),
              /*onChanged: (text) {
                _descripcion = _descripcionController.text;
                print(_descripcion);
              },*/
              validator: (text) {
                _descripcion = _descripcionController.text;
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
                  'Editar',
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
