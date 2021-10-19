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
  List<Alimento> _items = [];

  _generarLista() {
    _items.add((Alimento(
        idAlimento: 1,
        nombreAlimento: 'cheves',
        danino: true,
        nota: 'A pistear')));
  }

  _editar(Alimento alimento) {
    print(alimento.nombreAlimento);
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
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(
              _items[index].nota,
              style: TextStyle(color: Colors.grey),
            ),
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            leading: IconButton(
              alignment: Alignment.center,
              icon: const Icon(Icons.edit),
              onPressed: _editar(_items[index]), //se manda el objeto a editar
            ),
          );
        },
      ),
    );
  }
}
