import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/calendar_form.dart';
import 'package:diabits/widgets/circles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CalendarioPage extends StatefulWidget {
  //const Recordatorio({Key? key}) : super(key: key);
  static const routeName = 'calendario';
  @override
  _CalendarioPage createState() => _CalendarioPage();
}

class _CalendarioPage extends State<CalendarioPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double blueSize = responsive.wp(80); //80% del ancho del dispo
    final double tealAccentSize = responsive.wp(60);

    return Scaffold(
      body: GestureDetector(
        child: SingleChildScrollView(
          //la altura es dinamica calculada a los elementos hijos
          child: Container(
            width: responsive.width,
            height: responsive.height,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: responsive.wp(.01),
                  child: const Circles(),
                ),
                Calendario(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
