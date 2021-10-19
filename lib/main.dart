import 'package:diabits/pages/alimentos_page.dart';
import 'package:diabits/pages/home_page.dart';
import 'package:diabits/pages/new_reminder_page.dart';
import 'package:diabits/pages/edit_reminder_page.dart';
import 'package:diabits/pages/recordatorio_page.dart';
import 'package:diabits/pages/home_start_page.dart';
import 'package:diabits/utils/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().init(); //

  runApp(MaterialApp(
    home: MyApp(),
    locale: const Locale("en", "US"),
    localizationsDelegates: const [
      DefaultWidgetsLocalizations.delegate,
      DefaultMaterialLocalizations.delegate,
      //DefaultMaterialLocalizations();
      SfGlobalLocalizations.delegate
    ],
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Orientacion del dispositivo
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Localizations(
      locale: const Locale('en', 'US'),
      delegates: const <LocalizationsDelegate<dynamic>>[
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      child: MediaQuery(
        data: const MediaQueryData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MaterialApp(
            title: 'Dia Bits',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomePage(),
            routes: {
              Recordatorio.routeName: (_) => Recordatorio(),
              NewReminderPage.routeName: (_) => NewReminderPage(),
              EditReminderPage.routeName: (_) => EditReminderPage(),
              HomeStartPage.routeName: (_) => HomeStartPage(),
              ListadoAlimentos.routeName: (_) => ListadoAlimentos(),
            },
          ),
        ),
      ),
    );
  }
}
