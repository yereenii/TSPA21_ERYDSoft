class Recordatorio {
  final int? id_recordatorio;
  final String nombre_recordatorio;
  final DateTime fecha;
  final int idUsuario;

  Recordatorio({
    this.id_recordatorio,
    required this.nombre_recordatorio,
    required this.fecha,
    required this.idUsuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_recordatorio': id_recordatorio,
      'nombre_recordatorio': nombre_recordatorio,
      'fecha': fecha.toString(),
      'id_usuario': idUsuario
    };
  }
}
