import 'package:flutter/material.dart';

import 'agenda_page.dart';
import 'create_session_page.dart';
import 'home_page.dart';
import 'perfil_edit.dart';
import 'settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomePage(),
    const CreateSessionPage(),
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
          items: [
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.notification_add), label: 'AddAppointment'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.schedule), label: 'Agenda'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/perfil.jpg',
                  scale: 20,
                ),
                label: 'Account'),
          ]),
    );
  }
}
