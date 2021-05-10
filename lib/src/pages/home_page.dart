import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/pages/asistencia_page.dart';
import 'package:duvit_admin/src/pages/llamadas_page.dart';
import 'package:duvit_admin/src/pages/proyectos_page.dart';
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
        floatingActionButton: _crearFloatingButton(),
      ),
    );
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle), label: 'Empleados'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.call), label: 'Llamadas'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work), label: 'Proyectos'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment_turned_in), label: 'Asistencia'
        ),
      ],
    );
  }

  Widget _crearFloatingButton() {

    return FloatingActionButton.extended(
      elevation: 8.0,
      backgroundColor: DuvitAppTheme.white,
      label: Text(
        "Agregar tarea",
        style: TextStyle(
          fontFamily: DuvitAppTheme.fontName,
          fontWeight: FontWeight.w700,
          fontSize: 14,
          letterSpacing: 0.0,
          color: Theme.of(context).primaryColor,
        )
      ),
      icon: Icon(
        Icons.add,
        color: Theme.of(context).primaryColor,
      ),
      onPressed: (){
        Navigator.pushNamed(context, 'agregar_tarea');
      }
    );

  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return StaffsPage();
      case 1:
        return LlamadasPage();
      case 2:
        return ProyectosPage();
      case 3:
        return AsistenciaPage();

      default:
        return StaffsPage();
    }
  }

}
