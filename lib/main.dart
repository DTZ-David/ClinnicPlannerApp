import 'package:clinnic_planner/data/services/peticionesPacienteFirebase.dart';
import 'package:clinnic_planner/data/services/peticionesSesionFirebase.dart';
import 'package:clinnic_planner/domain/controller/control_psicologofirebase.dart';
import 'package:clinnic_planner/domain/controller/control_sesionfirebase.dart';
import 'package:clinnic_planner/domain/controller/control_userFirebase.dart';
import 'package:clinnic_planner/domain/controller/control_pacientefirebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'domain/controller/controluserf.dart';
import 'ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ControlAuthFirebase());
  Get.put(ConsultasControllerUser());
  Get.put(ConsultasControllerPaciente());
  Get.put(PeticionesPaciente());
  Get.put(ConsultasControllerSesion());
  Get.put(ConsultasControllerPsicologo());
  Get.put(PeticionesSesion());

  runApp(const App());
}
