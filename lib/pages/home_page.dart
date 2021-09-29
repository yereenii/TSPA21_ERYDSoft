import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/circle.dart';
import 'package:diabits/widgets/icon_container.dart';
import 'package:diabits/widgets/login_form.dart';
import 'package:flutter/material.dart';

//sft
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double blueSize = responsive.wp(80); //80% del ancho del dispo
    final double cyanSize = responsive.wp(60);

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
                  top: -cyanSize * 0.55,
                  left: -cyanSize * 0.17,
                  child: Circle(
                    size: cyanSize,
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
                      IconContainer(
                        size: responsive.wp(85),
                      ),
                      SizedBox(
                        height: responsive.dp(10), //*********** */
                      ),
                      /**Text(
                        "Hello Again\nWelcome Back!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.dp(1.8),
                        ),
                      ),*/
                    ],
                  ),
                ),
                LoginForm(),
              ],
            ),
            //child: Stack(children: <Widget>[IconContainer()]),
          ),
        ),
      ),
    );
  }
}
