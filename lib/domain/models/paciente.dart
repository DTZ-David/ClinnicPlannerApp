class Paciente {
  final String tipoId;
  final String identificacion;
  final String nombre;
  final String apellido;
  final String direccion;
  final String telefono;
  final String email;
  final String fechaNacimiento;
  final String edad;
  final String sexo;
  final String foto;

  Paciente(
      {required this.tipoId,
      required this.identificacion,
      required this.nombre,
      required this.apellido,
      required this.sexo,
      required this.fechaNacimiento,
      required this.direccion,
      required this.email,
      required this.telefono,
      required this.edad,
      required this.foto});

  factory Paciente.desdeDoc(Map<String, dynamic> data) {
    return Paciente(
      tipoId: data['tipoId'] ?? '',
      identificacion: data['identificacion'] ?? '',
      nombre: data['nombre'] ?? '',
      apellido: data['apellido'] ?? '',
      sexo: data['sexo'] ?? '',
      fechaNacimiento: data['fechaNacimiento'] ?? '',
      direccion: data['direccion'] ?? '',
      email: data['email'] ?? '',
      telefono: data['telefono'] ?? '',
      edad: data['edad'] ?? '',
      foto: data['foto'] ?? '',
    );
  }

  static Paciente fromJson(Map<String, dynamic> json) => Paciente(
      tipoId: json['tipoId'],
      identificacion: json['identificacion'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      sexo: json['sexo'],
      fechaNacimiento: json['fechaNacimiento'],
      direccion: json['direccion'],
      email: json['email'],
      telefono: json['telefono'],
      edad: json['edad'],
      foto: json['foto'] ?? '');

  Map<String, dynamic> toJson() => {
        'tipoId': tipoId,
        'identificacion': identificacion,
        'nombre': nombre,
        'apellido': apellido,
        'sexo': sexo,
        'fechaNacimiento': fechaNacimiento,
        'direccion': direccion,
        'email': email,
        'telefono': telefono,
        'edad': edad,
        'foto': foto,
      };
}
