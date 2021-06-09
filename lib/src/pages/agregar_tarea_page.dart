import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/models/agregar_tarea_model.dart';
import 'package:duvit_admin/src/models/staff_model.dart';
import 'package:duvit_admin/src/providers/agregar_tarea_provider.dart';
import 'package:duvit_admin/src/providers/staffs_provider.dart';
import 'package:duvit_admin/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';

class AgregarTareaPage extends StatefulWidget {
  @override
  _AgregarTareaPageState createState() => _AgregarTareaPageState();
}

class _AgregarTareaPageState extends State<AgregarTareaPage> {

  //Global Keys
  final formKey     = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  //Controllers for inputs datepicker
  String _fechaInicio = '';
  String _fechaFin    = '';
  String _fechaLimite = '';
  TextEditingController _dateFechaInicioController = new TextEditingController();
  TextEditingController _dateFechaFinController    = new TextEditingController();
  TextEditingController _dateFechaLimiteController = new TextEditingController();
  
  //Provider
  final agregarTareaProvider = new AgregarTareaProvider();
  final staffsProvider       = new StaffsProvider();

  //Models
  FodPlaneacionModel fodPlaneacion = new FodPlaneacionModel();
  StaffModel staff                 = new StaffModel();

  //Variables de control
  bool _guardando = false;

  int _currentIdProyecto;
  int _currentIdActividad;
  int _currentTarea;
  int _currentIdEstatus;
  int _currentDependencia;
  String _currentIdStaff;
  String _currentNombreStaff = "";

  bool _mostrarDropDowActividad = false;
  bool _mostrarDropDowTarea     = false;
  bool _mostrarDropDependencia  = false;

  bool _mostrarDropStaff        = false;
  bool _mostrarDropProyecto     = false;

  int _cltSetstate = 0;

  @override
  Widget build(BuildContext context) {
    
    //Rescatar instancia de model - arguments
    staff = ModalRoute.of(context).settings.arguments;

    if( staff != null ) {
      //Add idSataff for Model Form
      fodPlaneacion.idResponsable = int.parse(staff.id);
      _currentIdStaff      = staff.id;
      _currentNombreStaff  = staff.nombre;
      _mostrarDropStaff    = false;
      _mostrarDropProyecto = true;
    } else if( _cltSetstate == 0 ) {
      _mostrarDropStaff    = true;
      _mostrarDropProyecto = false;
    }

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
                  _tituloNombre( _currentNombreStaff ),
                  SizedBox(height: 20.0),
                  _mostrarDropStaff ? _dropDownStaff() : Container(),
                  _mostrarDropStaff ? SizedBox(height: 10.0) : Container(),
                  _mostrarDropProyecto ? _dropDownProyecto( _currentIdStaff ) : Container(),
                  _mostrarDropProyecto ? SizedBox(height: 10.0) : Container(),
                  _mostrarDropDowActividad ? _dropDownActividad( _currentIdProyecto ) : Container(),
                  _mostrarDropDowActividad ? SizedBox(height: 10.0) : Container(),
                  _mostrarDropDowTarea ? _dropDownTarea( _currentIdActividad ) : Container(),
                  _mostrarDropDowTarea ? SizedBox(height: 10.0) : Container(),
                  _textDetalleTarea(),
                  SizedBox(height: 10.0),
                  _dropDownEstatus(),
                  SizedBox(height: 10.0),
                  _textRequerimientos(),
                  SizedBox(height: 10.0),
                  _mostrarDropDependencia ? _dropDownDependencias() : Container(),
                  _mostrarDropDependencia ? SizedBox(height: 10.0) : Container(),
                  SizedBox(height: 10.0),
                  _textLabel('Tiempo estimado'),
                  SizedBox(height: 5.0),
                  _rowTiempoEstimado(),
                  SizedBox(height: 10.0),
                  _datePickerFechaInicio(context),
                  SizedBox(height: 10.0),
                  _datePickerFechaFin(context),
                  SizedBox(height: 10.0),
                  _datePickerFechaLimite(context),
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
      child: Text('Planeación de proyecto',
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

  Widget _tituloNombre(String nombreStaff ){

    return nombreStaff != "" ? Align (
      alignment: Alignment.centerLeft,
      child: Text('•$nombreStaff',
        style: TextStyle(
          fontFamily: DuvitAppTheme.fontName,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          letterSpacing: 1.2,
          color: DuvitAppTheme.deactivatedText,
        )
      )  ,
    ) : Container();
  }

  Widget _dropDownStaff() {

    return FutureBuilder<List<StaffModel>>(
      future: staffsProvider.cargarStaffs(),
      builder: (BuildContext context, AsyncSnapshot<List<StaffModel>> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return DropdownButtonFormField<String>(
            onSaved: ( value ) => fodPlaneacion.idResponsable = int.parse(value),
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
                _cltSetstate        = 1;
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
      future: agregarTareaProvider.buscarProyectosByStaff(idStaff),
      builder: (BuildContext context, AsyncSnapshot<List<ProyectoModel>> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return DropdownButtonFormField<int>(
            onSaved: ( value ) => fodPlaneacion.idProyecto = value,
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
                _currentIdProyecto       = value;
                _mostrarDropDowActividad = true;
                _mostrarDropDependencia  = true;
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

  Widget _dropDownActividad( int _currentIdProyecto ) {

    return FutureBuilder<List<ActividadModel>>(
      future: agregarTareaProvider.buscarActividadesByIdProyecto(_currentIdProyecto.toString()),
      builder: (BuildContext context, AsyncSnapshot<List<ActividadModel>> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return DropdownButtonFormField<int>(
            items: snapshot.data.map((actividad) => DropdownMenuItem<int>(
              child: Text(actividad.nombreActividad, style: DuvitAppTheme.estiloTextoInput, overflow: TextOverflow.ellipsis),
              value: actividad.id,
            )).toList(),
            onChanged: (value) {
              setState(() {
                _currentIdActividad  = value;
                _mostrarDropDowTarea = true;
              });
            },
            isExpanded: true,
            value: _currentIdActividad != null ? _currentIdActividad : null,
            icon: Icon(Icons.keyboard_arrow_down),
            style: DuvitAppTheme.estiloTextoInput,
            iconEnabledColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Selecciona una actividad',
              isDense: true,                      // Added this
            ),
            elevation: 24,
        );
      }
    );
  }

  Widget _dropDownTarea( int _currentIdActividad ) {
    
    return FutureBuilder<List<TareaModel>>(
      future: agregarTareaProvider.buscarTareasByIdActividad( _currentIdActividad.toString() ),
      builder: (BuildContext context, AsyncSnapshot<List<TareaModel>> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return DropdownButtonFormField<int>(
            onSaved: ( value ) => fodPlaneacion.idTarea = value,
            validator: ( value ) {
              if ( value == null ){
                return "No ha seleccionado la tarea";
              } else {
                return null;
              }
            },
            items: snapshot.data.map((tarea) => DropdownMenuItem<int>(
              child: Text(tarea.nombreTarea, style: DuvitAppTheme.estiloTextoInput, overflow: TextOverflow.ellipsis),
              value: tarea.id,
            )).toList(),
            onChanged: (value) {
              setState(() {
                _currentTarea = value;
              });
            },
            isExpanded: true,
            value: _currentTarea != null ? _currentTarea : null,
            icon: Icon(Icons.keyboard_arrow_down),
            style: DuvitAppTheme.estiloTextoInput,
            iconEnabledColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Selecciona una tarea',
              isDense: true,                      // Added this
            ),
            elevation: 24,
        );
      }
    );
  }

  Widget _textDetalleTarea() {
    return TextFormField(
      initialValue: fodPlaneacion.detalleTarea,
      textCapitalization: TextCapitalization.sentences,
      autofocus: false,
      maxLines: 2,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Detalle tarea',
        isDense: true,
      ),
      onSaved: (value) => fodPlaneacion.detalleTarea = value,
      validator: ( value ){
        if(value.length < 1){
          return "Ingresa el detalle";
        } else {
          return null;
        }
      },
    );
  }

  Widget _dropDownEstatus() {
    
    return FutureBuilder<List<EstatuPlaneacionModel>>(
      future: agregarTareaProvider.buscarEstatus(),
      builder: (BuildContext context, AsyncSnapshot<List<EstatuPlaneacionModel>> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return DropdownButtonFormField<int>(
            onSaved: ( value ) => fodPlaneacion.statusPlaneacion = value,
            validator: ( value ) {
              if ( value == null ){
                return "No ha seleccionado el estatus";
              } else {
                return null;
              }
            },
            items: snapshot.data.map((estatus) => DropdownMenuItem<int>(
              child: Text(estatus.estatusPlaneacion, style: DuvitAppTheme.estiloTextoInput, overflow: TextOverflow.ellipsis),
              value: estatus.id,
            )).toList(),
            onChanged: (value) {
              setState(() {
                _currentIdEstatus = value;
              });
            },
            isExpanded: true,
            value: _currentIdEstatus != null ? _currentIdEstatus : null,
            icon: Icon(Icons.keyboard_arrow_down),
            style: DuvitAppTheme.estiloTextoInput,
            iconEnabledColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Seleccione un estatus',
              isDense: true,                      // Added this
            ),
            elevation: 24,
        );
      }
    );
  }

  Widget _textRequerimientos() {
    return TextFormField(
      onSaved: ( value ) => fodPlaneacion.requerimientos = value,
      autofocus: false,
      maxLines: 2,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Requerimientos',
        isDense: true,
      ),
    );
  }

  Widget _dropDownDependencias() {
    
    return FutureBuilder<List<DependenciaModel>>(
      future: agregarTareaProvider.buscarDependenciasByIdProyecto(_currentIdProyecto.toString()),
      builder: (BuildContext context, AsyncSnapshot<List<DependenciaModel>> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return DropdownButtonFormField<int>(
            onSaved: ( value ) => fodPlaneacion.idDependencia = value,
            items: snapshot.data.map((dependencia) => DropdownMenuItem<int>(
              child: Text(dependencia.detalleTarea, style: DuvitAppTheme.estiloTextoInput, overflow: TextOverflow.ellipsis),
              value: dependencia.idPlaneacion,
            )).toList(),
            onChanged: (value) {
              setState(() {
                _currentDependencia = value;
              });
            },
            isExpanded: true,
            value: _currentDependencia != null ? _currentDependencia : null,
            icon: Icon(Icons.keyboard_arrow_down),
            style: DuvitAppTheme.estiloTextoInput,
            iconEnabledColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Seleccione dependencia (opcional)',
              isDense: true,
            ),
            elevation: 24,
        );
      }
    );

  }

  Widget _rowTiempoEstimado() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: new Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: TextFormField(
              initialValue: fodPlaneacion.dias.toString(),
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Dias',
                isDense: true,
              ),
              onSaved: (value) => fodPlaneacion.dias = int.parse(value),
              validator: ( value ) {
                if ( utils.isNumeric(value) ){
                    return null;
                } else {
                  return "Sólo números";
                }
              },
            ),
          ),
        ),
        Expanded(
          child: new Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: TextFormField(
              initialValue: fodPlaneacion.horas.toString(),
              textCapitalization: TextCapitalization.sentences,
              //keyboardType: TextInputType.numberWithOptions(decimal: true),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Horas',
                isDense: true,
              ),
              onSaved: (value) => fodPlaneacion.horas = int.parse(value),
              validator: ( value ) {
                if ( utils.isNumeric(value) ){
                  return null;
                } else {
                  return "Sólo números";
                }
              },
            ),
          ),
        ),
        Expanded(
          child: new Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: TextFormField(
              initialValue: fodPlaneacion.minutos.toString(),
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Minutos',
                isDense: true,
              ),
              onSaved: (value) => fodPlaneacion.minutos = int.parse(value),
              validator: ( value ) {
                if ( utils.isNumeric(value) ){
                  if ( int.parse(value) > 60 ) {
                    return "Menos de 60";
                  } else {
                    return null;
                  }
                } else {
                  return "Sólo números";
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _datePickerFechaInicio(BuildContext context) {
    return TextFormField(
      onSaved: ( value ) => fodPlaneacion.fechaInicio = value,
      validator: ( value ) {
        if ( value.isEmpty ) {
          return "No ha seleccionado fecha inicio";
        } else {
          return null;
        }
      },
      controller: _dateFechaInicioController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Fecha inicio',
        isDense: true,
      ),
      onTap: () {
        // Below line stops keyboard from appearing
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDateFechaInicio(context);
      },
    );
  }

  _selectDateFechaInicio(BuildContext context) async {
    DateTime picked = await showDatePicker(
      builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: Theme.of(context).primaryColor,
                accentColor: Theme.of(context).primaryColor,
                cardColor: Theme.of(context).primaryColor,
                colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor),
                buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
                ),
            ),
            child: child,
          );
        },
        confirmText: "SELECCIONAR",
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2025));

    if (picked != null) {
      setState(() {
        _fechaInicio = picked.toString().split(' ')[0];
        _dateFechaInicioController.text = _fechaInicio;
      });
    }
  }

  Widget _datePickerFechaFin(BuildContext context) {
    return TextFormField(
      onSaved: ( value ) => fodPlaneacion.fechaFin = value,
      validator: ( value ) {
        if ( value.isEmpty ) {
          return "No ha seleccionado fecha fin";
        } else {
          return null;
        }
      },
      controller: _dateFechaFinController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Fecha fin',
        isDense: true,                      // Added this
      ),
      onTap: () {
        // Below line stops keyboard from appearing
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDateFechaFin(context);
      },
    );
  }

  _selectDateFechaFin(BuildContext context) async {
    DateTime picked = await showDatePicker(
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: Theme.of(context).primaryColor,
                accentColor: Theme.of(context).primaryColor,
                cardColor: Theme.of(context).primaryColor,
                colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor),
                buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
                ),
            ),
            child: child,
          );
        },
        confirmText: "SELECCIONAR",
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2025));

    if (picked != null) {
      setState(() {
        _fechaFin = picked.toString().split(' ')[0];
        _dateFechaFinController.text = _fechaFin;
      });
    }
  }

  Widget _datePickerFechaLimite(BuildContext context) {
    return TextFormField(
      onSaved: ( value ) => fodPlaneacion.fechaLimite = value,
      validator: ( value ) {
        if ( value.isEmpty ) {
          return "No ha seleccionado fecha límite";
        } else {
          return null;
        }
      },
      controller: _dateFechaLimiteController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Fecha límite',
        isDense: true,                      // Added this
      ),
      onTap: () {
        // Below line stops keyboard from appearing
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDateFechaLimite(context);
      },
    );
  }

  _selectDateFechaLimite(BuildContext context) async {
    DateTime picked = await showDatePicker(
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: Theme.of(context).primaryColor,
                accentColor: Theme.of(context).primaryColor,
                cardColor: Theme.of(context).primaryColor,
                colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor),
                buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
                ),
            ),
            child: child,
          );
        },
        confirmText: "SELECCIONAR",
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2025));

    if (picked != null) {
      setState(() {
        _fechaLimite = picked.toString().split(' ')[0];
        _dateFechaLimiteController.text = _fechaLimite;
      });
    }
  }

  Widget _textLabel(String titulo) {

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Text(titulo, style: DuvitAppTheme.estiloTextoInput),
        ),
      ],
    );

  }

  Widget _rowBotones(){

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.arrow_back),
              label:  Text('Regresar'),
              onPressed: (){
                if ( staff != null ) {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'tareas', arguments: staff);
                } else {
                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
              ),
            )
          ),
        ),
        Expanded (
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.save),
              label:  Text('Guardar'),
              onPressed: ( _guardando ) ? null : _saveForm,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
              ),
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

    final response = agregarTareaProvider.crearFODPlaneacion(fodPlaneacion);

    response.then((value){
      if( value ){
        mostrarSnackbar("La tarea se ha registrado con éxito");
      } else {
        mostrarSnackbar("Hemos tenido un problema al intentar registrar la tarea");
      }
    });

    Duration(milliseconds: 1500);

    if ( staff != null ) {
      Navigator.pop(context);
      Navigator.pushNamed(context, 'tareas', arguments: staff);
    } else {
      Navigator.pop(context);
    }

    //setState(() { _guardando = false; });
  }

  void mostrarSnackbar( String mensaje ) {

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text( mensaje ),
          duration: Duration( milliseconds: 1500 ),
        ),
      );

  }

}
