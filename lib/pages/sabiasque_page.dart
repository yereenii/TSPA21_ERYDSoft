import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/circles.dart';
import 'package:diabits/widgets/lista_alimentos.dart';
import 'package:flutter/material.dart';

class SabiasQuePage extends StatefulWidget {
  //const ListadoAlimentos({Key? key}) : super(key: key);
  static const routeName = 'sabiasque';

  @override
  _SabiasQueState createState() => _SabiasQueState();
}

class _SabiasQueState extends State<SabiasQuePage> {
  final String _titlepage = '¿Sabías Qué?';
  final String _textoArticulo1 = 'Articulo 1'; //aqui va el nombre del articulo
  final String _textoArticulo2 =
      'Complicaciones de la diabetes mellitus'; //aqui va el nombre del articulo
  final String _textoArticulo3 =
      '¿Cómo prevenir la diabetes?'; //aqui va el nombre del articulo
  final String _textoArticulo4 =
      'El azúcar en la sangre hace la diferencia.'; //aqui va el nombre del articulo

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_titlepage),
      ),
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
                  top: responsive.height * 0.02,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: responsive.width * 0.80,
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            _textoArticulo1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsive.dp(2),
                            ),
                          ),
                          onPressed: () async =>
                              Navigator.pushNamed(context, 'articulo1'),
                          color: Colors.deepPurple.shade400,
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
                            _textoArticulo2,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsive.dp(2),
                            ),
                          ),
                          onPressed: () async =>
                              Navigator.pushNamed(context, 'articulo2'),
                          color: Colors.green.shade400,
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
                            _textoArticulo3,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsive.dp(2),
                            ),
                          ),
                          onPressed: () async =>
                              Navigator.pushNamed(context, 'articulo3'),
                          color: Colors.amberAccent.shade400,
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
                            _textoArticulo4,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsive.dp(2),
                            ),
                          ),
                          onPressed: () async =>
                              Navigator.pushNamed(context, 'articulo4'),
                          color: Colors.orange.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: responsive.wp(-25),
                  child: const Circles(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
