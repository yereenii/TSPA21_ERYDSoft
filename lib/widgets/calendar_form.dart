import 'package:diabits/db/operation.dart';
import 'package:diabits/models/recordatorio.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:diabits/utils/responsive.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

class Calendario extends StatefulWidget {
  Calendario({Key? key}) : super(key: key);

  @override
  _CalendarioState createState() => _CalendarioState();
}

@override
Widget _build(BuildContext context) {
  return MaterialApp(
    localizationsDelegates: const [
      // ... app-specific localization delegate[s] here
      SfGlobalLocalizations.delegate
    ],
    supportedLocales: const [
      Locale('es'),
      // ... other locales the app supports
    ],
    locale: const Locale('es', " "),
    home: Calendario(),
  );
}

class _CalendarioState extends State<Calendario> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  OperationDB operationDB = OperationDB();
  late List<String> _views;

  _summit() {
    Navigator.pushNamed(context, 'nuevorecordatorio');
  }

  _actualizar() {}
  _eliminar() {}
  @override
  void initState() {
    _views = <String>['Actualizar', 'Eliminar'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Text('Calendario de Recordatorios'),
          leading: PopupMenuButton<String>(
            icon: Icon(Icons.calendar_today),
            itemBuilder: (BuildContext context) => _views.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList(),
            onSelected: (String value) {
              setState(() {
                if (value == 'Actulizar') {
                  _actualizar();
                } else {
                  _eliminar();
                }
              });
            },
          )),
      body: FutureBuilder(
          future: operationDB.getRecordatorios(),
          builder: (context, snapshot) {
            List<Appointment> collection = <Appointment>[];
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: 1,
                itemExtent: 550,
                itemBuilder: (context, int position) {
                  var item = snapshot.data![position];

                  for (int i = 0;
                      i < (snapshot.data as List).toList().length;
                      i++) {
                    collection.add(
                      Appointment(
                        subject: item.row[1],
                        startTime: _convertDateFromString(item.row[2]),
                        endTime: _convertDateFromString(item.row[3]),
                      ),
                    );
                  }
                  return SfCalendar(
                    view: CalendarView.month,
                    initialDisplayDate: DateTime(2021, 1, 4, 9, 0, 0),
                    monthViewSettings:
                        const MonthViewSettings(showAgenda: true),
                    dataSource: _getCalendarDataSource(collection),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

FechaRecordatorioSource _getCalendarDataSource(List<Appointment> collection) {
  List<Appointment> appointments = collection;
  return FechaRecordatorioSource(appointments);
}

DateTime _convertDateFromString(String date) {
  return DateTime.parse(date);
}

class FechaRecordatorioSource extends CalendarDataSource {
  FechaRecordatorioSource(List<Appointment> source) {
    appointments = source;
  }
}
