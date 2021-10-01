import 'package:diabits/db/operation.dart';
import 'package:diabits/models/usuario.dart';
import 'package:flutter/material.dart';

class Lista extends StatefulWidget {
  const Lista({Key? key}) : super(key: key);

  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  @override
  Widget build(BuildContext context) {
    OperationDB.usuarios();
    
    return Container();
  }
}
