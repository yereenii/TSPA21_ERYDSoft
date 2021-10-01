import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/circle.dart';
import 'package:diabits/widgets/icon_container.dart';
import 'package:diabits/widgets/calendar.dart';
import 'package:flutter/material.dart';


class Recordatorio extends StatefulWidget {
  //const Recordatorio({Key? key}) : super(key: key);
  static const routeName = 'recordatorio';
  @override
  _RecordatorioState createState() => _RecordatorioState();
}

class _RecordatorioState extends State<Recordatorio> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double blueSize = responsive.wp(80); //80% del ancho del dispo
    final double tealAccentSize = responsive.wp(60);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          //si da click fuera
          FocusScope.of(context).unfocus();
        },
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
                  //circulo blue
                  top: -blueSize * 0.4,
                  right: -blueSize * 0.2,
                  child: Circle(
                    size: blueSize,
                    colors: [Colors.blue, Colors.blue],
                  ),
                ),
                Positioned(
                  //Circulo cyan
                  top: -tealAccentSize * 0.45,
                  left: -tealAccentSize * 0.17,
                  child: Circle(
                    size: tealAccentSize,
                    colors: [
                      Colors.tealAccent.shade400,
                      Colors.tealAccent.shade400
                    ],
                  ),
                ),
                Calendario(),
              ],
            ),
            //child: Stack(children: <Widget>[IconContainer()]),
          ),
        ),
      ),
    );
  }
}
