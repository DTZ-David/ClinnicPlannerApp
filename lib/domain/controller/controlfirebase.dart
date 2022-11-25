import 'package:get/get.dart';

import '../../data/services/peticionesPacienteFirebase.dart';
import '../models/paciente.dart';

class ConsultasController extends GetxController {
  final Rxn<List<Paciente>> _pacienteFirestore = Rxn<List<Paciente>>();

  Future<void> consultarPaciente() async {
    _pacienteFirestore.value = await PeticionesPaciente.consultarGral();
  }

  Future<void> consultarPacienteById(String id) async {
    _pacienteFirestore.value = await PeticionesPaciente.consultarById(id);
  }

  List<Paciente>? get getPacienteGnral => _pacienteFirestore.value;

  List<Paciente>? get getPacienteById => _pacienteFirestore.value;
}
