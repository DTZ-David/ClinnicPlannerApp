// ignore_for_file: unused_field, prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var _image;
  ImagePicker picker = ImagePicker();
  TextEditingController controluser = TextEditingController();
  TextEditingController controlpassw = TextEditingController();

  bool showPassword = false;

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
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed('/mainpage');
          },
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(250, 6, 68, 108)),
        ),
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(250, 6, 68, 108)),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/psicologo.png")),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        _opcioncamara(context);
                      },
                      child: Positioned(
                          bottom: 100,
                          right: 100,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: const Color.fromARGB(250, 6, 68, 108),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              TextFormField(
                  cursorColor: Colors.black,
                  controller: controluser,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(250, 6, 68, 108)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(250, 6, 68, 108)),
                      ),
                      label: Text(
                        'E-Mail: ',
                        style:
                            TextStyle(color: Color.fromARGB(250, 6, 68, 108)),
                      ))),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                  controller: controlpassw,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(250, 6, 68, 108)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(250, 6, 68, 108)),
                      ),
                      label: Text(
                        'Contraseña: ',
                        style:
                            TextStyle(color: Color.fromARGB(250, 6, 68, 108)),
                      ))),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                  controller: controluser,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(250, 6, 68, 108)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(250, 6, 68, 108)),
                      ),
                      label: Text(
                        'Nombre Completo: ',
                        style:
                            TextStyle(color: Color.fromARGB(250, 6, 68, 108)),
                      ))),
              const SizedBox(
                height: 55,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(250, 6, 68, 108)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(250, 6, 68, 108))))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text("Guardar"),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

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
}
