// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ControlAuthFirebase extends GetxController {
  final FirebaseAuth authf = FirebaseAuth.instance;

  final Rx<dynamic> _uid = "".obs;
  final Rx<dynamic> _usuarior = "Sin Registro".obs;

  String get emailf => _usuarior.value;
  String get uid => _uid.value;
  Future<void> registrarEmail(String u, String p) async {
    try {
      UserCredential usuario =
          await authf.createUserWithEmailAndPassword(email: u, password: p);
      _uid.value = usuario.user!.uid;
      _usuarior.value = usuario.user!.email;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> iniciarSesion(String u, String p) async {
    try {
      UserCredential usuario =
          await authf.signInWithEmailAndPassword(email: u, password: p);
      _uid.value = usuario.user!.uid;
      _usuarior.value = usuario.user!.email;
    } on FirebaseAuthException catch (e) {
      e.code;
    }
  }
}
