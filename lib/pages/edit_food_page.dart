import 'package:diabits/models/alimento.dart';
import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/circle.dart';
import 'package:diabits/widgets/circles.dart';
import 'package:diabits/widgets/edit_food_form.dart';
import 'package:flutter/material.dart';

//sft
class EditFoodPage extends StatefulWidget {
  static const routeName = 'editaAlimento';
  const EditFoodPage({
    Key? key,
  }) : super(key: key);
  //const NewFoodPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<EditFoodPage> {
  _HomePageState();
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double blueSize = responsive.wp(80); //80% del ancho del dispo
    final double tealAccentSize = responsive.wp(60);
    Alimento? alimento =
        ModalRoute.of(context)!.settings.arguments as Alimento?;

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
                  top: responsive.wp(.01),
                  child: const Circles(),
                ),
                Positioned(
                  top: responsive.height * 0.10,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Edita Alimento",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.dp(1.8),
                        ),
                      ),
                      SizedBox(height: responsive.dp(20)),
                      EditFoodForm(
                        alimento: alimento,
                      ),
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
