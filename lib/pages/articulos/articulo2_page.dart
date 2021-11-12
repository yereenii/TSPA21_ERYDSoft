import 'package:diabits/db/operation.dart';
import 'package:diabits/models/alimento.dart';
import 'package:flutter/material.dart';

class Articulo2Page extends StatefulWidget {
  //const ListaAlimentosDaninos({Key? key}) : super(key: key);
  static const routeName = 'articulo2';

  @override
  _Articulo2State createState() => _Articulo2State();
}

class _Articulo2State extends State<Articulo2Page> {
  final String _titlepage = 'Articulo 2'; //Titulo del articulo

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
