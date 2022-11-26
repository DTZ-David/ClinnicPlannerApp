import 'package:clinnic_planner/data/services/peticionesPacienteFirebase.dart';
import 'package:clinnic_planner/domain/models/paciente.dart';
import 'package:get/get.dart';

class ConsultasController extends GetxController {
  final Rxn<List<Paciente>> _pacienteFirestore = Rxn<List<Paciente>>();

  Future<void> consultaPaciente() async {
    _pacienteFirestore.value = await PeticionesPaciente.consultarGral();
  }

  List<Paciente>? get getPacienteGnral => _pacienteFirestore.value;
}
