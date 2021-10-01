class Recordatorio {
  final String id_recordatorios;
  final String nombre_recordatorio;
  final DateTime fecha;

  Recordatorio(
      {required this.id_recordatorios,
      required this.nombre_recordatorio,
      required this.fecha});

  Map<String, dynamic> toMap() {
    return {
      'id_recordatorios': id_recordatorios,
      'nombre_recordatorio': nombre_recordatorio,
      'fecha': fecha
    };
  }
}
