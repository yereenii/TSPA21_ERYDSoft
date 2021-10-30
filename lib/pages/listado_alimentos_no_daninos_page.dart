import 'package:diabits/db/operation.dart';
import 'package:diabits/models/alimento.dart';
import 'package:flutter/material.dart';

class ListaAlimentosNoDaninos extends StatefulWidget {
  //const ListaAlimentosDaninos({Key? key}) : super(key: key);
  static const routeName = 'listadoalimentosnodaninos';

  @override
  _ListaAlimentosNoDaninosState createState() => _ListaAlimentosNoDaninosState();
}

class _ListaAlimentosNoDaninosState extends State<ListaAlimentosNoDaninos> {
  final String _titlepage = 'Listado Alimentos No Dañinos';
  final List<Map> _listaAlimentos = [];
  List<Alimento> _items = [];
  OperationDB mydb = OperationDB();

  void _editar(int indiceEditar) {
    Navigator.pushNamed(context, 'editaAlimento',
        arguments: _items[indiceEditar]);
  }

  void _eliminar(int index) {
    Alimento a = _items[index];
    mydb.deleteA(a);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => super.widget));
    getdata();
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() {
    Future.delayed(Duration(milliseconds: 500), () async {
      OperationDB odb = OperationDB();
      _items = await odb.getAlimentoss(false);
      setState(() {});
      for (int i = 0; i < _items.length; i++) {
        _listaAlimentos.add(_items[i].toMap());
      }
    });
  }

  int _getIndex(int id) {
    int index = -1;
    print(id);
    for (int i = 0; i < _items.length; i++) {
      //print(id + " " + _items[i]);
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
