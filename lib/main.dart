import 'package:diabits/pages/home_page.dart';
import 'package:diabits/pages/new_reminder_page.dart';
import 'package:diabits/pages/recordatorio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
