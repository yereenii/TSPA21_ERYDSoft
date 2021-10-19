import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/circles.dart';
import 'package:diabits/widgets/lista_alimentos.dart';
import 'package:flutter/material.dart';

class ListadoAlimentos extends StatefulWidget {
  //const ListadoAlimentos({Key? key}) : super(key: key);
  static const routeName = 'alimentos';

  @override
  _ListadoAlimentosState createState() => _ListadoAlimentosState();
}

class _ListadoAlimentosState extends State<ListadoAlimentos> {
  final String _titlepage = 'Tipo Alimentos';
  final String _textoAlimentosDaninos = 'Alimentos Dañinos';
  final String _textoAlimentosNoDaninos = 'Alimentos No Dañinos';

  _summitAlimentosDaninos() {
    Navigator.pushNamed(context, 'listadoalimentosdaninos');
  }

  _summitAlimentosNoDaninos() {
    //Navigator.pushNamed(context, 'routeName');
  }

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
                  top: responsive.wp(.01),
                  child: const Circles(),
                ),
                Positioned(
                  top: responsive.height * 0.02,
                  child: Column(
                    children: <Widget>[
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
                      SizedBox(height: responsive.dp(1)),
                      SizedBox(
                        width: responsive.width * 0.50,
                        child: MaterialButton(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Agregar Alimento',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsive.dp(2),
                            ),
                          ),
                          onPressed: () {},
                          color: Colors.blue.shade800,
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
