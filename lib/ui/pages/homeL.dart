// ignore: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeL extends StatelessWidget {
  const HomeL({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_fondo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset('assets/images/logo_white.png'),
            const Text(
              'Bienvenido',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontFamily: 'RobotoSlab',
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.arrow_downward_rounded,
          color: Colors.black,
        ),
        onPressed: () {
          Get.offAllNamed('/loginf');
        },
      ),
    );
  }
}
