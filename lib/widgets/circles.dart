import 'package:diabits/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'circle.dart';

class Circles extends StatefulWidget {
  const Circles({Key? key}) : super(key: key);

  @override
  _CirclesState createState() => _CirclesState();
}

class _CirclesState extends State<Circles> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double blueSize = responsive.wp(88); //80% del ancho del dispo
    final double tealAccentSize = responsive.wp(58);
    return Container(
      width: responsive.width,
      height: responsive.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            //circulo blue
            top: responsive.height * 0.90,
            right: responsive.width * 0.30,
            child: Circle(
              size: blueSize,
              colors: const [Colors.blue, Colors.blueAccent],
            ),
          ),
          Positioned(
            //Circulo cyan
            top: responsive.height * 0.91,
            left: responsive.width * 0.50,
            child: Circle(
              size: tealAccentSize,
              colors: [Colors.tealAccent.shade400, Colors.tealAccent.shade400],
            ),
          ),
        ],
      ),
    );
  }
}
