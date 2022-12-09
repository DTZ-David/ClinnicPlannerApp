// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers, avoid_print, prefer_typing_uninitialized_variables, file_names

import 'dart:async';
import 'package:clinnic_planner/domain/controller/control_psicologofirebase.dart';
import 'package:clinnic_planner/domain/models/sesion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/peticionesSesionFirebase.dart';
import '../../../domain/controller/control_sesionfirebase.dart';

class CreateSessionPacientePage extends StatefulWidget {
  final String id;
  const CreateSessionPacientePage({super.key, required this.id});

  @override
  State<CreateSessionPacientePage> createState() =>
      _CreateSessionPacientePageState();
}

var aux = 'Seleccione...';
var identificacion = '';
var fecha2;
var imagen = '';
var hora2;
var id;
var idPaciente;
var idPsicologo;
var _index;
var aux2;

class _CreateSessionPacientePageState extends State<CreateSessionPacientePage> {
  ConsultasControllerSesion controladorSesion = Get.find();
  @override
  Widget build(BuildContext context) {
    ConsultasControllerPsicologo controllerPsicologo = Get.find();
    controllerPsicologo.consultaPsicologo().then((value) => null);
    controladorSesion.consultaSesion().then((value) => null);
    List<String> list = [];

    final miTimer = Timer(const Duration(seconds: 3), () {
      for (var i = 0; i < controllerPsicologo.getPacienteGnral!.length; i++) {
        list.add(controllerPsicologo.getPacienteGnral![i].nombre);
      }
    });

    void cargarId() {
      for (var i = 1; i <= controladorSesion.getSesionGnral!.length; i++) {
        id = i + 1;
      }
    }

    final Stream<QuerySnapshot> _paciente = FirebaseFirestore.instance
        .collection('Psicologos')
        .snapshots(includeMetadataChanges: true);
    int dia = DateTime.now().weekday;
    int fecha = DateTime.now().day;
    List<int> listFechas = <int>[];
    List<String> listaDias = <String>[];
    List<String> listaFechasN = <String>[];
    for (int i = 0; i < 7; i++) {
      if (dia == 1) {
        listaDias.add("Lunes");
        listaFechasN
            .add('${DateTime.now().month}/$fecha/${DateTime.now().year}');
      }
      if (dia == 2) {
        listaDias.add("Martes");
        listaFechasN
            .add('${DateTime.now().month}/$fecha/${DateTime.now().year}');
      }
      if (dia == 3) {
        listaDias.add("Miercoles");
        listaFechasN
            .add('${DateTime.now().month}/$fecha/${DateTime.now().year}');
      }
      if (dia == 4) {
        listaDias.add("Jueves");
        listaFechasN
            .add('${DateTime.now().month}/$fecha/${DateTime.now().year}');
      }
      if (dia == 5) {
        listaDias.add("Viernes");
        listaFechasN
            .add('${DateTime.now().month}/$fecha/${DateTime.now().year}');
      }
      if (dia == 6) {
        listaDias.add("Sabado");
        listaFechasN
            .add('${DateTime.now().month}/$fecha/${DateTime.now().year}');
      }
      if (dia == 7) {
        listaDias.add("Lunes");
        fecha = fecha + 1;
        dia = 1;
        dia = dia + 1;
      } else {
        dia = dia + 1;
        listFechas.add(fecha);
        fecha = fecha + 1;
      }
    }

    List hora = [
      '8:00 - 9:00',
      '9:00 - 10:00',
      '10:00 - 11:00',
      '11:00 - 12:00',
      '14:00 - 15:00',
      '15:00 - 16:00',
      '16:00 - 17:00'
    ];

    return Scaffold(
        body: Obx(
      () => controllerPsicologo.getPacienteGnral?.isEmpty == false
          ? SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: _paciente,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text("Loading");
                              }
                              return DropdownSearch<String>(
                                dropdownSearchDecoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.black))),
                                popupBackgroundColor: Colors.white,
                                mode: Mode.MENU,
                                showSelectedItems: true,
                                items: list,
                                selectedItem: aux,
                                onChanged: (newValue) {
                                  setState(() {
                                    aux = newValue!;
                                    _index = list.indexOf(newValue);
                                    idPsicologo = controllerPsicologo
                                        .getPacienteGnral![_index]
                                        .identificacion;
                                    imagen = controllerPsicologo
                                        .getPacienteGnral![_index].foto;
                                    cargarId();
                                  });
                                },
                              );
                            })),
                    SizedBox(
                      height: 320,
                      width: double.maxFinite,
                      child: _index == null
                          ? const Center(
                              child: Text('Seleccione un Psicologo'),
                            )
                          : ListView.builder(
                              itemCount: 1,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 40, 10, 10),
                                  height: 10,
                                  width: 360,
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      elevation: 5,
                                      child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Positioned(
                                              top: -50,
                                              left: 10,
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 100, top: 10),
                                                height: 100,
                                                width: 100,
                                                child: Card(
                                                  clipBehavior: Clip.hardEdge,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              80)),
                                                  elevation: 2,
                                                  child: Image.network(imagen),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 100,
                                              left: 29,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    controllerPsicologo
                                                        .getPacienteGnral![
                                                            _index]
                                                        .nombre,
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: 120,
                                              left: 29,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    controllerPsicologo
                                                        .getPacienteGnral![
                                                            _index]
                                                        .apellido,
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: 160,
                                              left: 29,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    controllerPsicologo
                                                        .getPacienteGnral![
                                                            _index]
                                                        .telefono,
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ])),
                                );
                              },
                            ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 0),
                      child: const Text('Fecha',
                          style: TextStyle(
                              fontSize: 20, fontFamily: 'RobotoSlab')),
                    ),
                    CargarFecha(listFechas: listFechas, listaDias: listaDias),
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 0),
                      child: const Text('Hora',
                          style: TextStyle(
                              fontSize: 20, fontFamily: 'RobotoSlab')),
                    ),
                    CargarHora(listFechas: listFechas, hora: hora),
                    const SizedBox(height: 20),
                    Container(
                        margin: const EdgeInsets.only(left: 120),
                        height: 40,
                        width: 120,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(250, 6, 68, 108)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          onPressed: () {
                            final sesion = Sesion(
                              idSesion: id.toString(),
                              idPaciente: widget.id,
                              idPsicologo: idPsicologo,
                              fecha: (listaFechasN[aux2]),
                              hora: hora2,
                              notasSesion: '',
                              estado: 'Pendiente',
                            );
                            PeticionesSesion.createSesion(sesion);
                            mensajeAlerta(
                                context, 'Su sesion se agendo correctamente');
                            setState(() {
                              cargarId();
                            });
                          },
                          child: const Text(
                            'Agendar',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ))
                  ]),
            )
          : const Center(child: Icon(Icons.charging_station)),
    ));
  }
}

class CargarHora extends StatefulWidget {
  const CargarHora({
    Key? key,
    required this.listFechas,
    required this.hora,
  }) : super(key: key);

  final List<int> listFechas;
  final List hora;

  @override
  State<CargarHora> createState() => _CargarHoraState();
}

class _CargarHoraState extends State<CargarHora> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50,
      margin: const EdgeInsets.only(left: 20),
      child: ListView.builder(
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return Container(
              margin: const EdgeInsets.only(right: 15, top: 10),
              width: 160,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: color == index
                      ? const Color.fromARGB(250, 6, 68, 108)
                      : null,
                  border: Border.all(color: Colors.black)),
              child: ListTile(
                title: Text(
                  widget.hora.elementAt(index).toString(),
                  style: TextStyle(
                    color: color == index
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : null,
                  ),
                ),
                subtitle: const Text(""),
                //tileColor: color == index ? Colors.blue : null,
                onTap: () {
                  setState(() {
                    color = index;
                    hora2 = widget.hora.elementAt(index);
                  });
                },
              ),
            );
          }),
    );
  }
}

class CargarFecha extends StatefulWidget {
  const CargarFecha({
    Key? key,
    required this.listFechas,
    required this.listaDias,
  }) : super(key: key);

  final List<int> listFechas;
  final List<String> listaDias;

  @override
  State<CargarFecha> createState() => _CargarFechaState();
}

int color = 0;

class _CargarFechaState extends State<CargarFecha> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 80,
      margin: const EdgeInsets.only(left: 20),
      child: ListView.builder(
          itemCount: widget.listFechas.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return Container(
              margin: const EdgeInsets.only(right: 15, top: 10),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: color == index
                      ? const Color.fromARGB(250, 6, 68, 108)
                      : null,
                  border: Border.all(color: Colors.black)),
              child: ListTile(
                title: Text(
                  widget.listFechas.elementAt(index).toString(),
                  style: TextStyle(
                    color: color == index
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : null,
                  ),
                ),
                subtitle: Text(
                  widget.listaDias.elementAt(index),
                  style: TextStyle(
                    color: color == index
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : null,
                  ),
                ),
                //tileColor: color == index ? Colors.blue : null,
                onTap: () {
                  setState(() {
                    color = index;
                    fecha2 = widget.listaDias.elementAt(index);
                    aux2 = index;
                  });
                },
              ),
            );
          }),
    );
  }
}

void mensajeAlerta(BuildContext context1, String texto) {
  var mensaje = texto;
  showDialog(
      barrierColor: const Color.fromARGB(175, 104, 104, 103),
      context: context1,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(250, 6, 68, 108),
          title: const Text(
            "Estado del Proceso",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          content: Text(
            mensaje,
            style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.check, color: Colors.green))
          ],
        );
      });
}
