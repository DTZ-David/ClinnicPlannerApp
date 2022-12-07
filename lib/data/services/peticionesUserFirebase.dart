// ignore_for_file: file_names

import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/user.dart';

class PeticionesUser {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future createUser(User user) async {
    final docUser =
        FirebaseFirestore.instance.collection("Usuarios").doc(user.id);

    final json = user.toJson();
    await docUser.set(json);
  }

  static Future<List<User>> consultarGral() async {
    List<User> lista = [];
    await _db.collection("Usuarios").get().then((respuesta) {
      for (var doc in respuesta.docs) {
        log(doc.data().toString());
        lista.add(User.desdeJson(doc.data()));
      }
    });

    return lista;
  }
}
