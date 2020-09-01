
import 'package:flutter/material.dart';
import 'package:duvit_admin/src/bloc/provider.dart';

import 'package:duvit_admin/src/pages/detalles_page.dart';
import 'package:duvit_admin/src/pages/home_page.dart';
import 'package:duvit_admin/src/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'login'    : (BuildContext context) => LoginPage(),
          'home'     : (BuildContext context) => HomePage(),
          'detalles' : (BuildContext context) => DetallesPage(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO( 148, 40, 142, 1),
          accentColor: Color.fromRGBO( 99, 0, 96, 1),
        ),
      ),
    );
  }
}
