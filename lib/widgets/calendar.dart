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
    locale: const Locale('es'),
    home: Calendario(),
  );
}

class _CalendarioState extends State<Calendario> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  _summit() {
    Navigator.pushNamed(context, 'nuevorecordatorio');
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Positioned(

      child: Column(children: <Widget>[
        SizedBox(height: responsive.dp(1)),
        SizedBox(
          height: responsive.dp(90),
          child: SfCalendar(
            view: CalendarView.month,
            monthViewSettings: MonthViewSettings(
              showAgenda: true,
              agendaItemHeight: 40, //altura de los bordes de la agenda
              agendaViewHeight: 200, // altura de la ageda
            ),
            firstDayOfWeek: 7,
            timeRegionBuilder: (context, timeRegionDetails) =>
                _build(context),
            dataSource: FechaRecordatorioSource(getAppointments()),
          ),
        ),

      ]),

    );
  }
}

List<Appointment> getAppointments() {
  //Arreglo para los recordatorios
  List<Appointment> recordatorios = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
  DateTime(today.year, today.month, today.day, 22, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 1));

  recordatorios.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Board Meeting',
      color: Colors.blue,
      //recurrenceRule: 'FREQ=DAILY;COUNT=10',
      isAllDay: false));

  return recordatorios;
}

class FechaRecordatorioSource extends CalendarDataSource {
  FechaRecordatorioSource(List<Appointment> source) {
    appointments = source;
  }
}
