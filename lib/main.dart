import 'package:clinnic_planner/data/services/peticionesPacienteFirebase.dart';
import 'package:clinnic_planner/domain/controller/control_userFirebase.dart';
import 'package:clinnic_planner/domain/controller/controlfirebase.dart';
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

  runApp(const App());
}
