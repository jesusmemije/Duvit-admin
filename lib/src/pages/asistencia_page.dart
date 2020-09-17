import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:flutter/material.dart';

class AsistenciaPage extends StatefulWidget {
  @override
  _AsistenciaPageState createState() => _AsistenciaPageState();
}

class _AsistenciaPageState extends State<AsistenciaPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _crearAppBar(),
    );
  }

  Widget _crearAppBar() {

    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 30.0),
          child: Align(
            alignment: Alignment.center,
            child: Text('Asistencia', 
            style: DuvitAppTheme.estiloTituloPagina
            )
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 8.0, right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  color: DuvitAppTheme.darkerText,
                ),
            )
          ),
        ],
      ),
    );
  }
}