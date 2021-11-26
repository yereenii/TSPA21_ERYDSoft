import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/circles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Articulo2Page extends StatefulWidget {
  //const ListaAlimentosDaninos({Key? key}) : super(key: key);
  static const routeName = 'articulo2';

  const Articulo2Page({Key? key}) : super(key: key);

  @override
  _Articulo2State createState() => _Articulo2State();
}

class _Articulo2State extends State<Articulo2Page> {
  final String _titlepage =
      'Complicaciones de la diabetes mellitus o de tipo 2'; //Titulo del articulo
  final String _title = 'Complicaciones de la diabetes mellitus o de tipo 2';
  final String _description =
      'Cuanto mejor se controlen los niveles de glucosa en sangre y más '
      'saludables sean los hábitos de vida que se mantienen –alimentación '
      'equilibrada y ejercicio físico, especialmente– más tiempo tardarán '
      'en surgir las posibles complicaciones de la diabetes mellitus, '
      'que pueden afectar a diferentes partes del organismo, '
      'y estás son algunas de la complicaciones:';
  final String _description2 = 'Enfermedades cardiovasculares\n'
      'Complicaciones microvasculares\n'
      'Neuropatía diabética\n'
      'Pie diabético\n';
  final String _url =
      'https://www.sanitas.es/sanitas/seguros/es/particulares/biblioteca-de-salud/diabetes/diabetes-mellitus-complicaciones.html';
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
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(30),
                      //color: Colors.blueGrey.shade200,
                      child: Text(
                        _description,
                        style: const TextStyle(fontSize: 17),
                        softWrap: true,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(30),
                      //color: Colors.blueGrey.shade200,
                      child: Text(
                        _description2,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
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
                          style: const TextStyle(
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
