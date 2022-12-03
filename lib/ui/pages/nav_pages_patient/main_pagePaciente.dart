// ignore_for_file: file_names

import 'package:clinnic_planner/ui/pages/nav_pages_patient/create_session_pagePatient.dart';
import 'package:clinnic_planner/ui/pages/nav_pages_patient/home_page_patient.dart';
import 'package:flutter/material.dart';

import '../nav_pages_psychologist/agenda_page.dart';
import '../nav_pages_psychologist/perfil_edit.dart';
import '../nav_pages_psychologist/settings_page.dart';

class MainPagePaciente extends StatefulWidget {
  const MainPagePaciente({super.key});

  @override
  State<MainPagePaciente> createState() => _MainPagePacienteState();
}

class _MainPagePacienteState extends State<MainPagePaciente> {
  List pages = [
    const HomePagePaciente(),
    const CreateSessionPacientePage(),
    const AgendaPage(),
    const SettingsPage(),
    const EditProfilePage()
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          unselectedFontSize: 0,
          selectedFontSize: 0,
          type: BottomNavigationBarType.shifting,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: const Color.fromARGB(250, 6, 68, 108),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 10,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notification_add), label: 'AddAppointment'),
            BottomNavigationBarItem(
                icon: Icon(Icons.schedule), label: 'Agenda'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ]),
    );
  }
}
