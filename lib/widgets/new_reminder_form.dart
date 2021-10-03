// ignore_for_file: avoid_print

//import 'package:diabits/main.dart';
import 'package:diabits/db/operation.dart';
import 'package:diabits/models/recordatorio.dart';
import 'package:diabits/models/usuario.dart';
import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/inkWellTabs.dart';
import 'package:flutter/material.dart';
import 'Input_text.dart';
import 'package:intl/intl.dart' as intl;
import 'package:date_format/date_format.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class NewReminderForm extends StatefulWidget {
  const NewReminderForm({Key? key}) : super(key: key);

  @override
  _NewReminderFormState createState() => _NewReminderFormState();
}

class _NewReminderFormState extends State<NewReminderForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String date = "";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String _hour = '', _minute = '', _time = '';
  String _nombre = '';
  String _fecha = '';
  String _hora = '';
  DateTime _fechaCompleta = DateTime.now();
  OperationDB _operationDB = OperationDB();

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
      _creacionRecordatorio();
    }
  }

  _creacionRecordatorio() {
    _operationDB.insertRecordatorio(Recordatorio(
      id_recordatorios: 1,
      nombre_recordatorio: _nombre,
      fecha: _fechaCompleta,
    ));
  }

  _regresarCalendar() {
    Navigator.pushNamed(context, 'recordatorio');
  }

  @override
  void initState() {
    //dMY().format(DateTime.now())
    _dateController.text = intl.DateFormat.yMd("es").format(DateTime.now());
    _timeController.text = formatDate(
        DateTime(2021, 09, 09, selectedTime.hour, selectedTime.minute),
        [HH, ':', nn]).toString();
    _hora = selectedTime.toString();
    super.initState();
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
                label: 'Nombre del Recordtorio',
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
