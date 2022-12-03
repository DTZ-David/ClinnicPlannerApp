// ignore_for_file: file_names

import 'package:clinnic_planner/data/services/peticionesSesionFirebase.dart';
import 'package:clinnic_planner/domain/models/sesion.dart';
import 'package:get/get.dart';

class ConsultasControllerSesion extends GetxController {
  final Rxn<List<Sesion>> _sesionFirestore = Rxn<List<Sesion>>();

  Future<void> consultaSesion() async {
    _sesionFirestore.value = await PeticionesSesion.consultarGral();
  }

  List<Sesion>? get getSesionGnral => _sesionFirestore.value;
}
