// ignore_for_file: file_names

import 'package:get/get.dart';
import '../../data/services/peticionesUserFirebase.dart';
import '../models/user.dart';

class ConsultasControllerUser extends GetxController {
  final Rxn<List<User>> _userFirestore = Rxn<List<User>>();

  Future<void> consultarUsuario() async {
    _userFirestore.value = await PeticionesUser.consultarGral();
  }

  List<User>? get getUserGeneral => _userFirestore.value;
}
