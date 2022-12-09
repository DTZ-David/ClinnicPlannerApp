// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, unused_local_variable, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controller/control_pacientefirebase.dart';
import '../../../domain/controller/control_sesionfirebase.dart';

class AgendaPage extends StatefulWidget {
  final String id;
  const AgendaPage({
    super.key,
    required this.id,
  });

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

List<String> estado = [];
List<String> hora = [];
List<String> notas = [];

class _AgendaPageState extends State<AgendaPage> {
  ConsultasControllerSesion controladorSesion = Get.find();
  ConsultasControllerPaciente controladorPaciente = Get.find();

  @override
  Widget build(BuildContext context) {
    var aux = 'asdasda';
    estado = [];
    hora = [];
    notas = [];

    controladorSesion.consultaSesion().then((value) => null);
    controladorPaciente.consultaPaciente().then((value) => null);

    for (var i = 0; i < controladorSesion.getSesionGnral!.length; i++) {
      if (widget.id == controladorSesion.getSesionGnral![i].idPsicologo) {
        estado.add(controladorSesion.getSesionGnral![i].estado);
        hora.add(controladorSesion.getSesionGnral![i].hora);
        notas.add(controladorSesion.getSesionGnral![i].notasSesion);
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 32,
            color: const Color.fromARGB(250, 6, 68, 108),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            color: const Color.fromARGB(250, 6, 68, 108),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const topRow(),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      6,
                      (index) => dateWidget(
                            index: index,
                          )),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 550,
            width: double.maxFinite,
            child: ListView.builder(
                itemCount: notas.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: const <Widget>[
                            line_widget(
                              lines: [20.0, 30.0, 40.0, 10.0],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Container(
                          height: 100.0,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(250, 6, 68, 108),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0))),
                          child: Container(
                            margin: const EdgeInsets.only(left: 4.0),
                            color: Colors.white,
                            padding:
                                const EdgeInsets.only(left: 15.0, top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 21.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      hora.elementAt(index),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const VerticalDivider(),
                                    Text(
                                      estado.elementAt(index),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                Text(
                                  notas.elementAt(index),
                                  style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    ));
  }
}

class line_widget extends StatelessWidget {
  final lines;
  const line_widget({
    Key? key,
    this.lines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            4,
            (index) => Container(
                  height: 2.0,
                  width: lines[index],
                  color: const Color.fromARGB(250, 6, 68, 108),
                  margin: const EdgeInsets.symmetric(vertical: 14.0),
                )));
  }
}

class dateWidget extends StatefulWidget {
  final index;

  const dateWidget({super.key, required this.index});
  @override
  State<dateWidget> createState() => _dateWidgetState();
}

class _dateWidgetState extends State<dateWidget> {
  var list = ['Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'];
  bool _selectDate = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectDate = !_selectDate;
        });
      },
      child: Container(
        decoration: _selectDate
            ? null
            : BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              list[widget.index],
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: _selectDate ? FontWeight.normal : FontWeight.bold,
                  color: _selectDate ? Colors.grey : Colors.white),
            ),
            Text(
              '${10 + widget.index}',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: _selectDate ? FontWeight.normal : FontWeight.bold,
                  color: _selectDate ? Colors.grey : Colors.white),
            ),
            Container(
              width: 4.0,
              height: 4.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _selectDate ? Colors.grey : Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class topRow extends StatefulWidget {
  const topRow({
    Key? key,
  }) : super(key: key);

  @override
  State<topRow> createState() => _topRowState();
}

class _topRowState extends State<topRow> {
  var selectedItem;
  var mes = 'Dic';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: const [
            Text(
              'Sesiones',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          child: Text(mes.toString(),
              style: const TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    insetPadding: const EdgeInsets.all(100),
                    backgroundColor: Colors.white,
                    title: const Text(
                      "Seleccionar Mes",
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Color.fromARGB(
                                                255, 36, 0, 167)))),
                                value: selectedItem,
                                dropdownColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                isExpanded: true,
                                items: <String>[
                                  "Ene",
                                  "Feb",
                                  'Mar',
                                  'Abr',
                                  'May',
                                  'Jun',
                                  'Jul',
                                  'Ago',
                                  'Sep',
                                  'Oct',
                                  'Nov',
                                  'Dic'
                                ].map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                icon: const Icon(Icons.arrow_back_ios_new),
                                elevation: 4,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedItem = newValue!;
                                  });
                                },
                              ),
                            ))
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
                            Navigator.of(context).pop();
                            setState(() {});
                            mes = selectedItem;
                          },
                          icon: const Icon(Icons.check, color: Colors.green)),
                    ],
                  );
                });
          },
        )
      ],
    );
  }
}
