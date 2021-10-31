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
  final List<Map> _listaAlimentos = [];
  List<Alimento> _items = [];
  OperationDB mydb = OperationDB();

  @override
  void initState() {
    getdata();
    super.initState();
  }

  void _editar(int indiceEditar) {
    Navigator.pushNamed(context, 'editaAlimento',
        arguments: _items[indiceEditar]);
  }

  void _eliminar(int index) {
    Alimento a = _items[index];
    _items.removeAt(index);
    _listaAlimentos.removeAt(index);
    mydb.deleteA(a);
    /*Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => super.widget));
  */
    setState(() {});
  }

  getdata() {
    Future.delayed(Duration(milliseconds: 500), () async {
      OperationDB odb = OperationDB();
      _listaAlimentos.clear();
      _items = await odb.getAlimentoss(true);
      for (int i = 0; i < _items.length; i++) {
        _listaAlimentos.add(_items[i].toMap());
      }
      setState(() {});
    });
  }

  int _getIndex(int id) {
    int index = -1;
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].idAlimento == id) {
        index = i;
      }
    }
    return index;
  }

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
    return SingleChildScrollView(
      child: Container(
        child: _listaAlimentos.length == 0
            ? Text("No hay alimentos agregados.")
            : Column(
                children: _listaAlimentos.map((stuone) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.dining),
                      title: Text(
                        stuone["nombre_alimento"],
                      ),
                      subtitle: Text(
                        stuone["nota"],
                      ),
                      trailing: Wrap(
                        children: [
                          IconButton(
                            onPressed: () {
                              //navigate to edit page, pass student roll no to edit
                              int id = stuone['id_alimento'];
                              _editar(_getIndex(id));
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              int id = stuone['id_alimento'];
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
