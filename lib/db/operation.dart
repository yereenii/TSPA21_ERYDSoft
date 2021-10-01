import 'package:diabits/models/usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class OperationDB {
// Abre la base de datos y guarda la referencia.
  static Future<Database> _openDB() async {
    // Establecer la ruta a la base de datos. Nota: Usando la función `join` del
    // complemento `path` es la mejor práctica para asegurar que la ruta sea correctamente
    // construida para cada plataforma.
    return openDatabase(
      join(await getDatabasesPath(), 'db_diabits.db'),
      onCreate: (db, version) {
        return db.execute(
          // Ejecuta la sentencia CREATE TABLE en la base de datos
          "CREATE TABLE usuarios (id_usuario CHAR PRIMARY KEY, nombre VARCHAR2 NOT NULL, correo VARCHAR2 NOT NULL, password VARCHAR2 NOT NULL);",
        );
      },
      version: 1,
    );
  }

  static Future<int> insert(Usuarios usuarios) async {
    Database database = await _openDB();
    return database.insert('usuarios', usuarios.toMap());
  }

  //se trae una lista de la base de datos.
  static Future<List<Usuarios>> usuarios() async {
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
        (i) => Usuarios(
            id_usuario: usuariosMap[i]['id_usuario'],
            nombre: usuariosMap[i]['nombre'],
            correo: usuariosMap[i]['correo'],
            password: usuariosMap[i]['password']));
  }

  static Future<bool> exite() async {
    bool seEncontro = false;
    Database database = await _openDB();
    final List<Map<String, dynamic>> usuariosMap =
        await database.query("usuarios");
    for (var n in usuariosMap) {

    }
    return seEncontro;
  }
}
