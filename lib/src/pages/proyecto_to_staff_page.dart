import 'dart:async';

import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/models/agregar_tarea_model.dart';
import 'package:duvit_admin/src/models/staff_model.dart';
import 'package:duvit_admin/src/models/proyecto_model.dart';
import 'package:duvit_admin/src/providers/staffs_provider.dart';
import 'package:duvit_admin/src/providers/proyectos_provider.dart';
import 'package:flutter/material.dart';

class ProyectoToStaffPage extends StatefulWidget {
  @override
  _ProyectoToStaffPageState createState() => _ProyectoToStaffPageState();
}

class _ProyectoToStaffPageState extends State<ProyectoToStaffPage> {

  //Global Keys
  final formKey     = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  //Variables de control
  bool _guardando = false;
  String _currentIdStaff;
  int _currentIdProyecto;
  bool _mostrarDropProyecto = false;

  //Provider
  final proyectosProvider = new ProyectosProvider();
  final staffsProvider    = new StaffsProvider();

  //Models
  ProyectoToStaffModel proyectoToStaff = new ProyectoToStaffModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(18.0),
          child: Form(
            key: formKey,
            child: SafeArea(
              child: Column(
                children: [
                  _titulo(),
                  SizedBox(height: 20.0),
                  _dropDownStaff(),
                  SizedBox(height: 10.0),
                  _mostrarDropProyecto ? _dropDownProyecto( _currentIdStaff ) : Container(),
                  SizedBox(height: 15.0),
                  _rowBotones(),             
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _titulo() {

    return Align(
      alignment: Alignment.centerLeft,
      child: Text('Relación Proyectos - Staff',
        style: TextStyle(
          fontFamily: DuvitAppTheme.fontName,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          letterSpacing: 1.2,
          color: DuvitAppTheme.darkerText,
        )
      ),
    );
  }

  Widget _dropDownStaff() {

    return FutureBuilder<List<StaffModel>>(
      future: staffsProvider.cargarStaffs(),
      builder: (BuildContext context, AsyncSnapshot<List<StaffModel>> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return DropdownButtonFormField<String>(
            onSaved: ( value ) => proyectoToStaff.idStaff = int.parse(value),
            validator: ( value ) {
              if ( value == null ){
                return "No ha seleccionado staff";
              } else {
                return null;
              }
            },
            items: snapshot.data.map((staff) => DropdownMenuItem<String>(
              child: Text(staff.nombre, style: DuvitAppTheme.estiloTextoInput, overflow: TextOverflow.ellipsis),
              value: staff.id,
            )).toList(),
            onChanged: (value) {

              setState(() {
                _currentIdStaff      = value;
                _mostrarDropProyecto = true;
              });
            },
            isExpanded: true,
            value: _currentIdStaff != null ? _currentIdStaff : null,
            icon: Icon(Icons.keyboard_arrow_down),
            style: DuvitAppTheme.estiloTextoInput,
            iconEnabledColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Selecciona un staff',
              isDense: true,
            ),
            elevation: 24,
        );
      }
    );
  }

  Widget _dropDownProyecto(String idStaff) {

    return FutureBuilder<List<ProyectoModel>>(
      future: proyectosProvider.buscarProyectosByStaffSinRelacion( idStaff ),
      builder: (BuildContext context, AsyncSnapshot<List<ProyectoModel>> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return DropdownButtonFormField<int>(
            onSaved: ( value ) => proyectoToStaff.idProyecto = value,
            validator: ( value ) {
              if ( value == null ){
                return "No ha seleccionado un proyecto";
              } else {
                return null;
              }
            },
            items: snapshot.data.map((proyecto) => DropdownMenuItem<int>(
              child: Text(proyecto.nombreProyecto, style: DuvitAppTheme.estiloTextoInput, overflow: TextOverflow.ellipsis),
              value: proyecto.id,
            )).toList(),
            onChanged: (value) {
              setState(() {
                _currentIdProyecto = value;
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

  Widget _rowBotones(){

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: RaisedButton.icon(
              icon: Icon(Icons.arrow_back),
              label:  Text('Regresar'),
              onPressed: (){
                Navigator.pop(context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
          ),
        ),
        Expanded (
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: RaisedButton.icon(
              icon: Icon(Icons.save),
              label:  Text('Guardar'),
              onPressed: ( _guardando ) ? null : _saveForm,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _saveForm() {

    var form = formKey.currentState;
    if ( !form.validate() ) return; 
    //Código cuando el formulario es válido...
    form.save();

    setState(() { _guardando = true; });

    final response = proyectosProvider.crearRelacionProyectoStaff( proyectoToStaff );

    response.then((value){
      if( value ){
        mostrarSnackbar("Colaborador asignado al proyecto exitosamente");
      } else {
        mostrarSnackbar("Hemos tenido un problema al crear la relación");
      }
    });

    new Timer(const Duration(milliseconds: 5000), () => 
      Navigator.pop(context)
    );

    /*setState(() { _guardando = false; });*/
  }

  void mostrarSnackbar( String mensaje ) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text( mensaje ),
          duration: Duration( milliseconds: 3500 ),
        ),
      );

  }

}