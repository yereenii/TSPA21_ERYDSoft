import 'package:diabits/db/operation.dart';
import 'package:diabits/models/alimento.dart';
import 'package:flutter/material.dart';

class ListaAlimentosDaninos extends StatefulWidget {
  //const ListaAlimentosDaninos({Key? key}) : super(key: key);
  static const routeName = 'listadoalimentosdaninos';

  @override
  _ListaAlimentosDaninosState createState() => _ListaAlimentosDaninosState();
}

class _ListaAlimentosDaninosState extends State<ListaAlimentosDaninos> {
  final String _titlepage = 'Listado Alimentos Dañinos';
  late List<Alimento> _items = [];

  _generarLista() {
    OperationDB odb = OperationDB();
    odb.getAlimentos(true);
    _items = OperationDB.listaAlimentos;
  }

  void _editar(int idiceEditar) {
    Alimento a = _items[idiceEditar];
    print('editar' +
        '${a.idAlimento} ${a.nombreAlimento} ${a.nota} ${a.danino.toString()}');
  }

  void _eliminar(int idiceeliminar) {
    Alimento a = _items[idiceeliminar];
    print('eliminar' +
        '${a.idAlimento} ${a.nombreAlimento} ${a.nota} ${a.danino.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    _generarLista();
    return Scaffold(
      appBar: AppBar(
        title: Text(_titlepage),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _items[index].nombreAlimento,
              style: const TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              _items[index].nota,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            leading: Container(
              width: 90,
              color: Colors.black12,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  Positioned(
                    left: 0,
                    child: IconButton(
                      alignment: Alignment.topLeft,
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        return _eliminar(index);
                      },
                    ),
                  ),
                  Positioned(
                    left: 30,
                    child: IconButton(
                      alignment: Alignment.topRight,
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        return _editar(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
