import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/circle.dart';
import 'package:diabits/widgets/circles.dart';
import 'package:diabits/widgets/home_start_form.dart';
import 'package:flutter/material.dart';

//sft
class HomeStartPage extends StatefulWidget {
  static const routeName = 'paginainicio';
  //const HomeStartPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeStartPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double blueSize = responsive.wp(80); //80% del ancho del dispo
    final double tealAccentSize = responsive.wp(60);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.logout_outlined,
        ),
        onPressed: () => HomeStartForm().cerrarSecion(context),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
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
                  top: responsive.wp(.01),
                  child: const Circles(),
                ),
                Positioned(
                  top: responsive.height * 0.10,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Diabits",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.dp(1.8),
                        ),
                      ),
                      SizedBox(height: responsive.dp(20)),
                      const HomeStartForm(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
