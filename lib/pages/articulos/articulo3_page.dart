import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/circles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Articulo3Page extends StatefulWidget {
  //const ListaAlimentosDaninos({Key? key}) : super(key: key);
  static const routeName = 'articulo3';

  const Articulo3Page({Key? key}) : super(key: key);
  @override
  _Articulo3State createState() => _Articulo3State();
}

class _Articulo3State extends State<Articulo3Page> {
  final String _titlepage =
      '¿Cómo se puede prevenir la diabetes?'; //Titulo del articulo
  final String _title =
      '¿Cómo se puede prevenir la diabetes?';
  final String _description =
      'La diabetes es una enfermedad que afecta a millones de personas en el mundo. '
      ' Antes de diagnosticar la diabetes existe un período en el que los niveles de azucar en la sangre son altos, aunque podemos bajar el consumo de azucar si cambiamos nuestros hábitos alimenticios. '
      'Eliminando el azúcar y los carbohidratos refinados de nuestra dieta, hacer ejercicio regularmente, beber más agua, bajar de peso si tienes obesidad, dejar de fumar, cuidar las porciones de consumo, evitar la falta de actividad física, minimizar el consumo en alimentos procesados, tomar café es beneficioso, así como realizar chequeos regulares con su médico. '
      ' Podemos prevenir la diabetes si cambiamos nuestros hábitos, para así mantener un estilo de vida más saludable. ';
  final String _url1 =
      'https://www.healthline.com/health/es/como-prevenir-la-diabetes#En-conclusin';
  final String _ver1 = 'Si quieres conocer más visita esta página.';
  final String _url2 =
      'https://www.niddk.nih.gov/health-information/informacion-de-la-salud/diabetes/informacion-general/factores-riesgo-tipo-2';
  final String _ver2 = 'Más información.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titlepage),
      ),
      body: _buildListItem(),
    );
  }

  Widget _buildListItem() {
    final Responsive responsive = Responsive.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Container(
          width: responsive.width,
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(30),
                      child: Text(
                        _title,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(30),
                      //color: Colors.blueGrey.shade200,
                      child: Text(
                        _description,
                        style: TextStyle(fontSize: 17),
                        softWrap: true,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(30),
                      child: MaterialButton(
                        onPressed: () {
                          launch(_url1);
                        },
                        child: Text(
                          _ver1,
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(30),
                      child: MaterialButton(
                        onPressed: () {
                          launch(_url2);
                        },
                        child: Text(
                          _ver2,
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(
                child: Circles(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
