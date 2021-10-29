import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/circles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SabiasQue extends StatefulWidget {
  //const Recordatorio({Key? key}) : super(key: key);
  static const routeName = 'sabiasque';
  @override
  _SabiasQue createState() => _SabiasQue();
}

class _SabiasQue extends State<SabiasQue> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

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
                const Text("Trabajo en progreso"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
