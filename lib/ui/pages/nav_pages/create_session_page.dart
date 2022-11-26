// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../domain/controller/controlfirebase.dart';

class CreateSessionPage extends StatefulWidget {
  const CreateSessionPage({super.key});

  @override
  State<CreateSessionPage> createState() => _CreateSessionPageState();
}

var aux = 'Seleccione...';
var identificacion = '';
var imagen =
    'https://firebasestorage.googleapis.com/v0/b/clinnicplanner-56316.appspot.com/o/Pacientes%2FIdentificación%3A?alt=media&token=de2a1266-6e76-40cb-904c-7dd32eebf4cb';
var imagen1 = '';
var imagen2 = '';
int _index = 0;

class _CreateSessionPageState extends State<CreateSessionPage> {
  @override
  Widget build(BuildContext context) {
    ConsultasController controladorPaciente = Get.find();
    controladorPaciente.consultaPaciente().then((value) => null);
    List<String> list = [];

    final miTimer = Timer(const Duration(seconds: 3), () {
      for (var i = 1; i < controladorPaciente.getPacienteGnral!.length; i++) {
        list.add(controladorPaciente.getPacienteGnral![i].nombre);
      }
    });

    final Stream<QuerySnapshot> _paciente = FirebaseFirestore.instance
        .collection('Paciente')
        .snapshots(includeMetadataChanges: true);
    int dia = DateTime.now().weekday;
    int fecha = DateTime.now().day;
    List<int> listFechas = <int>[];
    List<String> listaDias = <String>[];
    for (int i = 0; i < 7; i++) {
      if (dia == 1) {
        listaDias.add("Lunes");
      }
      if (dia == 2) {
        listaDias.add("Martes");
      }
      if (dia == 3) {
        listaDias.add("Miercoles");
      }
      if (dia == 4) {
        listaDias.add("Jueves");
      }
      if (dia == 5) {
        listaDias.add("Viernes");
      }
      if (dia == 6) {
        listaDias.add("Sabado");
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
      () => controladorPaciente.getPacienteGnral?.isEmpty == false
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
                                popupBackgroundColor: Colors.transparent,
                                mode: Mode.MENU,
                                showSelectedItems: true,
                                items: list,
                                selectedItem: aux,
                                onChanged: (newValue) {
                                  setState(() {
                                    aux = newValue!;
                                    _index = list.indexOf(newValue);
                                  });
                                },
                              );
                            })),
                    SizedBox(
                      height: 320,
                      width: double.maxFinite,
                      child: ListView.builder(
                        itemCount: 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                            height: 10,
                            width: 360,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 5,
                                child:
                                    Stack(clipBehavior: Clip.none, children: [
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
                                                BorderRadius.circular(80)),
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
                                          controladorPaciente
                                              .getPacienteGnral![_index].nombre,
                                          style: const TextStyle(fontSize: 20),
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
                                          controladorPaciente
                                              .getPacienteGnral![_index]
                                              .apellido,
                                          style: const TextStyle(fontSize: 20),
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
                                          controladorPaciente
                                              .getPacienteGnral![_index]
                                              .telefono,
                                          style: const TextStyle(fontSize: 20),
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
                    Container(
                      width: double.maxFinite,
                      height: 80,
                      margin: const EdgeInsets.only(left: 20),
                      child: GestureDetector(
                        child: ListView.builder(
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return Column(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                          right: 15, top: 10),
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Column(children: [
                                        const SizedBox(height: 10),
                                        Text(listFechas
                                            .elementAt(index)
                                            .toString()),
                                        const SizedBox(height: 10),
                                        Text(listaDias.elementAt(index)),
                                      ]))
                                ],
                              );
                            }),
                        onTap: () {
                          print('Si pasa por aca');
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 0),
                      child: const Text('Hora',
                          style: TextStyle(
                              fontSize: 20, fontFamily: 'RobotoSlab')),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 80,
                      margin: const EdgeInsets.only(left: 20),
                      child: GestureDetector(
                        child: ListView.builder(
                            itemCount: 7,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return Column(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                          right: 15, top: 10),
                                      width: 140,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Column(children: [
                                        const SizedBox(height: 10),
                                        Text(hora.elementAt(index)),
                                      ]))
                                ],
                              );
                            }),
                        onTap: () {
                          print('Si pasa por aca');
                        },
                      ),
                    ),
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
                            print('asd');
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
