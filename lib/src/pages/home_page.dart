import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/pages/asistencia_page.dart';
import 'package:duvit_admin/src/pages/llamadas_page.dart';
import 'package:duvit_admin/src/pages/staffs_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DuvitAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _callPage(currentIndex),
        bottomNavigationBar: _crearBottomNavigationBar(),
      ),
    );
  }

  Widget _crearBottomNavigationBar() {

    return BottomNavyBar (
      selectedIndex: currentIndex,
      showElevation: true,
      itemCornerRadius: 8,
      curve: Curves.easeInBack,
      onItemSelected: (index) => setState(() {
        currentIndex = index;
      }),
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.supervised_user_circle),
          title: Text('Empleados'),
          activeColor: Colors.pink,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.call),
          title: Text('Llamadas'),
          activeColor: Colors.blue,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.assignment_turned_in),
          title: Text(
            'Asistencia',
          ),
          activeColor: Colors.red,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /*Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle), title: Text('Staff')
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.call), title: Text('Llamadas')
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in), title: Text('Asistencia')
        ),
      ],
    );
  }*/

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return StaffsPage();
      case 1:
        return LlamadasPage();
      case 2:
        return AsistenciaPage();

      default:
        return StaffsPage();
    }
  }
}
