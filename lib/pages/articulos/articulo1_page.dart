import 'package:diabits/db/operation.dart';
import 'package:diabits/models/alimento.dart';
import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/circles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Articulo1Page extends StatefulWidget {
  //const ListaAlimentosDaninos({Key? key}) : super(key: key);
  static const routeName = 'articulo1';

  @override
  _Articulo1State createState() => _Articulo1State();
}

class _Articulo1State extends State<Articulo1Page> {
  final String _titlepage =
      'Cuidados de piel'; //Titulo del articulo
  final String _title =
      'Cuidados en la piel en personas con diabetes';
  final String _subtitle =
      'El mal funcionamiento de las células de defensa reduce la capacidad del organismo de responder al ataque de hongos y bacterias.';
  final String _description ='Problemas cutáneos más comunes en los pacientes con diabetes:'+
  '\n'+'\n'+
  'Dermopatía diabética: Se caracteriza por la aparición de manchas rojizas de entre .5 y dos centímetros de diámetro, que con el tiempo se hacen oscuras y forman pequeñas costras. Se pueden localizar en rodillas, tobillos, muslos o antebrazos, sobre todo en varones.'
  +'\n'+'\n'+
  'Piel amarilla: Es frecuente que la piel de los pacientes con diabetes presente coloración amarillenta en las palmas de las manos y plantas de los pies cuando los niveles de azúcar están por arriba de lo normal, afectando al colágeno'
  +'\n'+'\n'+
  'Bullosis diabeticorum: Se caracteriza por la aparición espontánea de ampollas sobre la piel sana de antebrazos, piernas, pies y dedos, sin embargo, no genera molestias.'
  +'\n'+'\n'+
  'Necrobiosis lipoídica: Son pápulas (erupciones) pequeñas, de color rojo, que tienden a endurecerse. Son más frecuentes en mujeres y se localizan en manos, antebrazos, muslos, abdomen, frente y cuero cabelludo.'
  +'\n'+'\n'+
  'Eritema diabético: Se presenta generalmente en personas de edad avanzada; consiste en la aparición de áreas rojas indoloras bien delimitadas en la parte inferior de las piernas y en los pies. Una variante de este cuadro es la rubeosis diabética, en donde las manchas surgen en la cara y con menos frecuencia en las manos, pero en ningún caso existe tratamiento.';
  final String _url =
      'https://www.gob.mx/salud/documentos/los-cuidados-de-la-piel-en-personas-con-diabetes';
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
                        _subtitle,
                        style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),
                        softWrap: true,
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
            ],
          ),
        ),
      ),
    );
  }
}