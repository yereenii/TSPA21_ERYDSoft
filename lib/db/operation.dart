import 'package:diabits/models/recordatorio.dart';
import 'package:diabits/models/usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class OperationDB {
  bool _existeUsuario = false;
// Abre la base de datos y guarda la referencia.
  Future<Database> _openDB() async {
    // Establecer la ruta a la base de datos. Nota: Usando la función `join` del
    // complemento `path` es la mejor práctica para asegurar que la ruta sea correctamente
    // construida para cada plataforma.
    return openDatabase(
      join(await getDatabasesPath(), 'db_diabits.db'),
      onCreate: (db, version) {
        return db.execute(
          // Ejecuta la sentencia CREATE TABLE en la base de datos
          "CREATE TABLE usuarios (id_usuario CHAR PRIMARY KEY, nombre VARCHAR2 NOT NULL, correo VARCHAR2 NOT NULL, password VARCHAR2 NOT NULL);" +
              "CREATE TABLE recordatorios (id_recordatorios CHAR PRIMARY KEY, nombre_recordatorio VARCHAR2 NOT NULL, fecha DATE NOT NULL, FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario) );",
        );
      },
      version: 2,
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
    for (var n in usuariosMap) {
      //ver que funcione
      print("____" +
          n['nombre'] +
          "_" +
          n['id_usuario'] +
          "_" +
          n['correo'] +
          "_" +
          n['password']);
    }
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
        print("####### si existeUser");
        _existeUsuario = true;
      }
    }
    print(
        "####### existeUser >>> correo: $correo password: $password  $_existeUsuario");
    return Future<bool>.value(true);
  }

  bool existeUser(String correo, String password) {
    _existeUser2(correo, password);
    print(" valor final existeUser : $_existeUsuario");
    return _existeUsuario;
  }

  Future<int> insertRecordatorio(Recordatorio recordatorio) async {
    Database database = await _openDB();
    return database.insert('recordatorios', recordatorio.toMap());
  }

  Future<List<Recordatorio>> getRecordatorio() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> recordatorioMap =
        await database.query("recordatorio");
    for (var n in recordatorioMap) {
      //ver que funcione
      print("____" +
          n['nombre'] +
          "_" +
          n['id_usuario'] +
          "_" +
          n['correo'] +
          "_" +
          n['password']);
    }
    return List.generate(
        recordatorioMap.length,
        (i) => Recordatorio(
            id_recordatorios: recordatorioMap[i]['fecha'],
            nombre_recordatorio: recordatorioMap[i]['nombre_recordatorio'],
            fecha: recordatorioMap[i]['fecha']));
  }


}
