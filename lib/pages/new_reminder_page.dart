import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/circle.dart';
import 'package:diabits/widgets/new_reminder_form.dart';
import 'package:flutter/material.dart';

//sft
class NewReminderPage extends StatefulWidget {
  static const routeName = 'nuevorecordatorio';
  //const NewReminderPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<NewReminderPage> {
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
                  top: -blueSize * -1.4,
                  right: -blueSize * -0.4,
                  child: Circle(
                    size: blueSize,
                    colors: const [Colors.blue, Colors.blue],
                  ),
                ),
                Positioned(
                  //Circulo cyan
                  top: -tealAccentSize * -2.45,
                  left: -tealAccentSize * -0.77,
                  child: Circle(
                    size: tealAccentSize,
                    colors: [
                      Colors.tealAccent.shade400,
                      Colors.tealAccent.shade400
                    ],
                  ),
                ),
                Positioned(
                  //icono
                  top: blueSize * 0.60,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Nuevo Recordatorio",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.dp(1.8),
                        ),
                      ),
                      SizedBox(
                        height: responsive.dp(10),
                      ),
                      /***/
                    ],
                  ),
                ),
                const NewReminderForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
