import 'package:diabits/db/operation.dart';
import 'package:diabits/models/recordatorio.dart';
import 'package:flutter/material.dart';

class ListaRecordatoriosPage extends StatefulWidget {
  static const routName = 'listarecordatoriospage';
  //const ListaRecordatoriosPage({Key? key}) : super(key: key);

  @override
  _ListaRecordatoriosPageState createState() => _ListaRecordatoriosPageState();
}

class _ListaRecordatoriosPageState extends State<ListaRecordatoriosPage> {
  OperationDB _mydb = OperationDB();
  final String _titlepage = 'Listado Recordatorios';
  final List<Map> _listaRecordatorios = [];
  List<Recordatorio> _items = [];
  OperationDB mydb = OperationDB();
  bool _primeraVez = true;

  @override
  void initState() {
    super.initState();
  }

  void _editar(int indiceEditar) {
    Navigator.pushNamed(context, 'editarecordatorio',
            arguments: _items[indiceEditar])
        .then((value) => setState(() {
              Navigator.pop(context);
            }));
  }

  void _eliminar(int index) {
    Recordatorio r = _items[index]; //recordatorio a eliminar
    _listaRecordatorios.removeAt(index);
    _items.removeAt(index);
    //llamar a la bd para borrar
    mydb.deleteR(r);
    //_mydb.
    setState(() {
      
    });
  }

  int _getIndex(int id) {
    int index = -1;
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id_recordatorio == id) {
        index = i;
      }
    }
    return index;
  }

  @override
  Widget build(BuildContext context) {
    if (_primeraVez) {
      _items = ModalRoute.of(context)!.settings.arguments as List<Recordatorio>;
      for (Recordatorio r in _items) {
        _listaRecordatorios.add(r.toMap());
      }
      _primeraVez = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Recordatorios'),
      ),
      body: _buildListItem(),
    );
  }

  Widget _buildListItem() {
    return SingleChildScrollView(
      child: Container(
        child: _listaRecordatorios.length == 0
            ? Text("No hay recordatorios agregados.")
            : Column(
                children: _listaRecordatorios.map((stuone) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.calendar_today),
                      title: Text(
                        stuone['nombre_recordatorio'],
                      ),
                      subtitle: Text(
                        stuone['fecha'],
                      ),
                      trailing: Wrap(
                        children: [
                          IconButton(
                            onPressed: () {
                              //navigate to edit page, pass student roll no to edit
                              int id = stuone['id_recordatorio'];
                              _editar(_getIndex(id));
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              int id = stuone['id_recordatorio'];
                              _eliminar(_getIndex(id));
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
