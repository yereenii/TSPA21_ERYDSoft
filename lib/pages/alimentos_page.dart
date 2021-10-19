import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/circles.dart';
import 'package:flutter/material.dart';

class ListadoAlimentos extends StatefulWidget {
  const ListadoAlimentos({Key? key}) : super(key: key);
  static const routeName = 'alimentos';

  @override
  _ListadoAlimentosState createState() => _ListadoAlimentosState();
}

class _ListadoAlimentosState extends State<ListadoAlimentos> {
  final String _titlepage = 'Tipo Alimentos';
  final String _textoAlimentosDaninos = 'Alimentos Dañinos';
  final String _textoAlimentosNoDaninos = 'Alimentos No Dañinos';

  _summitAlimentosDaninos() {
    //Navigator.pushNamed(context, 'routeName');
  }

  _summitAlimentosNoDaninos() {
    //Navigator.pushNamed(context, 'routeName');
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double blueSize = responsive.wp(80); //80% del ancho del dispo
    final double tealAccentSize = responsive.wp(60);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
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
                  top: responsive.height * 0.07,
                  child: Column(
                    children: <Widget>[
                      Text(
                        _titlepage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.dp(1.8),
                        ),
                      ),
                      SizedBox(height: responsive.dp(5)),
                      SizedBox(
                        width: responsive.width * 0.80,
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            _textoAlimentosDaninos,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsive.dp(2),
                            ),
                          ),
                          onPressed: _summitAlimentosDaninos,
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: responsive.dp(1)),
                      SizedBox(
                        width: responsive.width * 0.80,
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            _textoAlimentosNoDaninos,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsive.dp(2),
                            ),
                          ),
                          onPressed: _summitAlimentosNoDaninos,
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
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
