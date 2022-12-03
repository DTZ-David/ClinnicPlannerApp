import 'package:clinnic_planner/data/services/peticionesPsicologoFirebase.dart';
import 'package:clinnic_planner/domain/models/psicologo.dart';
import 'package:get/get.dart';

class ConsultasControllerPsicologo extends GetxController {
  final Rxn<List<Psicologo>> _psicologoFirestore = Rxn<List<Psicologo>>();

  Future<void> consultaPsicologo() async {
    _psicologoFirestore.value = await PeticionesPsicologo.consultarGral();
  }

  List<Psicologo>? get getPacienteGnral => _psicologoFirestore.value;
}
