import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/models/staff_model.dart';
import 'package:duvit_admin/src/models/tarea_model.dart';
import 'package:duvit_admin/src/providers/staffs_provider.dart';
import 'package:duvit_admin/src/providers/tareas_provider.dart';

import 'package:flutter/material.dart';

class HistorialTareasPage extends StatefulWidget {
  static const Color transparent = Color(0x00000000);

  @override
  _HistorialTareasPageState createState() => _HistorialTareasPageState();
}

class _HistorialTareasPageState extends State<HistorialTareasPage> with TickerProviderStateMixin {
  final staffsProvider = new StaffsProvider();

  final tareasProvider = new TareasProvider();

  ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final StaffModel staff = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Stack(
        children: [
          _crearListado( staff ),
          _getAppBarUI(),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
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
              controller: scrollController,
              padding: EdgeInsets.only(
                top: AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top +
                    24,
                bottom: 30 + MediaQuery.of(context).padding.bottom,
              ),
              itemCount: tareas.length,
              itemBuilder: (context, i) => _crearItem(context, tareas[i]),
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

  Widget _crearItem(BuildContext context, TareaModel tarea) {
    return Card(
      key: ValueKey(tarea.idPlaneacion),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
          trailing: Icon(
            Icons.group,
            color: Theme.of(context).primaryColor, 
            size: 30.0
          ),
          onTap: () {
            //Navigator.pushNamed(context, 'tareas');
          },
        ),
      ),
    );
  }

  Widget _getAppBarUI() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: DuvitAppTheme.white.withOpacity(topBarOpacity),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: DuvitAppTheme.grey.withOpacity(0.4 * topBarOpacity),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16 - 8.0 * topBarOpacity,
                    bottom: 12 - 8.0 * topBarOpacity),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Tareas',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: DuvitAppTheme.fontName,
                                fontWeight: FontWeight.w700,
                                fontSize: 22 + 6 - 6 * topBarOpacity,
                                letterSpacing: 1.2,
                                color: DuvitAppTheme.darkerText,
                              ),
                            ),
                            Text(
                              ' historial',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: DuvitAppTheme.fontName,
                                fontWeight: FontWeight.w700,
                                fontSize: 9 + 6 - 6 * topBarOpacity,
                                letterSpacing: 1.2,
                                color: DuvitAppTheme.lightText,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 38,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32.0)),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Icon(
                            Icons.close,
                            color: DuvitAppTheme.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
