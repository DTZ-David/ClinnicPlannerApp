// ignore_for_file: depend_on_referenced_packages, prefer_typing_uninitialized_variables, unused_local_variable

import 'dart:io';

import 'package:clinnic_planner/data/services/peticionesPacienteFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../data/services/peticionesUserFirebase.dart';
import '../../../domain/controller/control_pacientefirebase.dart';
import '../../../domain/models/paciente.dart';
import '../../../domain/models/user.dart';

class RegisterStepper extends StatefulWidget {
  final String user;
  final String password;
  const RegisterStepper(this.user, this.password, {super.key});

  @override
  State<RegisterStepper> createState() => _RegisterStepperState();
}

class _RegisterStepperState extends State<RegisterStepper> {
  var _image;
  ImagePicker picker = ImagePicker();

  DateTime date = DateTime.now();
  var items = ['C.C', 'T.I'];
  String? selectedItem = 'C.C';
  var items1 = ['Masculino', 'Femenino', 'Otro'];
  String? selectedItem1 = 'Masculino';
  int currentStep = 0;
  String tipoId = "C.C", sexo = "Masculino";
  TextEditingController controlidentificacion = TextEditingController();
  TextEditingController controlnombre = TextEditingController();
  TextEditingController controlapellido = TextEditingController();
  TextEditingController controldireccion = TextEditingController();
  TextEditingController controltelefono = TextEditingController();
  TextEditingController controlemail = TextEditingController();
  TextEditingController controlfechanacimiento = TextEditingController();
  TextEditingController controledad = TextEditingController();

  ConsultasControllerPaciente controladorPaciente = Get.find();

  _camGaleria(bool op) async {
    XFile? image;
    image = op
        ? await picker.pickImage(source: ImageSource.camera, imageQuality: 50)
        : await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Registro'),
          backgroundColor: const Color.fromARGB(250, 6, 68, 108),
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                  primary: Color.fromARGB(250, 6, 68, 108))),
          child: Stepper(
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;
              if (isLastStep) {
                Get.offAllNamed("/loginf");
                // var paciente = <String, dynamic>{
                //   'tipoId': tipoId,
                //   'identificacion': controlidentificacion.text,
                //   'nombre': controlnombre.text,
                //   'apellido': controlapellido.text,
                //   'sexo': sexo,
                //   'fechaNacimiento': controlfechanacimiento,
                //   'direccion': controldireccion,
                //   'email': controlemail,
                //   'telefono': controltelefono,
                //   'edad': controledad.text,
                //   'foto': ''
                // };
                // PeticionesPaciente.crearPaciente(paciente, _image);
                DateTime edad = DateTime.parse(controlfechanacimiento.text);
                int edad1 = (DateTime.now().year - edad.year);

                final paciente = Paciente(
                    tipoId: tipoId,
                    identificacion: controlidentificacion.text,
                    nombre: controlnombre.text,
                    apellido: controlapellido.text,
                    sexo: sexo,
                    fechaNacimiento: controlfechanacimiento.text,
                    direccion: controldireccion.text,
                    email: controlemail.text,
                    telefono: controltelefono.text,
                    edad: edad1.toString(),
                    foto: '');
                final user = User(
                    email: widget.user,
                    password: widget.password,
                    rol: 'Paciente',
                    id: controlidentificacion.text);
                PeticionesUser.createUser(user);
                createUser(paciente, _image);
                controladorPaciente.consultaPaciente().then((value) => null);
                Get.offAllNamed('/mainpagepaciente');
              } else {
                setState(() => currentStep += 1);
              }
            },
            onStepTapped: (step) => setState(() => currentStep = step),
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
            controlsBuilder: (context, ControlsDetails details) {
              final isLastStep = currentStep == getSteps().length - 1;
              return Row(
                children: <Widget>[
                  Container(
                    width: 120,
                    margin: const EdgeInsets.only(left: 15),
                    child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: Text(isLastStep ? 'Enviar' : 'Siguiente'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  if (currentStep != 0)
                    Container(
                      width: 120,
                      margin: const EdgeInsets.only(left: 15),
                      child: ElevatedButton(
                        onPressed: details.onStepCancel,
                        child: const Text('Atras'),
                      ),
                    ),
                ],
              );
            },
          ),
        ));
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text('Datos'),
          content: Column(
            children: <Widget>[
              Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        _opcioncamara(context);
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(48),
                                child: Image.file(
                                  _image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(48),
                                ),
                                width: 100,
                                height: 100,
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black))),
                value: selectedItem,
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue!;
                    tipoId = selectedItem as String;
                  });
                  tipoId = selectedItem as String;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: controlidentificacion,
                decoration: const InputDecoration(labelText: 'Identificacion'),
              ),
              TextFormField(
                controller: controlnombre,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                controller: controlapellido,
                decoration: const InputDecoration(labelText: 'Apellido:'),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black))),
                value: selectedItem1,
                items: items1.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem1 = newValue!;
                    sexo = selectedItem1 as String;
                  });
                  sexo = selectedItem1 as String;
                },
              ),
              TextField(
                controller: controlfechanacimiento,
                decoration:
                    const InputDecoration(labelText: 'Fecha de nacimiento'),
                onTap: () async {
                  DateTime? pickeddate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (pickeddate != null) {
                    setState(() {
                      controlfechanacimiento.text =
                          DateFormat('yyyy-MM-dd').format(pickeddate);
                    });
                  }
                },
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: const Text('Direccion'),
          content: Column(
            children: [
              TextFormField(
                controller: controldireccion,
                decoration: const InputDecoration(labelText: 'Direccion'),
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: const Text('Contacto'),
          content: Column(
            children: [
              TextFormField(
                controller: controlemail,
                decoration: const InputDecoration(labelText: 'E-Mail'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: controltelefono,
                decoration: const InputDecoration(labelText: 'Numero'),
              ),
            ],
          ),
        )
      ];
  void _opcioncamara(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Imagen de Galeria'),
                    onTap: () {
                      _camGaleria(false);
                      Get.back();
                      // Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Capturar Imagen'),
                  onTap: () {
                    _camGaleria(true);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future createUser(Paciente paciente, foto) async {
    var url = '';
    if (foto != null) {
      url = await PeticionesPaciente.cargarfoto(foto, paciente.identificacion);
    }
    final docUser = FirebaseFirestore.instance
        .collection("Pacientes")
        .doc(paciente.identificacion);

    final json = paciente.toJson();
    json['foto'] = url.toString();
    await docUser.set(json);
  }
}
