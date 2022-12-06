import 'package:clinnic_planner/ui/pages/nav_pages_patient/main_pagePaciente.dart';
import 'package:clinnic_planner/ui/pages/nav_pages_psychologist/main_page.dart';
import 'package:clinnic_planner/ui/pages/nav_pages_psychologist/perfil_edit.dart';
import 'package:clinnic_planner/ui/pages/nav_pages_psychologist/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'authf/loginf.dart';
import 'authf/registro.dart';
import 'pages/homeL.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Clinnic Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color.fromARGB(150, 6, 68, 108),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color.fromARGB(150, 6, 68, 108))),
      routes: {
        '/homel': (context) => const HomeL(),
        '/loginf': (context) => const Loginf(),
        '/registroLog': (context) => const Registro(),
        '/editprofilepage': (context) => const EditProfilePage(),
        '/mainpage': (context) => const MainPage(),
        //'/mainpagepaciente': (context) => const MainPagePaciente(),
        '/settingspage': (context) => const SettingsPage()
      },
      home: const HomeL(),
    );
  }
}
