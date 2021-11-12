import 'package:diabits/db/operation.dart';
import 'package:diabits/models/alimento.dart';
import 'package:flutter/material.dart';

class Articulo4Page extends StatefulWidget {
  //const ListaAlimentosDaninos({Key? key}) : super(key: key);
  static const routeName = 'articulo4';

  @override
  _Articulo4State createState() => _Articulo4State();
}

class _Articulo4State extends State<Articulo4Page> {
  final String _titlepage = 'Articulo 4'; //Titulo del articulo

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
    return Column(
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: 'Hello ',
            style: DefaultTextStyle.of(context).style,
            children: const <TextSpan>[
              TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' world!'),
            ],
          ),
        )
      ],

    );
  }
}
