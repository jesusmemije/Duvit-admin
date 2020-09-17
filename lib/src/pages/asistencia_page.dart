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
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.query_builder,
                  color: DuvitAppTheme.lightText,
                  size: 40.0,
                ),
                SizedBox(height: 8.0),
                Text(
                  'TO DO',
                  style: TextStyle(color: DuvitAppTheme.lightText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('Asistencia', style: DuvitAppTheme.estiloTituloPagina),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 8.0, right: 4.0),
            child: IconButton(
              color: Colors.red,
                icon: Icon(
                  Icons.search,
                  color: DuvitAppTheme.darkerText,
                ),
                onPressed: (){
                  Navigator.pushNamed(context, 'agregar_tarea');
                },
            ),
          ),
        ],
      ),
    );
  }
}
