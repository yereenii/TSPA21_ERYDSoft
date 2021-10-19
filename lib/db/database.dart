import 'package:sqflite/sqflite.dart';
import 'dart:async';

class Login {
  final String s = "";
}

class diabitsDatabase {
  late Database db;

  initDb() async {
    db = await openDatabase('my_db.db', version: 1, onCreate: (
      Database db,
      int version,
    ) {
      db.execute(
          "CREATE TABLE usuarios (id_usuario INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nombre VARCHAR2 NOT NULL, correo VARCHAR2 NOT NULL, password VARCHAR2 NOT NULL);"
          "CREATE TABLE recordatorios (id_recordatorios INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nombre_recordatorio VARCHAR2 NOT NULL, fecha DATE NOT NULL, FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario) );");
    });

    db = await openDatabase('my_db.db', version: 2, onCreate: (
      Database db,
      int version,
    ) {
      db.execute(
          "CREATE TABLE recordatorios (id_recordatorios INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nombre_recordatorio VARCHAR2 NOT NULL, fecha DATE NOT NULL, FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario) );");
    });

    db = await openDatabase('my_db.db', version: 3, onCreate: (
      Database db,
      int version,
    ) {
      db.execute(
          "CREATE TABLE alimentos (id_alimento INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nombre_alimento VARCHAR2 NOT NULL, nota VARCHAR2 NOT NULL, harmfull BOOLEAN, FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario) );");
    });
  }
}
