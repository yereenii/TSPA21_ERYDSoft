// ignore_for_file: avoid_print

import 'package:diabits/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Input_text.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class NewReminderForm extends StatefulWidget {
  const NewReminderForm({Key? key}) : super(key: key);

  @override
  _NewReminderFormState createState() => _NewReminderFormState();
}

class _NewReminderFormState extends State<NewReminderForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String date = "";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String _hour = '', _minute = '', _time = '';
  String _nombre = '';
  final String _fecha = '';
  String _hora = '';

  // ignore: duplicate_ignore
  _summit() {
    //metodo que ejecuta las validaciones que pongas en el form
    final isoOK = _formKey.currentState!.validate();
    print("form isOK $isoOK");
    if (isoOK) {
      print(_nombre);
      print(_fecha);
      print(_hora);
      //consumir servicio rest para iniciar sesion
    }
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());
    _timeController.text = formatDate(
        DateTime(2021, 09, 09, selectedTime.hourOfPeriod, selectedTime.minute),
        [HH, ':', nn, ' ', am]).toString();
    _hora = selectedTime.toString();
    super.initState();
  }

  //call del datePickerSelect
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
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
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hourOfPeriod.toString();
        _minute = selectedTime.hour.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2021, 09, 09, selectedTime.hour, selectedTime.minute),
            [HH, ':', nn, ' ']).toString();
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
              SizedBox(
                width: responsive.width * 0.50,
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const Text('Elegir la Fecha'),
                        InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                            width: responsive.width / 1.7,
                            height: responsive.height / 15,
                            decoration: BoxDecoration(color: Colors.blue[200]),
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: responsive
                                      .dp(responsive.isTablet ? 1.9 : 1.6)),
                              textAlign: TextAlign.center,
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: _dateController,
                              onSaved: (String? val) {},
                              decoration: const InputDecoration(
                                disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                contentPadding: EdgeInsets.only(top: 0.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: responsive.dp(2)),
              SizedBox(
                width: responsive.width * 0.50,
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const Text('Elrgir la Hora'),
                        InkWell(
                          onTap: () {
                            _selectTime(context);
                          },
                          child: Container(
                            width: responsive.width / 1.7,
                            height: responsive.height / 15,
                            decoration: BoxDecoration(color: Colors.blue[200]),
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: responsive
                                      .dp(responsive.isTablet ? 1.9 : 1.6)),
                              textAlign: TextAlign.center,
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: _timeController,
                              onSaved: (String? val) {},
                              decoration: const InputDecoration(
                                disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                contentPadding: EdgeInsets.only(top: 0.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
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
                    'Canselar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(2),
                    ),
                  ),
                  onPressed: _summit,
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
