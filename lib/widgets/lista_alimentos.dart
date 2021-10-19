import 'package:flutter/material.dart';

class ListaAlimentos extends StatefulWidget {
  const ListaAlimentos({Key? key}) : super(key: key);
  @override
  _ListaAlimentosState createState() => _ListaAlimentosState();
}

class _ListaAlimentosState extends State<ListaAlimentos> {
  Widget _myListView(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Black'),
        ),
        ListTile(
          title: Text('White'),
        ),
        ListTile(
          title: Text('Grey'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}
