import 'package:diabits/db/operation.dart';
import 'package:diabits/models/recordatorio.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
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
    locale: const Locale('es', ' '),
    home: Calendario(),
  );
}

class _CalendarioState extends State<Calendario> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  OperationDB operationDB = OperationDB();
  late List<String> _views;

  _summit() {
    Navigator.pushNamed(context, 'nuevorecordatorio')
        .then((value) => setState(() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => super.widget));
    }));
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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _summit,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      appBar: AppBar(
          title: const Text('Calendario de Recordatorios'),
          leading: PopupMenuButton<String>(
            icon: const Icon(Icons.calendar_today),
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
              return Stack(children: <Widget>[
                ListView.builder(
                  itemCount: 1,
                  itemExtent: 550,
                  itemBuilder: (context, position) {
                    List items = snapshot.data as List;
                    for (Recordatorio r in items) {
                      collection.add(
                        Appointment(
                          color: Colors.blue,
                          subject: r.nombre_recordatorio,
                          startTime: r.fecha,
                          endTime: r.fecha.add(const Duration(hours: 1)),
                        ),
                      );
                    }
                    return SfCalendar(
                      view: CalendarView.month,
                      cellBorderColor: Colors.black26,
                      backgroundColor: Colors.white10,
                      // ignore: prefer_const_constructors
                      monthViewSettings: MonthViewSettings(
                        showAgenda: true,
                        agendaStyle: const AgendaStyle(
                          backgroundColor: Colors.white70,
                        ),
                      ),
                      firstDayOfWeek: 7,
                      timeRegionBuilder: (context, timeRegionDetails) =>
                          _build(context),
                      dataSource: _getCalendarDataSource(collection),

                      //SizedBox(height: responsive.dp(.5)),
                    );
                  },
                ),
              ]);
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

class FechaRecordatorioSource extends CalendarDataSource {
  FechaRecordatorioSource(List<Appointment> source) {
    appointments = source;
  }
}