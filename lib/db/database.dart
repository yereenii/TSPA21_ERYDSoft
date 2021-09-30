import 'package:sqflite/sqflite.dart';
import 'dart:async';

class TaskDatabase {
  late Database db;

  iitDb() async {
    db = await openDatabase('my_db.db', version: 1,
        onCreate: (Database db, int version) {
      db.execute(
          "CREATE TABLE usuarios (id CHAR PRIMARY KEY, nombre VARCHAR2 NOT NULL, correo VARCHAR2 NOT NULL);");
    });
  }
}
