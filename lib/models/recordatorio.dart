class Recordatorio {
  final int? id_recordatorio;
  final String nombre_recordatorio;
  final DateTime fecha;
  //final int id_usuario;

  Recordatorio({
    this.id_recordatorio,
    required this.nombre_recordatorio,
    required this.fecha,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_recordatorio': id_recordatorio,
      'nombre_recordatorio': nombre_recordatorio,
      'fecha': fecha.toString(),
      //'id_usuario': id_usuario
    };
  }
}
