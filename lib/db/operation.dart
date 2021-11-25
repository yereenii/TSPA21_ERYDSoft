import 'package:diabits/models/recordatorio.dart';
import 'package:diabits/models/usuario.dart';
import 'package:diabits/models/alimento.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class OperationDB {
  static List<Recordatorio> listaRecordatorios = [];
  static List<Alimento> listaAlimentos = [];
  bool _existeUsuario = false;
// Abre la base de datos y guarda la referencia.
  Future<Database> _openDB() async {
    // Establecer la ruta a la base de datos. Nota: Usando la función `join` del
    // complemento `path` es la mejor práctica para asegurar que la ruta sea correctamente
    // construida para cada plataforma.
    String qUsuario =
        "CREATE TABLE usuarios (id_usuario INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nombre VARCHAR2 NOT NULL, correo VARCHAR2 NOT NULL, password VARCHAR2 NOT NULL);";
    String qRecordatorio =
        "CREATE TABLE recordatorios (id_recordatorio INTEGER PRIMARY KEY, nombre_recordatorio VARCHAR2 NOT NULL, fecha Date NOT NULL,id_usuario INTEGER NOT NULL,FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario));";
    String qAlimento =
        "CREATE TABLE alimentos (id_alimento INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nombre_alimento VARCHAR2 NOT NULL, nota VARCHAR2 NOT NULL, danino BOOLEAN,id_usuario INTEGER NOT NULL,FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario));";
    List<String> qCreates = [qUsuario, qRecordatorio, qAlimento];
    return openDatabase(
      join(await getDatabasesPath(), 'db_diabitss.db'),
      onCreate: (db, version) async {
        // Ejecuta la sentencia CREATE TABLE en la base de datos
        for (String query in qCreates) {
          await db.execute(query);
        }
      },
      version: 5,
    );
  }

  Future<int> insertUser(Usuario usuario) async {
    Database database = await _openDB();
    return database.insert('usuarios', usuario.toMap());
  }

  //se trae una lista de la base de datos.
  Future<List<Usuario>> getUsers() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> usuariosMap =
        await database.query("usuarios");
    return List.generate(
        usuariosMap.length,
        (i) => Usuario(
            id_usuario: usuariosMap[i]['id_usuario'],
            nombre: usuariosMap[i]['nombre'],
            correo: usuariosMap[i]['correo'],
            password: usuariosMap[i]['password']));
  }

  Future<bool> _existeUser2(String correo, String password) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> usuariosMap =
        await database.query("usuarios");
    _existeUsuario = false;
    for (var n in usuariosMap) {
      if (n['correo'].toString().compareTo(correo) == 0 &&
          n['password'].toString().compareTo(password) == 0) {
        _existeUsuario = true;
      }
    }
    return Future<bool>.value(true);
  }

  bool existeUser(String correo, String password) {
    _existeUser2(correo, password);
    return _existeUsuario;
  }

  Future<int> insertRecordatorio(Recordatorio recordatorio) async {
    Database database = await _openDB();
    return database.insert('recordatorios', recordatorio.toMap());
  }

  Future<int> editaRecordatorioBD(Recordatorio recordatorio) async {
    Database database = await _openDB();
    return database.update("recordatorios", recordatorio.toMap(),
        where: 'id_recordatorio=?', whereArgs: [recordatorio.id_recordatorio]);
  }

  Future<List<Recordatorio>> getRecordatorios() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> recordatorioMap = await database
        .query("recordatorios", where: 'id_usuario=?', whereArgs: [idUser]);
    List<Recordatorio> auxListaRecordatorios = [];
    listaRecordatorios = auxListaRecordatorios;
    for (var n in recordatorioMap) {
      listaRecordatorios.add(Recordatorio(
          id_recordatorio: n['id_recordatorio'],
          nombre_recordatorio: n['nombre_recordatorio'].toString(),
          fecha: DateTime.parse(n['fecha'].toString()),
          idUsuario: n['id_usuario']));
    }
    return List.generate(
        recordatorioMap.length,
        (i) => Recordatorio(
            id_recordatorio: recordatorioMap[i]['id_recordatorio'],
            nombre_recordatorio: recordatorioMap[i]['nombre_recordatorio'],
            fecha: DateTime.parse((recordatorioMap[i]['fecha'])),
            idUsuario: recordatorioMap[i]['id_usuario']));
  }

  int idUser = 1;
  Future<List<Recordatorio>> getRecordatoriosFecha(
      DateTime date, int idUser) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> recordatorioMap = await database
        .query("recordatorios", where: 'id_usuario=?', whereArgs: [idUser]);
    List<Recordatorio> auxListaRecordatorios = [];
    listaRecordatorios = auxListaRecordatorios;
    for (var n in recordatorioMap) {
      DateTime dt = DateTime.parse(n['fecha']);
      if (date.year == dt.year &&
          date.month == dt.month &&
          date.day == dt.day &&
          idUser == n['id_usuario']) {
        listaRecordatorios.add(Recordatorio(
            id_recordatorio: n['id_recordatorio'],
            nombre_recordatorio: n['nombre_recordatorio'].toString(),
            fecha: DateTime.parse(n['fecha'].toString()),
            idUsuario: n['id_usuario']));
      }
    }
    return List.generate(
        recordatorioMap.length,
        (i) => Recordatorio(
            id_recordatorio: recordatorioMap[i]['id_recordatorio'],
            nombre_recordatorio: recordatorioMap[i]['nombre_recordatorio'],
            fecha: DateTime.parse((recordatorioMap[i]['fecha'])),
            idUsuario: recordatorioMap[i]['id_usuario']));
  }

  Future<int> inserAlimento(Alimento alimento) async {
    Database database = await _openDB();
    return database.insert('alimentos', alimento.toMap());
  }

  bool toBoolean(String str, [bool strict = true]) {
    if (strict == true) {
      return str == '1' || str == 'true';
    }
    return str != '0' && str != 'false' && str != '';
  }

  Future<List<Alimento>> getAlimentoss(bool danino, int idUser) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> alimentoMap = await database.query(
        "alimentos",
        where: 'danino=? and id_usuario=?',
        whereArgs: [danino, idUser]);
    List<Alimento> auxListaAlimentos = [];
    listaAlimentos = auxListaAlimentos;
    for (var n in alimentoMap) {
      if (toBoolean(n['danino']) == danino && idUser == n['id_usuario']) {
        listaAlimentos.add(Alimento(
            idAlimento: n['id_alimento'],
            nombreAlimento: n['nombre_alimento'],
            nota: n['nota'],
            danino: toBoolean(n['danino']),
            idUsuario: n['id_usuario']));
      }
      //return database.update("alimentos", alimento.toMap(),
      //where: 'id_alimento=?', whereArgs: [alimento.idAlimento]);
    }
    return List.generate(
        alimentoMap.length,
        (i) => Alimento(
            idAlimento: alimentoMap[i]['id_alimento'],
            nombreAlimento: alimentoMap[i]['nombre_alimento'],
            nota: alimentoMap[i]['nota'],
            danino: toBoolean(alimentoMap[i]['danino']),
            idUsuario: alimentoMap[i]['id_usuario']));
  }

  Future<int> deleteA(Alimento alimento) async {
    Database database = await _openDB();
    return database.delete("alimentos",
        where: 'id_alimento=?', whereArgs: [alimento.idAlimento]);
  }

  Future<int> editA(Alimento alimento) async {
    Database database = await _openDB();
    return database.update("alimentos", alimento.toMap(),
        where: 'id_alimento=?', whereArgs: [alimento.idAlimento]);
  }

  Future<int> deleteR(Recordatorio recordatorio) async {
    Database database = await _openDB();
    return database.delete("recordatorios",
        where: 'id_recordatorio=?', whereArgs: [recordatorio.id_recordatorio]);
  }
}
