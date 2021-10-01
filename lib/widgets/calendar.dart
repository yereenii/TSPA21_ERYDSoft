import 'package:diabits/pages/new_reminder_page.dart';
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
  GlobalKey<FormState> _formKey = GlobalKey();

  _summit() {
    Navigator.pushNamed(context, '');
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
        width: 400,
        height: 400,
        child: Column(
          children: <Widget>[
            SizedBox(height: responsive.dp(2)),
            SfCalendar(
              view: CalendarView.month,
              firstDayOfWeek: 7,
              timeRegionBuilder: (context, timeRegionDetails) =>
                  _build(context),
            ),
            SizedBox(height: responsive.dp(2)),
            SizedBox(
              width: responsive.width * 0.50,
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Nuevo',
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
        ));
  }
}
