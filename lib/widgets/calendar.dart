import 'package:diabits/db/operation.dart';
import 'package:diabits/models/recordatorio.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:diabits/utils/responsive.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:diabits/widgets/buton_nuevorecordatorio.dart';

class Calendario extends StatefulWidget {
  Calendario({Key? key}) : super(key: key);

  @override
  _CalendarioState createState() => _CalendarioState();

  recargaridget(BuildContext context) {
    _CalendarioState().build(context);
  }
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
  List<Appointment> r = getAppointments();

  _summit() {
    Navigator.pushNamed(context, 'nuevorecordatorio');
  }

  recargarWidget() {
    r = getAppointments();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    recargarWidget();
    return Positioned(
      bottom: 70,
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: responsive.dp(3)),
            SizedBox(
              height: responsive.height * .8, //altura calendario
              width: responsive.width,
              child: SfCalendar(
                view: CalendarView.month,
                cellBorderColor: Colors.black26,
                backgroundColor: Colors.white10,
                // ignore: prefer_const_constructors
                monthViewSettings: MonthViewSettings(
                  showAgenda: true,
                  agendaStyle: AgendaStyle(
                    backgroundColor: Colors.white70,
                  ),
                  agendaViewHeight: 260,
                ),
                firstDayOfWeek: 7,
                timeRegionBuilder: (context, timeRegionDetails) =>
                    _build(context),
                dataSource: FechaRecordatorioSource(r),
              ),
            ),
            SizedBox(height: responsive.dp(1.5)),
            SizedBox(
              width: responsive.width * 0.50,
              child: MaterialButton(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Nuevo Recordatorio',
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
          ],
        ),
      ),
    );
  }
}

List<Appointment> getAppointments() {
  //Arreglo para los recordatorios
  OperationDB odb = OperationDB();
  List<Appointment> recordatorios = <Appointment>[];
  //List<Recordatorio> auxRec = await odb.getRecordatorios();
  odb.getRecordatorios();
  List<Recordatorio> lr = OperationDB.listaRecordatorios;
  for (Recordatorio r in lr) {
    DateTime startTime = r.fecha;
    DateTime endTime = startTime.add(const Duration(hours: 1));
    String nombreR = r.nombre_recordatorio;
    recordatorios.add(Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: nombreR,
        color: Colors.blue));
  }
  return recordatorios;
}

class FechaRecordatorioSource extends CalendarDataSource {
  FechaRecordatorioSource(List<Appointment> source) {
    appointments = source;
  }
}
