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
      'id_Alimento': idAlimento,
      'nombre_Alimento': nombreAlimento,
      'nota': nota,
      'danino': danino.toString()
    };
  }
}
