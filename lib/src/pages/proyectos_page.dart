import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/models/agregar_tarea_model.dart';
import 'package:duvit_admin/src/models/proyecto_model.dart';
import 'package:duvit_admin/src/providers/proyectos_provider.dart';
import 'package:flutter/material.dart';

class ProyectosPage extends StatefulWidget {

  @override
  _ProyectosPageState createState() => _ProyectosPageState();
}

class _ProyectosPageState extends State<ProyectosPage> {

  //Global Keys
  final formKey     = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  //Variables de control
  String _currentIdProyecto;
  bool _mostrarResults = false;

  final proyectosProvider = ProyectosProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: _crearAppBar(context),
      body: _crearLista(),
    );
  }

  Widget _crearLista() {

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(18.0),
        child: Form(
          key: formKey,
          child: SafeArea(
            child: Column(
              children: [
                _dropDownProyectos(),
                SizedBox(height: 10.0),
                _mostrarResults ? _showResults( _currentIdProyecto ) : _showSelectProject(),            
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showSelectProject(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.select_all,
                color: DuvitAppTheme.lightText,
                size: 40.0,
              ),
              SizedBox(height: 8.0),
              Text(
                'Seleccione un proyecto',
                style: TextStyle(color: DuvitAppTheme.lightText),
              ),
            ],
          ),
        ],
      )
    );
  }

  Widget _dropDownProyectos() {

    return FutureBuilder<List<ProyectoModel>>(
      future: proyectosProvider.getProyectos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProyectoModel>> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return DropdownButtonFormField<String>(
            validator: ( value ) {
              if ( value == null ){
                return "No ha seleccionado proyecto";
              } else {
                return null;
              }
            },
            items: snapshot.data.map((proyecto) => DropdownMenuItem<String>(
              child: Text(proyecto.nombreProyecto, style: DuvitAppTheme.estiloTextoInput, overflow: TextOverflow.ellipsis),
              value: proyecto.id.toString(),
            )).toList(),
            onChanged: (value) {
              setState(() {
                _currentIdProyecto = value;
                _mostrarResults = true;
              });
            },
            isExpanded: true,
            value: _currentIdProyecto != null ? _currentIdProyecto : null,
            icon: Icon(Icons.keyboard_arrow_down),
            style: DuvitAppTheme.estiloTextoInput,
            iconEnabledColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Selecciona un proyecto',
              isDense: true,
            ),
            elevation: 24,
        );
      }
    );
  }

  Widget _showResults( String idProject ) {

    return FutureBuilder(
      future: proyectosProvider.getTareasByProyecto( idProject ),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        
        final tareas = snapshot.data;

        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        if ( tareas.isNotEmpty ) {
          return Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tareas.length,
              itemBuilder: (context, i) => _crearItem(context, tareas[i]),
            ),
          );
        } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_off,
                      color: DuvitAppTheme.lightText,
                      size: 40.0,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'No se encontraron tareas',
                      style: TextStyle(color: DuvitAppTheme.lightText),
                    ),
                  ],
                ),
              ],
            );
          }
      },
    );
  }
  Widget _crearItem(BuildContext context, ProyectoListModel tarea) {

    return Card(
      key: ValueKey(tarea.id),
      elevation: 8.0,
      child: Container(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  tarea.nombreProyecto,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: DuvitAppTheme.title,
                ),
              ),
              SizedBox(height: 5.0),
            ],
          ),
          subtitle: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  tarea.nombreTarea,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: DuvitAppTheme.body2,
                ),
              ),
              SizedBox(height: 5.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "• " + tarea.nombreStaff,
                  overflow: TextOverflow.ellipsis,
                  style: DuvitAppTheme.caption,
                ),
              ),
              SizedBox(height: 5.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "• Inicio: " + tarea.fechaInicio,
                  overflow: TextOverflow.ellipsis,
                  style: DuvitAppTheme.caption,
                ),
              ),
              SizedBox(height: 5.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "• Fin: " + tarea.fechaFin,
                  overflow: TextOverflow.ellipsis,
                  style: DuvitAppTheme.caption,
                ),
              ),
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black54, size: 30.0),
          onTap: () {
            Navigator.pushNamed(context, 'descripcion_tareas', arguments: tarea);
          },
        ),
      ),
    );
  }

  Widget _crearAppBar(BuildContext context) {

    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('Proyectos', style: DuvitAppTheme.estiloTituloPagina),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 8.0, right: 4.0),
            child: IconButton(
              color: Colors.red,
              icon: Icon(
                Icons.add,
                color: DuvitAppTheme.darkerText,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'agregar_tarea');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, right: 4.0),
            child: IconButton(
              color: Colors.red,
              icon: Icon(
                Icons.group_add,
                color: DuvitAppTheme.darkerText,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'proyecto_to_staff');
              },
            ),
          ),
        ],
      ),
    );
  }
}
