class Alimento {
  final int? idAlimento;
  final String nombreAlimento;
  final String nota;
  final bool danino;

  Alimento({
    this.idAlimento,
    required this.nombreAlimento,
    required this.nota,
    required this.danino,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_alimento': idAlimento,
      'nombre_alimento': nombreAlimento,
      'nota': nota,
      'danino': danino.toString()
    };
  }
}
