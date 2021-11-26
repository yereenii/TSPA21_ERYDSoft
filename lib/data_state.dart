import 'package:flutter/cupertino.dart';

import 'models/alimento.dart';

class DataState with ChangeNotifier{
  bool estaCargando = false;
  int totalPaginas = 0;
  int currentPage = 0;
  List<Alimento> _items = [];

}'Hoy a las: ' +
        _fechaCompleta.hour.toString() +
        ':' +
        _fechaCompleta.minute.toString();