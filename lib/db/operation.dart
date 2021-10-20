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
        "CREATE TABLE recordatorios (id_recordatorio INTEGER PRIMARY KEY, nombre_recordatorio VARCHAR2 NOT NULL, fecha Date NOT NULL);";
    String qAlimento =
        "CREATE TABLE alimentos (id_alimento INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nombre_alimento VARCHAR2 NOT NULL, nota VARCHAR2 NOT NULL, danino BOOLEAN);";
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

  Future<List<Recordatorio>> getRecordatorios() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> recordatorioMap =
        await database.query("recordatorios");
    List<Recordatorio> auxListaRecordatorios = [];
    listaRecordatorios = auxListaRecordatorios;
    for (var n in recordatorioMap) {
      listaRecordatorios.add(Recordatorio(
          id_recordatorio: n['id_recordatorio'],
          nombre_recordatorio: n['nombre_recordatorio'].toString(),
          fecha: DateTime.parse(n['fecha'].toString())));
      print("____" +
          n['id_recordatorio'].toString() +
          "_" +
          n['nombre_recordatorio'].toString() +
          "_" +
          n['fecha'].toString());
    }
    return List.generate(
        recordatorioMap.length,
        (i) => Recordatorio(
            id_recordatorio: recordatorioMap[i]['id_recordatorio'],
            nombre_recordatorio: recordatorioMap[i]['nombre_recordatorio'],
            fecha: DateTime.parse((recordatorioMap[i]['fecha']))));
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

  Future<List<Alimento>> getAlimentos() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> alimentoMap =
        await database.query("alimentos");
    for (var n in alimentoMap) {
      listaAlimentos.add(Alimento(
          idAlimento: n['id_alimento'],
          nombreAlimento: n['nombre_alimento'],
          nota: n['nota'],
          danino: toBoolean(n['danino'])));
      print("_____ idAlimento " +
          n['id_alimento'].toString() +
          " _ nombreAlimento " +
          n['nombe_alimento'].toString() +
          " _ nota " +
          n['nota'].toString() +
          " _ dañino " +
          n['danino'].toString());
    }

    return List.generate(
        alimentoMap.length,
        (i) => Alimento(
            idAlimento: alimentoMap[i]['id_alimento'],
            nombreAlimento: alimentoMap[i]['nombre_alimento'],
            nota: alimentoMap[i]['nota'],
            danino: toBoolean(alimentoMap[i]['danino'])));
  }
}
