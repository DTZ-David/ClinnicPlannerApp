// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:clinnic_planner/domain/controller/control_pacientefirebase.dart';
import 'package:clinnic_planner/domain/controller/control_sesionfirebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/peticionesSesionFirebase.dart';

class HomePagePaciente extends StatefulWidget {
  final String id;
  const HomePagePaciente({super.key, required this.id});

  @override
  State<HomePagePaciente> createState() => _HomePagePacienteState();
}

List<String> nombres = [];
List<String> hora = [];
List<String> notas = [];

List<String> nombresFinalizado = [];
List<String> horasFinalizado = [];

class _HomePagePacienteState extends State<HomePagePaciente>
    with TickerProviderStateMixin {
  ConsultasControllerSesion controladorSesion = Get.find();
  ConsultasControllerPaciente controladorPaciente = Get.find();
  var images = {
    'paciente.png': 'Luz Mendoza',
    'paciente_2.png': 'Angie Salazar',
    'psicologo.png': 'Moises Quiroz'
  };

  @override
  Widget build(BuildContext context) {
    nombres = [];
    hora = [];
    notas = [];

    nombresFinalizado = [];
    horasFinalizado = [];
    controladorSesion.consultaSesion().then((value) => null);
    controladorPaciente.consultaPaciente().then((value) => null);

    final miTimer = Timer(const Duration(seconds: 3), () {
      for (var i = 0; i < controladorSesion.getSesionGnral!.length; i++) {
        for (var j = 0; j < controladorPaciente.getPacienteGnral!.length; j++) {
          if (controladorPaciente.getPacienteGnral![j].identificacion ==
              controladorSesion.getSesionGnral![i].idPaciente) {
            nombres.add(controladorPaciente.getPacienteGnral![j].nombre);
            hora.add(controladorSesion.getSesionGnral![i].hora);
            notas.add(controladorSesion.getSesionGnral![i].notasSesion);
          }
        }
      }
    });

    final miTimer2 = Timer(const Duration(seconds: 3), () {
      for (var i = 0; i < controladorSesion.getSesionGnral!.length; i++) {
        for (var j = 0; j < controladorPaciente.getPacienteGnral!.length; j++) {
          if (controladorPaciente.getPacienteGnral![j].identificacion ==
              controladorSesion.getSesionGnral![i].idPaciente) {
            if (controladorSesion.getSesionGnral![i].estado != 'Pendiente') {
              nombresFinalizado
                  .add(controladorPaciente.getPacienteGnral![j].nombre);
              horasFinalizado.add(controladorSesion.getSesionGnral![i].hora);
            }
          }
        }
      }
    });
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Clinnic Planner',
          style: TextStyle(
              fontFamily: 'RobotoSlab', fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Obx(() => controladorSesion.getSesionGnral?.isEmpty == false
          ? SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: TabBar(
                          labelPadding:
                              const EdgeInsets.only(left: 20, right: 20),
                          labelColor: Colors.black,
                          controller: tabController,
                          unselectedLabelColor: Colors.grey,
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: CircleTabIndicator(
                              color: const Color.fromARGB(150, 6, 68, 108),
                              radius: 4),
                          tabs: const [
                            Tab(
                              text: 'Inicio',
                            ),
                            Tab(
                              text: 'Historial',
                            )
                          ]),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 560,
                      width: double.maxFinite,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          CargarCards(images: images),
                          CargarCards2(images: images),
                        ],
                      ),
                    ),
                  ]),
            )
          : const Center(child: Icon(Icons.charging_station))),
    );
  }
}

class CargarCards2 extends StatelessWidget {
  const CargarCards2({
    Key? key,
    required this.images,
  }) : super(key: key);

  final Map<String, String> images;

  @override
  Widget build(BuildContext context) {
    return nombresFinalizado.isEmpty
        ? const Center(
            child: Text('No hay sesiones en el historial'),
          )
        : ListView.builder(
            itemCount: nombresFinalizado.length,
            //scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 10, 10),
                height: 150,
                width: 300,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    child: Stack(clipBehavior: Clip.none, children: [
                      Positioned(
                        top: -10,
                        left: -90,
                        child: Container(
                          margin: const EdgeInsets.only(left: 100, top: 10),
                          height: 100,
                          width: 100,
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80)),
                            elevation: 2,
                            child: Image.asset(
                                'assets/images/${images.keys.elementAt(index)}'),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        right: 35,
                        child: Column(
                          children: [
                            const Text('FINALIZADA'),
                            const SizedBox(height: 10),
                            Text(
                              nombresFinalizado.elementAt(index),
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              horasFinalizado.elementAt(index),
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ])),
              );
            },
          );
  }
}

class CargarCards extends StatefulWidget {
  const CargarCards({
    Key? key,
    required this.images,
  }) : super(key: key);
  final Map<String, String> images;

  @override
  State<CargarCards> createState() => _CargarCardsState();
}

class _CargarCardsState extends State<CargarCards> {
  TextEditingController controladorNotas = TextEditingController();
  ConsultasControllerSesion controlSesion = ConsultasControllerSesion();
  var selectedItem;
  var idSesion;

  @override
  Widget build(BuildContext context) {
    return nombres.isEmpty
        ? const Center(
            child: Text('No hay sesiones en la agenda'),
          )
        : ListView.builder(
            itemCount: nombres.length,
            //scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: const EdgeInsets.fromLTRB(20, 30, 10, 10),
                  height: 260,
                  width: 300,
                  child: GestureDetector(
                    onLongPress: () {
                      //editarCard(context, "Notas...");
                      showDialog(
                          barrierColor:
                              const Color.fromARGB(175, 104, 104, 103),
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text(
                                  "Editar Sesión",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                content: Column(
                                  children: [
                                    Positioned(
                                      top: 200,
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 50),
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                              hintText: "Estado de la Sesión",
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 36, 0, 167)))),
                                          value: selectedItem,
                                          dropdownColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          isExpanded: true,

                                          items: <String>[
                                            "Seleccione",
                                            "Finalizado",
                                            "Cancelado",
                                          ].map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          icon: const Icon(
                                              Icons.arrow_back_ios_new),
                                          elevation: 4,
                                          // underline: Container(
                                          // height: 2,
                                          //color:
                                          //  Color.fromARGB(255, 119, 94, 137),
                                          //  ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedItem = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                actions: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(Icons.cancel,
                                          color: Colors.redAccent)),
                                  IconButton(
                                      onPressed: () {
                                        PeticionesSesion.actualizarNotas(
                                            "2", controladorNotas.text);

                                        //if!(selectedItem == "Seleccione"){
                                        PeticionesSesion.actualizarEstado(
                                            controlSesion
                                                .getSesionGnral![index].idSesion
                                                .toString(),
                                            selectedItem.toString());
                                        // }
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(Icons.check,
                                          color: Colors.green)),
                                ],
                              ),
                            );
                          });
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        child: Stack(clipBehavior: Clip.none, children: [
                          Positioned(
                            top: -50,
                            left: -50,
                            child: Container(
                              margin: const EdgeInsets.only(left: 100, top: 10),
                              height: 100,
                              width: 100,
                              child: Card(
                                clipBehavior: Clip.hardEdge,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80)),
                                elevation: 2,
                                child: Image.asset(
                                    'assets/images/${widget.images.keys.elementAt(index)}'),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 35,
                            child: Column(
                              children: [
                                Text(
                                  hora.elementAt(index),
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  nombres.elementAt(index),
                                  style: const TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            top: 100,
                            left: 29,
                            child: Column(
                              children: [
                                Text(
                                  notas.elementAt(index),
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ])),
                  ));
            },
          );
  }
}

// ignore: must_be_immutable
class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, paint);
  }
}
