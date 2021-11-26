import 'package:diabits/db/operation.dart';
import 'package:diabits/models/recordatorio.dart';
import 'package:diabits/models/usuario.dart';
import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/inkWellTabs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Input_text.dart';
import 'package:intl/intl.dart' as intl;
import 'package:date_format/date_format.dart';

class EditReminderForm extends StatefulWidget {
  final Recordatorio? recordar;
  const EditReminderForm({Key? key, this.recordar}) : super(key: key);

  @override
  //_EditReminderFormState createState() => _EditReminderFormState();
  _EditReminderForm createState() => _EditReminderForm(recordar: recordar);
}

class _EditReminderForm extends State<EditReminderForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Recordatorio? recordar;
  int _idRecordatorio = 0;
  String date = "";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String _hour = '', _minute = '', _time = '';
  String _nombre = '';
  String _fecha = '';
  String _hora = '';
  DateTime _fechaCompleta = DateTime.now();
  OperationDB _operationDB = OperationDB();
  int id_user = -1;

  _EditReminderForm({this.recordar});

  // ignore: duplicate_ignore
  _summit() {
    //metodo que ejecuta las validaciones que pongas en el form
    final isoOK = _formKey.currentState!.validate();
    print("form isOK $isoOK");
    if (isoOK) {
      print(_nombre);
      print(_fecha);
      print(_hora);
      print('fechacompleta = ' + _fechaCompleta.toString());
      //consumir servicio rest para iniciar sesion
      _edicionRecordatorio();
      _regresarCalendar();
    }
  }

  _edicionRecordatorio() {
    Recordatorio recordatorio = Recordatorio(
      id_recordatorio: recordar!.id_recordatorio!,
      nombre_recordatorio: _nombre,
      fecha: _fechaCompleta,
      idUsuario: recordar!.idUsuario,
    );
    _operationDB.editaRecordatorioBD(recordatorio);
    //_operationDB.getRecordatorios(recordatorio.idUsuario);
  }

  _regresarCalendar() {
    //Navigator.pushNamed(context, 'editarrecordatorio');
    Navigator.pop(context, 'recordar');
  }

  @override
  void initState() {
    //dMY().format(DateTime.now())
    _nombreController.text = recordar!.nombre_recordatorio;
    _dateController.text = intl.DateFormat.yMd("es").format(recordar!.fecha);
    _timeController.text = formatDate(
        DateTime(2021, 09, 09, recordar!.fecha.hour, recordar!.fecha.minute),
        [HH, ':', nn]).toString();
    selectedDate = recordar!.fecha;
    selectedTime = TimeOfDay.fromDateTime(recordar!.fecha);
    _fechaCompleta = recordar!.fecha;
    _hora = selectedTime.toString();
    getIdUsuario();
    super.initState();
  }

  getIdUsuario() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    id_user = await pref.getInt('id_usuario')!;
  }

  //call del datePickerSelect
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      locale: const Locale('en', 'US'),
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2125),
      helpText: "SELECCIONAR FECHA",
      cancelText: "CANCELAR",
      confirmText: "OK",
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        _dateController.text = intl.DateFormat.yMd("es").format(selectedDate);
      });
      _fecha = selected.toString();
      _fechaCompleta = selectedDate;
    }
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (
        BuildContext context,
        Widget? child,
      ) {
        return Localizations.override(
          context: context,
          locale: const Locale('en', 'US'),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hourOfPeriod.toString();
        _minute = selectedTime.hour.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2021, 09, 09, selectedTime.hour, selectedTime.minute), [
          HH,
          ':',
          nn,
        ]).toString();
        _hora = selectedTime.toString();
        DateTime dt = DateTime(_fechaCompleta.year, _fechaCompleta.month,
            _fechaCompleta.day, selectedTime.hour, selectedTime.minute);
        _fechaCompleta = dt;
      });
    } else {
      DateTime dt = DateTime(_fechaCompleta.year, _fechaCompleta.month,
          _fechaCompleta.day, selectedTime.hour, selectedTime.minute);
      _fechaCompleta = dt;
    }
  }

  //Widget DataPicker
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
                controller: _nombreController,
                keyboardType: TextInputType.emailAddress,
                fontSize: responsive.dp(responsive.isTablet ? 1.9 : 1.6),
                /*onChanged: (text) {
                  _nombre = text;
                },*/
                validator: (text) {
                  _nombre = _nombreController.text;
                  if (text!.isEmpty) {
                    return "Nombre inválido";
                  }
                  return null;
                },
                label: 'Modificar Nombre del Recordatorio',
              ),
              SizedBox(height: responsive.dp(2)),
              /*************************************** */
              SizedBox(
                width: responsive.width * 0.50,
                child: Column(
                  children: [
                    InkTextFormField(
                      onTap: () async => _selectDate(context),
                      label: "Seleccionar la Fecha",
                      controller: _dateController,
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
                      onTap: () async => _selectTime(context),
                      label: "Seleccionar Hora",
                      controller: _timeController,
                      fontSize: responsive.dp(responsive.isTablet ? 1.9 : 1.6),
                      width: responsive.width / 1.7,
                      heigth: responsive.height / 15,
                    ),
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
                  onPressed: _regresarCalendar,
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
      ),
    );
  }
}
