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
  final String _titlepage = 'Listado Recordatorios';
  final List<Map> _listaRecordatorios = [];
  List<Recordatorio> _items = [];
  OperationDB mydb = OperationDB();

  _getdata(DateTime date) {
    Future.delayed(Duration(milliseconds: 500), () async {
      OperationDB odb = OperationDB();
      _items = await odb.getRecordatoriosFecha(date);
      for (Recordatorio r in _items) {
        _listaRecordatorios.add(r.toMap());
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void _editar(int indiceEditar) {}

  void _eliminar(int index) {}

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
    DateTime date = ModalRoute.of(context)!.settings.arguments as DateTime;
    _getdata(date); //se repite por esta linea
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
