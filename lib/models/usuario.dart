import 'package:flutter/cupertino.dart';

class Usuarios {
  late final String id_usuario;
  final String nombre;
  final String correo;
  final String password;

  Usuarios(
      {required this.id_usuario,
      required this.nombre,
      required this.correo,
      required this.password});

  Map<String, dynamic> toMap() {
    return {
      'id_usuario': id_usuario,
      'nombre': nombre,
      'correo': correo,
      'password': password
    };
  }
}
