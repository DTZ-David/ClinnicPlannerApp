import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../data/services/peticionesUserFirebase.dart';
import '../../domain/controller/controluserf.dart';
import '../../domain/models/user.dart';

class Registro extends StatefulWidget {
  const Registro({Key? key}) : super(key: key);

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  TextEditingController controluser = TextEditingController();
  TextEditingController controlpassw = TextEditingController();
  ControlAuthFirebase controlu = Get.find();

  late bool _loading = false;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          final shouldPop = await showMyDialog();
          return shouldPop ?? false;
        },
        child: Scaffold(
            body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Image.asset('assets/images/hola.jpg'),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset('assets/images/logo_wl.png'),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(left: 40, right: 40, top: 280),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 80),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          controller: controluser,
                          decoration: const InputDecoration(
                              label: Text(
                            'E-Mail: ',
                            style: TextStyle(
                                color: Color.fromARGB(250, 6, 68, 108)),
                          )),
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: controlpassw,
                          decoration: const InputDecoration(
                              label: Text(
                            'Contraseña: ',
                            style: TextStyle(
                                color: Color.fromARGB(250, 6, 68, 108)),
                          )),
                          obscureText: true,
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(250, 6, 68, 108)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Color.fromARGB(
                                              250, 6, 68, 108))))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text("Registrate"),
                              if (_loading)
                                Container(
                                  height: 20,
                                  width: 20,
                                  margin: const EdgeInsets.only(left: 20),
                                  child:
                                      LoadingAnimationWidget.threeRotatingDots(
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                )
                            ],
                          ),
                          onPressed: () => _registro(context),
                          //onPressed: () => Get.offAllNamed('/registro'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Positioned(
                  top: 300,
                  left: 75,
                  child: Text(
                    'Bienvenido a Clinnic Planner',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(250, 6, 68, 108),
                      fontSize: 16,
                    ),
                  )),
            ],
          ),
        )),
      );

  _registro(BuildContext context) {
    if (!_loading) {
      setState(() {
        _loading = true;
        controlu
            .registrarEmail(controluser.text, controlpassw.text)
            .then((value) {
          if (controlu.emailf != 'Sin Registro') {
            final user = User(
                email: controluser.text,
                password: controlpassw.text,
                rol: 'Paciente');
            PeticionesUser.createUser(user);
            Get.offAllNamed('/registro');
          } else {
            Get.showSnackbar(const GetSnackBar(
              title: 'Validacion de Usuarios',
              message: 'Datos Invalidos',
              icon: Icon(Icons.warning),
              duration: Duration(seconds: 5),
              backgroundColor: Colors.red,
            ));
          }
        });
      });
    }
  }

  Future<bool?> showMyDialog() => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Do you wanna come back?'),
          actions: [
            TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context, false)),
            TextButton(
              child: const Text('HELL YEAH'),
              onPressed: () => Get.offAllNamed('/loginf'),
            )
          ],
        ),
      );
}
