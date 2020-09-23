import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/providers/asistencias_provider.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class AsistenciaPage extends StatefulWidget {
  @override
  _AsistenciaPageState createState() => _AsistenciaPageState();
}

class _AsistenciaPageState extends State<AsistenciaPage> {

  final asistenciasProvider = AsistenciasProvider();

  String _fechaAsistencia = '';
  DateTime _fechaInicial  = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _crearAppBar(),
      body: _crearLista()
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
                  Icons.date_range,
                  color: DuvitAppTheme.darkerText,
                ),
                onPressed: () async {
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
                    initialDate: _fechaInicial,
                    firstDate: new DateTime(2020),
                    lastDate: new DateTime.now()
                  );

                  if (picked != null) {
                    setState(() {
                      /*_fechaInicio = picked.toString().split(' ')[0];
                      _dateFechaInicioController.text = _fechaInicio;*/
                      _fechaInicial    = DateTime(picked.year, picked.month, picked.day);
                      _fechaAsistencia = picked.toString().split(' ')[0];
                    });
                  }
                },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearLista() {

    return FutureBuilder(
      future: asistenciasProvider.mostrarAsistenciasByDate( _fechaAsistencia ),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        
        final asistencias = snapshot.data;

        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        if ( asistencias.isNotEmpty ) {
          return Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: GroupedListView<dynamic, String>(
              groupBy: (asistencia) => asistencia['tipo'],
              elements: asistencias,
              order: GroupedListOrder.ASC,
              useStickyGroupSeparators: true,
              //stickyHeaderBackgroundColor: Colors.deepPurple[100],
              groupSeparatorBuilder: (String value) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              itemBuilder: (context, asistencia) => _crearItem(context, asistencia),
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
                      'No se encontraron asistencias',
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

  Widget _crearItem(BuildContext context, dynamic asistencia) {

    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            title: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    asistencia['nombre'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: DuvitAppTheme.title,
                  ),
                ),
                SizedBox(height: 5.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "• " + asistencia['fechaEntrada'],
                    overflow: TextOverflow.ellipsis,
                    style: DuvitAppTheme.caption,
                  ),
                ),
              ],
            )
        ),
      ),
    );

  }

}
