import 'package:duvit_admin/src/pages/descripcion_tareas_page.dart';
import 'package:duvit_admin/src/pages/proyecto_to_staff_page.dart';
import 'package:duvit_admin/src/pages/proyectos_page.dart';
import 'package:duvit_admin/src/preferencias_usuario/preferencias_usuarios.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:duvit_admin/src/pages/agregar_tarea_page.dart';
import 'package:duvit_admin/src/pages/historial_tareas_page.dart';
import 'package:duvit_admin/src/pages/llamadas_page.dart';
import 'package:flutter/material.dart';
import 'package:duvit_admin/src/bloc/provider.dart';

import 'package:duvit_admin/src/pages/tareas_page.dart';
import 'package:duvit_admin/src/pages/home_page.dart';
import 'package:duvit_admin/src/pages/login_page.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final prefs = new PreferenciasUsuario();
    var logeado = prefs.logeado;

    print('Logeado');
    print( logeado );
    
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));*/
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //statusBarColor: Color.fromRGBO( 99, 0, 96, 1),
      statusBarColor: Color.fromRGBO( 148, 40, 142, 1),
      statusBarIconBrightness: Brightness.light,
    ));*/

    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('es', 'ES'),
        ],
        title: 'Duvit Admin',
        initialRoute: logeado == null || logeado == false ? 'login' : 'home',
        routes: {
          'login'             : (BuildContext context) => LoginPage(),
          'home'              : (BuildContext context) => HomePage(),
          'tareas'            : (BuildContext context) => TareasPage(),
          'historial_tareas'  : (BuildContext context) => HistorialTareasPage(),
          'llamadas'          : (BuildContext context) => LlamadasPage(),
          'agregar_tarea'     : (BuildContext context) => AgregarTareaPage(),
          'proyectos'         : (BuildContext context) => ProyectosPage(),
          'proyecto_to_staff' : (BuildContext context) => ProyectoToStaffPage(),
          'descripcion_tareas': (BuildContext context) => DescripcionTareasPage(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO( 148, 40, 142, 1),
          colorScheme: ColorScheme.light(
            primary: Color.fromRGBO( 99, 0, 96, 1),
          ),
        ),
      ),
    );
  }
}
