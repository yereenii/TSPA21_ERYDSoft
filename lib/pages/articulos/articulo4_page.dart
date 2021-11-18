import 'package:diabits/db/operation.dart';
import 'package:diabits/models/alimento.dart';
import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/circles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Articulo4Page extends StatefulWidget {
  //const ListaAlimentosDaninos({Key? key}) : super(key: key);
  static const routeName = 'articulo4';

  @override
  _Articulo4State createState() => _Articulo4State();
}

class _Articulo4State extends State<Articulo4Page> {
  final String _titlepage =
      'El azúcar en la sangre puede hacer toda la diferencia.'; //Titulo del articulo
  final String _title =
      'El azúcar en la sangre puede hacer toda la diferencia.';
  final String _description =
      'El azúcar en la sangre, o glucosa en la sangre, es un número importante cuando se trata del control de la diabetes.'
      'Muchos alimentos se descomponen en azúcar en la sangre, que se utiliza para obtener energía para alimentar nuestro cerebro, corazón y músculos. El azúcar en la sangre proviene de los alimentos que comemos o es hecho por el hígado, y se encuentra en el torrente sanguíneo (ya que se lleva a todos nuestros órganos y células) y dentro de las células (donde se transforma en energía).'
      'Si está luchando para controlar sus niveles de azúcar en la sangre, no está solo.'
      'La buena noticia es que, con las últimas herramientas y estrategias, puede tomar medidas para controlar su azúcar en la sangre, prevenir complicaciones graves y prosperar.';
  final String _url =
      'https://www.diabetes.org/healthy-living/medication-treatments/blood-glucose-testing-and-control';
  final String _ver = 'Ver más...';

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
          height: responsive.height,
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
                        style: TextStyle(fontSize: 20),
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
                          launch(_url);
                        },
                        child: Text(
                          _ver,
                          style: TextStyle(
                            color: Colors.blue,
                          ),
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
    );
  }
}
