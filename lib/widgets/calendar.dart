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
Widget build(BuildContext context) {
  return MaterialApp(
    localizationsDelegates: [
      // ... app-specific localization delegate[s] here
      SfGlobalLocalizations.delegate
    ],
    supportedLocales: [
      const Locale('es'),
      const Locale.fromSubtags(languageCode: 'es'),
      // ... other locales the app supports
    ],
    locale: const Locale('es'),

    home: Calendario(),
  );
}

class _CalendarioState extends State<Calendario> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
      width : 400,
      height: 400,
      child: SfCalendar(
        view: CalendarView.month,
        firstDayOfWeek: 7,
      ),
    );
  }
}
