
import 'dart:io';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:duvit_admin/src/pages/agregar_tarea_page.dart';
import 'package:duvit_admin/src/pages/historial_tareas_page.dart';
import 'package:duvit_admin/src/pages/llamadas_page.dart';
import 'package:flutter/material.dart';
import 'package:duvit_admin/src/bloc/provider.dart';

import 'package:duvit_admin/src/pages/tareas_page.dart';
import 'package:duvit_admin/src/pages/home_page.dart';
import 'package:duvit_admin/src/pages/login_page.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
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
        initialRoute: 'home',
        routes: {
          'login'            : (BuildContext context) => LoginPage(),
          'home'             : (BuildContext context) => HomePage(),
          'tareas'           : (BuildContext context) => TareasPage(),
          'historial_tareas' : (BuildContext context) => HistorialTareasPage(),
          'llamadas'         : (BuildContext context) => LlamadasPage(),
          'agregar_tarea'    : (BuildContext context) => AgregarTareaPage(),
        },
        /*theme: ThemeData(
          primaryColor: Color.fromRGBO( 148, 40, 142, 1),
          accentColor: Color.fromRGBO( 99, 0, 96, 1),
        ),*/
        
      ),
    );
  }
}
