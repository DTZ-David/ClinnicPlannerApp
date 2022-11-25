// ignore: file_names
import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/paciente.dart';

class PeticionesPaciente {
  //static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> crearPaciente(Map<String, dynamic> paciente, foto) async {
    var url = '';
    if (foto != null) {
      url = await cargarfoto(foto, paciente['identificacion']);
    }

    paciente['foto'] = url.toString();

    await _db
        .collection('Pacientes')
        .doc(paciente['identificacion'])
        .set(paciente)
        .catchError((e) {});
    //return true;
  }

  static Future<dynamic> cargarfoto(var foto, var idArt) async {
    final fs.Reference storageReference =
        fs.FirebaseStorage.instance.ref().child("Pacientes");

    fs.TaskSnapshot taskSnapshot =
        await storageReference.child(idArt).putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();

    return url.toString();
  }

  static Future<void> actualizarArticulo(
      String id, Map<String, dynamic> paciente) async {
    await _db.collection('Pacientes').doc(id).update(paciente).catchError((e) {
      log(e);
    });
    //return true;
  }

  static Future<void> eliminarcatalogo(String id) async {
    await _db.collection('Pacientes').doc(id).delete().catchError((e) {
      log(e);
    });
    //return true;
  }

  static Future<List<Paciente>> consultarGral() async {
    List<Paciente> lista = [];
    await _db.collection("Pacientes").get().then((respuesta) {
      for (var doc in respuesta.docs) {
        log(doc.data().toString());
        lista.add(Paciente.desdeDoc(doc.data()));
      }
    });

    return lista;
  }

  static Future<List<Paciente>> consultarById(String id) async {
    List<Paciente> lista = [];
    await _db
        .collection("Pacientes")
        .where("identificacion", isEqualTo: id)
        .get()
        .then((respuesta) {
      for (var doc in respuesta.docs) {
        log(doc.data().toString());
        lista.add(Paciente.fromJson(doc.data()));
      }
    });

    return lista;
  }

  static Future<List<Paciente>> consultarGralUsuarios(String id) async {
    List<Paciente> lista = [];
    await _db.collection("Usuarios").get().then((respuesta) {
      for (var doc in respuesta.docs) {
        log(doc.data().toString());
        lista.add(Paciente.desdeDoc(doc.data()));
      }
    });

    return lista;
  }
}
