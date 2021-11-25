import 'package:diabits/db/operation.dart';
import 'package:diabits/models/recordatorio.dart';
import 'package:diabits/pages/alimentos_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  List<Recordatorio> _items = [];
  int id_user = -1;

  _listadoRecordatorios(DateTime date) {
    //creamos la lista para mandarla al listado de recordatorios
    //a partir de los items obtenidos de un año, mes, dia seleccionado.
    List<Recordatorio> _itemsAux = [];
    for (Recordatorio r in _items) {
      DateTime dt = r.fecha;
      if (date.year == dt.year &&
          date.month == dt.month &&
          date.day == dt.day) {
        _itemsAux.add(r);
      }
    }
    Navigator.pushNamed(context, 'listarecordatoriospage', arguments: _itemsAux)
        .then((value) => setState(() {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            }));
  }

  _summit() {
    Navigator.pushNamed(context, 'nuevorecordatorio')
        .then((value) => setState(() {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            }));
  }

  void _regresar() {
    Navigator.pop(context, 'alimentos');
  }

  @override
  void initState() {
    print('ID USUARIO ' + id_user.toString());
    getIdUsuario();
    super.initState();
  }

  getIdUsuario() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print('id_usuario ' + await pref.getInt('id_usuario').toString());
    id_user = await pref.getInt('id_usuario')!;
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
        leading: Row(
          children: <Widget>[
            /*const IconButton(
              onPressed: _regresar, //
              icon: Icon(Icons.arrow_back),
            ),*/
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
      body: FutureBuilder(
        future: operationDB.getRecordatorios(id_user),
        builder: (context, snapshot) {
          List<Appointment> collection = <Appointment>[];
          if (snapshot.hasData) {
            return Stack(children: <Widget>[
              ListView.builder(
                itemCount: 1,
                itemExtent: 550,
                itemBuilder: (context, position) {
                  List items = snapshot.data as List;
                  _items.clear(); //se limpia por si se actualiza.
                  for (Recordatorio r in items) {
                    collection.add(
                      Appointment(
                        color: Colors.blue,
                        subject: r.nombre_recordatorio,
                        startTime: r.fecha,
                        endTime: r.fecha.add(const Duration(hours: 1)),
                      ),
                    );
                    _items.add(r);
                  }
                  return SfCalendar(
                    view: CalendarView.month,
                    cellBorderColor: Colors.black26,
                    backgroundColor: Colors.white10,
                    // ignore: prefer_const_constructors
                    monthViewSettings: MonthViewSettings(),
                    firstDayOfWeek: 7,
                    timeRegionBuilder: (context, timeRegionDetails) =>
                        _build(context),
                    dataSource: _getCalendarDataSource(collection),
                    onSelectionChanged: (CalendarSelectionDetails details) {
                      DateTime date = details.date!;
                      _listadoRecordatorios(date);
                      //setState(() {});
                    },
                  );
                },
              ),
            ]);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
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
