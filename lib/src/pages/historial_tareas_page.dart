import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/models/staff_model.dart';
import 'package:duvit_admin/src/models/tarea_model.dart';
import 'package:duvit_admin/src/providers/staffs_provider.dart';
import 'package:duvit_admin/src/providers/tareas_provider.dart';

import 'package:flutter/material.dart';

class HistorialTareasPage extends StatelessWidget {

  final staffsProvider = new StaffsProvider();
  final tareasProvider = new TareasProvider();

  @override
  Widget build(BuildContext context) {

    final StaffModel staff = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: _crearAppBar( context, staff.nombre ),
      body:  _crearListado( staff ),
    );
  }

  Widget _crearListado( StaffModel staff ) {

    return FutureBuilder(
      future: tareasProvider.buscarTareasByIdStatus( staff.id, 3 ),
      builder: (BuildContext context, AsyncSnapshot<List<TareaModel>> snapshot) {

        final tareas = snapshot.data;

        if (snapshot.hasData) {
          if ( tareas.isNotEmpty ) {
            return ListView.builder(
              itemCount: tareas.length,
              itemBuilder: (context, i) => _crearItem( tareas[i] ),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.done,
                      color: DuvitAppTheme.lightText,
                      size: 40.0,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Aún no cuenta con alguna tarea terminada',
                      style: TextStyle(color: DuvitAppTheme.lightText),
                    ),
                  ],
                ),
              ],
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem( TareaModel tarea ) {

    return Card(
      key: ValueKey(tarea.idPlaneacion),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          bottomLeft: Radius.circular(5.0),
          bottomRight: Radius.circular(5.0),
          topRight: Radius.circular(32.0)
        ),
      ),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0, right: 20.0),
          title: Text(
            'Tarea: ${tarea.tarea}',
            style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10.0),
                height: 60,
                width: 4,
                decoration: BoxDecoration(
                  color: DuvitAppTheme.redLight,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0)),
                ),
              ),
              new Flexible(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 8.0),
                      RichText(
                        text: TextSpan(
                          text: 'Act. ${tarea.actividad}',
                          style: TextStyle(color: Colors.black54),
                        ),
                        maxLines: 3,
                        softWrap: true,
                      ),
                      SizedBox(height: 2.0),
                      RichText(
                        text: TextSpan(
                          text: 'Detalle: ${tarea.detalle}',
                          style: TextStyle(color: Colors.black54),
                        ),
                        maxLines: 3,
                        softWrap: true,
                      ),
                      SizedBox(height: 2.0),
                      RichText(
                        text: TextSpan(
                          text: 'Proyecto: ${tarea.proyecto}',
                          style: TextStyle(color: Colors.black54),
                        ),
                        maxLines: 3,
                        softWrap: true,
                      )
                    ]
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearAppBar( BuildContext context, String nombreStaff ) {

    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 30.0),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'Historial',
                  style: DuvitAppTheme.estiloTituloPagina
                ),
                Text(
                  '• $nombreStaff',
                  style: DuvitAppTheme.caption
                ),
              ],
            )
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 8.0, right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: DuvitAppTheme.darkerText,
                ),
            )
          ),
        ],
      ),
    );

  }

}
