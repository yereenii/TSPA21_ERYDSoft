
class Usuarios {
  final String id_usuario;
  final String nombre;
  final String correo;
  final String password;

  Usuario(
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
