// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:clinnic_planner/domain/controller/control_pacientefirebase.dart';
import 'package:clinnic_planner/domain/controller/control_sesionfirebase.dart';
import 'package:clinnic_planner/ui/pages/nav_pages_patient/main_pagePaciente.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../domain/controller/control_userFirebase.dart';
import '../../domain/controller/controluserf.dart';
import '../pages/nav_pages_psychologist/main_page.dart';
import 'registro.dart';

class Loginf extends StatefulWidget {
  const Loginf({Key? key}) : super(key: key);

  @override
  State<Loginf> createState() => _LoginfState();
}

class _LoginfState extends State<Loginf> {
  TextEditingController controluser = TextEditingController();
  TextEditingController controlpassw = TextEditingController();
  ControlAuthFirebase controlu = Get.find();

  late bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 70),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      controller: controluser,
                      decoration: const InputDecoration(
                          label: Text(
                        'E-Mail: ',
                        style:
                            TextStyle(color: Color.fromARGB(250, 6, 68, 108)),
                      )),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: controlpassw,
                      decoration: const InputDecoration(
                          label: Text(
                        'Contraseña: ',
                        style:
                            TextStyle(color: Color.fromARGB(250, 6, 68, 108)),
                      )),
                      obscureText: true,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(250, 6, 68, 108)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Color.fromARGB(
                                              250, 6, 68, 108))))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Iniciar Sesion"),
                          if (_loading)
                            Container(
                              height: 20,
                              width: 20,
                              margin: const EdgeInsets.only(left: 20),
                              child: LoadingAnimationWidget.threeRotatingDots(
                                color: Colors.white,
                                size: 15,
                              ),
                            )
                        ],
                      ),
                      onPressed: () => _login(context),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: const Text(
                            "No tienes una cuenta?",
                            style: TextStyle(
                                color: Color.fromARGB(250, 6, 68, 108),
                                fontSize: 16),
                          ),
                          onTap: () {
                            Get.to(() => const Registro(),
                                transition: Transition.fade,
                                duration: const Duration(seconds: 1));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          /*const Positioned(
              top: 260,
              left: 61,
              child: Text(
                'Login',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromARGB(250, 6, 68, 108), fontSize: 20),
              )),
          const Positioned(
              top: 260,
              left: 215,
              child: Text(
                'Sing Up',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(250, 6, 68, 108),
                  fontSize: 20,
                ),
              )),*/
          const Positioned(
              top: 310,
              left: 100,
              child: Text(
                'Bienvenido de vuelta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(250, 6, 68, 108),
                  fontSize: 16,
                ),
              )),
        ],
      ),
    ));
  }

  _login(BuildContext context) {
    var id2;
    ConsultasControllerUser controladorUser = Get.find();
    controladorUser.consultarUsuario().then((value) => null);

    ConsultasControllerPaciente controladorPaciente = Get.find();
    controladorPaciente.consultaPaciente().then((value) => null);

    ConsultasControllerSesion controladorSesion = Get.find();
    controladorSesion.consultaSesion().then((value) => null);
    if (!_loading) {
      if (controlpassw.text.isEmpty || controluser.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color.fromARGB(250, 6, 68, 108),
            content: Text(
              'Por favor ingrese su usuario y contraseña para ingresar',
              style: TextStyle(color: Colors.white),
            )));
      } else {
        setState(() {
          _loading = true;
          controlu
              .iniciarSesion(controluser.text, controlpassw.text)
              .then((value) {
            if (controlu.emailf != 'Sin Registro' &&
                controlu.uid != 'Sin Registro') {
              final miTimer = Timer(const Duration(seconds: 3), () {
                for (var i = 0;
                    i < controladorUser.getUserGeneral!.length;
                    i++) {
                  if (controladorUser.getUserGeneral![i].email ==
                      controluser.text) {
                    if (controladorUser.getUserGeneral![i].rol == 'Psicologo') {
                      id2 = controladorUser.getUserGeneral![i].id;
                      Get.to(() => MainPage(id: id2),
                          transition: Transition.cupertino,
                          duration: const Duration(seconds: 1));
                    } else {
                      id2 = controladorUser.getUserGeneral![i].id;

                      Get.to(() => MainPagePaciente(id: id2),
                          transition: Transition.cupertino,
                          duration: const Duration(seconds: 1));
                    }
                  }
                }
              });
            } else {
              Get.showSnackbar(const GetSnackBar(
                title: 'Validacion de Usuarios',
                message: 'Datos Invalidos',
                icon: Icon(Icons.warning),
                duration: Duration(seconds: 5),
                backgroundColor: Colors.red,
              ));
              setState(() {
                _loading = false;
              });
            }
          });
        });
      }
    }
  }
}
