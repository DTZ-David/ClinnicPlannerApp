import 'package:flutter/material.dart';

import 'agenda_page.dart';
import 'create_session_page.dart';
import 'home_page.dart';
import 'perfil_edit.dart';
import 'settings_page.dart';

class MainPage extends StatefulWidget {
  final String id;
  const MainPage({super.key, required this.id});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      HomePage(id: widget.id),
      CreateSessionPage(id: widget.id),
      AgendaPage(id: widget.id),
      const SettingsPage(),
      const EditProfilePage()
    ];
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
