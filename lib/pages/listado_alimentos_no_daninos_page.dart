import 'package:diabits/db/operation.dart';
import 'package:diabits/models/alimento.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaAlimentosNoDaninos extends StatefulWidget {
  //const ListaAlimentosDaninos({Key? key}) : super(key: key);
  static const routeName = 'listadoalimentosnodaninos';

  @override
  _ListaAlimentosNoDaninosState createState() => _ListaAlimentosNoDaninosState();
}

class _ListaAlimentosNoDaninosState extends State<ListaAlimentosNoDaninos> {
  final String _titlepage = 'Listado Alimentos No Dañinos';
  late List<Alimento> _items = [];

  _generarLista() {
    OperationDB odb = OperationDB();
    odb.getAlimentos(false);
    _items = OperationDB.listaAlimentos;
  }

  //void _editar(int indiceEditar) {
    //OperationDB odb = OperationDB();
    //Alimento a = _items[indiceEditar];
    //odb.editA(a);
    //print('editar' +
      //  '${a.idAlimento} ${a.nombreAlimento} ${a.nota} ${a.danino.toString()}');
 // }

  void _eliminar(int indiceEliminar) {
    OperationDB odb = OperationDB();
    Alimento a = _items[indiceEliminar];
    odb.deleteA(a);
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
                      onPressed: () async => {
                        Navigator.pushNamed(context, 'editaAlimento')
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
