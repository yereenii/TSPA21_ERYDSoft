import 'package:diabits/pages/home_page.dart';
import 'package:diabits/pages/new_reminder_page.dart';
import 'package:diabits/pages/recordatorio_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Orientacion del dispositivo
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

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
      title: 'Dia Bits',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        Recordatorio.routeName: (_) => Recordatorio(),
        NewReminderPage.routeName: (_) => NewReminderPage(),
      },
    );
  }
}
