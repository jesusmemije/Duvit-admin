import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/models/staff_model.dart';
import 'package:flutter/material.dart';

class AgregarTareaPage extends StatefulWidget {
  @override
  _AgregarTareaPageState createState() => _AgregarTareaPageState();
}

class _AgregarTareaPageState extends State<AgregarTareaPage> {
  String _myActivity;

  final formKey = new GlobalKey<FormState>();

  String _fechaInicio = '';
  TextEditingController _dateFechaInicioController = new TextEditingController();

  String _fechaFin = '';
  TextEditingController _dateFechaFinController = new TextEditingController();

  String _fechaLimite = '';
  TextEditingController _dateFechaLimiteController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final StaffModel staff = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: SafeArea(
              child: Column(
                children: [
                  Text('Planeación de proyecto - ${staff.nombre}',
                      style: TextStyle(
                        fontFamily: DuvitAppTheme.fontName,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        letterSpacing: 1.2,
                        color: DuvitAppTheme.darkerText,
                      )),
                  SizedBox(height: 20.0),
                  _dropDownProyecto(),
                  SizedBox(height: 10.0),
                  _dropDownActividad(),
                  SizedBox(height: 10.0),
                  _dropDownTarea(),
                  SizedBox(height: 10.0),
                  _textDetalleTarea(),
                  SizedBox(height: 10.0),
                  _dropDownEstatus(),
                  SizedBox(height: 10.0),
                  _textRequerimientos(),
                  SizedBox(height: 10.0),
                  _dropDownDependencias(),
                  SizedBox(height: 10.0),
                  _textDetalleDependencia(),
                  SizedBox(height: 15.0),
                  _textLabel('Tiempo estimado'),
                  _rowTiempoEstimado(),
                  SizedBox(height: 10.0),
                  _datePickerFechaInicio(context),
                  SizedBox(height: 10.0),
                  _datePickerFechaFin( context ),
                  SizedBox(height: 10.0),
                  _datePickerFechaLimite( context ),
                  SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(8),
                    child: RaisedButton(
                      child: Text('Agregar'),
                      onPressed: _saveForm,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, 'tareas', arguments: staff);
        },
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(Icons.arrow_back),
        label: Text('Regresar'),
      ),
    );
  }

  Widget _dropDownProyecto() {
    return DropDownFormField(
      titleText: 'Proyecto en proceso',
      hintText: 'Elige un proyecto',
      onSaved: (value) {},
      onChanged: (value) {},
      dataSource: [
        {
          "display": "Actualización de aplicación Focus",
          "value": "Actualización de aplicación Focus",
        },
        {
          "display": "Climbing",
          "value": "Climbing",
        }
      ],
      textField: 'display',
      valueField: 'value',
    );
  }

  Widget _dropDownActividad() {
    return DropDownFormField(
      titleText: 'Actividad',
      hintText: 'Elige una actividad',
      onSaved: (value) {},
      onChanged: (value) {},
      dataSource: [
        {
          "display": "Desarrollar base de datos",
          "value": "Desarrollar base de datos",
        },
        {
          "display": "Climbing",
          "value": "Climbing",
        }
      ],
      textField: 'display',
      valueField: 'value',
    );
  }

  Widget _dropDownTarea() {
    return DropDownFormField(
      titleText: 'Tarea',
      hintText: 'Elige la tarea',
      onSaved: (value) {},
      value: _myActivity,
      onChanged: (value) {
        setState(() {
          _myActivity = value;
        });
      },
      dataSource: [
        {
          "display": "Diseñar la base de datos",
          "value": "Diseñar la base de datos",
        },
        {
          "display": "Climbing",
          "value": "Climbing",
        }
      ],
      textField: 'display',
      valueField: 'value',
    );
  }

  Widget _textDetalleTarea() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Detalle tarea'),
    );
  }

  Widget _dropDownEstatus() {
    return DropDownFormField(
      titleText: 'Estatus',
      hintText: 'Elige el estatus de la tarea',
      onSaved: (value) {},
      onChanged: (value) {},
      dataSource: [
        {
          "display": "Diseñar la base de datos",
          "value": "Diseñar la base de datos",
        },
        {
          "display": "Climbing",
          "value": "Climbing",
        }
      ],
      textField: 'display',
      valueField: 'value',
    );
  }

  Widget _textRequerimientos() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Requerimientos'),
    );
  }

  Widget _dropDownDependencias() {
    return DropDownFormField(
      titleText: 'Dependencias',
      hintText: 'Elige la dependencia de la tarea',
      onSaved: (value) {},
      onChanged: (value) {},
      dataSource: [
        {
          "display": "Diseñar la base de datos",
          "value": "Diseñar la base de datos",
        },
        {
          "display": "Climbing",
          "value": "Climbing",
        }
      ],
      textField: 'display',
      valueField: 'value',
    );
  }

  Widget _textDetalleDependencia() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Detalle dependencia'),
    );
  }

  Widget _rowTiempoEstimado() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: new Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: 'Dias'),
            ),
          ),
        ),
        Expanded(
          child: new Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: 'Horas'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _datePickerFechaInicio(BuildContext context) {
    return TextFormField(
      controller: _dateFechaInicioController,
      decoration: InputDecoration(labelText: 'Fecha inicio'),
      onTap: () {
        // Below line stops keyboard from appearing
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDateFechaInicio(context);
      },
    );
  }

  _selectDateFechaInicio(BuildContext context) async {
    DateTime picked = await showDatePicker(
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
      controller: _dateFechaFinController,
      decoration: InputDecoration(labelText: 'Fecha fin'),
      onTap: () {
        // Below line stops keyboard from appearing
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDateFechaFin(context);
      },
    );
  }

  _selectDateFechaFin(BuildContext context) async {
    DateTime picked = await showDatePicker(
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
      controller: _dateFechaLimiteController,
      decoration: InputDecoration(labelText: 'Fecha límite'),
      onTap: () {
        // Below line stops keyboard from appearing
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDateFechaLimite(context);
      },
    );
  }

  _selectDateFechaLimite(BuildContext context) async {
    DateTime picked = await showDatePicker(
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
          child: new Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0),
            child: Text( titulo ),
          ),
        ),
      ],
    );
  }

  _saveForm() {
    /*var form = formKey.currentState;
    if (form.validate()) {
      form.save();
    }*/
  }

}
