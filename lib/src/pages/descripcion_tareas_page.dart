import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/models/proyecto_model.dart';
import 'package:flutter/material.dart';

class DescripcionTareasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final ProyectoListModel tarea = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: _crearAppBar( context, tarea.nombreTarea ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text( 'Staff asignado' ),
              subtitle: Text( tarea.nombreStaff ),
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text( 'Proyecto' ),
              subtitle: Text( tarea.nombreProyecto ),
            ),
            ListTile(
              leading: Icon(Icons.done),
              title: Text( 'Tarea' ),
              subtitle: Text( tarea.nombreTarea ),
            ),
            ListTile(
              leading: Icon(Icons.label),
              title: Text( 'Detalle' ),
              subtitle: Text( tarea.detalleTarea ),
            ),
            ListTile(
              leading: Icon(Icons.label),
              title: Text( 'Requerimientos' ),
              subtitle: Text(  tarea.requerimientos !=null ? tarea.requerimientos :'No hay requerimientos' ),
            ),
            ListTile(
              leading: Icon(Icons.label),
              title: Text( 'Estatus' ),
              subtitle: Text( tarea.estatusPlaneacion !=null ? tarea.estatusPlaneacion :'No hay estatus' ),
            ),
            ListTile(
              leading: Icon(Icons.today),
              title: Text('Fecha Inicio'),
              subtitle: Text(tarea.fechaInicio),
            ),
            ListTile(
              leading: Icon(Icons.today),
              title: Text('Fecha Fin'),
              subtitle: Text(tarea.fechaFin),
            )
          ],
        ),
      ),
    );
  }

  Widget _crearAppBar( BuildContext context, String nombreTarea ) {

    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column (
            children: [
              Text( 'Detalles Tarea', style: DuvitAppTheme.estiloTituloPagina )
            ],
          )
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 8.0, right: 4.0),
            child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: DuvitAppTheme.darkerText,
                ),
                onPressed: (){
                  Navigator.pop(context);
                },
            ),
          ),
        ],
      ),
    );

  }
  
}