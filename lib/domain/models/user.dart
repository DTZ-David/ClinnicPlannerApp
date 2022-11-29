class User {
  final String email;
  final String password;
  final String rol;

  User({
    required this.email,
    required this.password,
    required this.rol,
  });

  factory User.desdeJson(Map<String, dynamic> json) {
    return User(
        email: json['email'], password: json['password'], rol: json['rol']);
  }
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'rol': rol,
      };
}
