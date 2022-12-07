class Sesion {
  final String idSesion;
  final String idPaciente;
  final String idPsicologo;
  final DateTime fecha;
  final String hora;
  final String notasSesion;
  final String estado;

  Sesion(
      {required this.idSesion,
      required this.idPaciente,
      required this.idPsicologo,
      required this.fecha,
      required this.hora,
      required this.notasSesion,
      required this.estado});

  factory Sesion.desdeDoc(Map<String, dynamic> data) {
    return Sesion(
        idSesion: data['idSesion'] ?? '',
        idPaciente: data['idPaciente'] ?? '',
        idPsicologo: data['idPsicologo'] ?? '',
        fecha: data['fecha'] ?? '',
        hora: data['hora'] ?? '',
        notasSesion: data['notasSesion'] ?? '',
        estado: data['estado'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'idSesion': idSesion,
        'idPaciente': idPaciente,
        'idPsicologo': idPsicologo,
        'fecha': fecha,
        'hora': hora,
        'notasSesion': notasSesion,
        'estado': estado
      };
}
