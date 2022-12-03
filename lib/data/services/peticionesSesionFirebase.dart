// ignore_for_file: file_names

import 'dart:developer';
import 'package:clinnic_planner/domain/models/sesion.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:cloud_firestore/cloud_firestore.dart';

class PeticionesSesion {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future createSesion(Sesion sesion) async {
    final docUser =
        FirebaseFirestore.instance.collection("Sesiones").doc(sesion.idSesion);

    final json = sesion.toJson();
    await docUser.set(json);
  }

  static Future<List<Sesion>> consultarGral() async {
    List<Sesion> lista = [];
    await _db.collection('Sesiones').get().then((value) {
      for (var doc in value.docs) {
        log(doc.data().toString());
        lista.add(Sesion.desdeDoc(doc.data()));
      }
    });

    return lista;
  }
}
