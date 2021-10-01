import 'package:diabits/pages/new_reminder_page.dart';
import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/circle.dart';
import 'package:diabits/widgets/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



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
                //aqui
                Calendario(),
                Positioned(
                  //circulo blue
                  top: -blueSize * -2,
                  right: -blueSize * -0.4,
                  child: Circle(
                    size: blueSize,
                    colors: [Colors.blue, Colors.blue],
                  ),
                ),
                Positioned(
                  //Circulo cyan
                  top: -tealAccentSize * -3,
                  left: -tealAccentSize * -0.77,
                  child: Circle(
                    size: tealAccentSize,
                    colors: [
                      Colors.tealAccent.shade400,
                      Colors.tealAccent.shade400
                    ],
                  ),
                ),

                SizedBox(height: responsive.dp(5)),
                SizedBox(
                  width: responsive.width * 0.62,
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Nuevo Recordatorio',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: responsive.dp(2),
                      ),
                    ),
                    onPressed: ()=> NewReminderPage(),
                    color: Colors.blue.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
            //child: Stack(children: <Widget>[IconContainer()]),
          ),
        ),
      ),
    );
  }
}
