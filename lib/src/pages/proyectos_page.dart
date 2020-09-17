import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/providers/proyectos_provider.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class ProyectosPage extends StatelessWidget {

  final proyectosProvider = ProyectosProvider();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _crearAppBar(),
      body: _crearLista(),
    );
  }

  Widget _crearLista() {

    return FutureBuilder(
      future: proyectosProvider.getProyectos(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

        return GroupedListView<dynamic, String>(
          groupBy: (element) => element['nombreProyecto'],
          elements: snapshot.data,
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          //stickyHeaderBackgroundColor: Colors.deepPurple[100],
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          itemBuilder: (context, element) {
            return Card (
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
                          element['detalleTarea'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: DuvitAppTheme.title,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "• " + element['nombreStaff'],
                          overflow: TextOverflow.ellipsis,
                          style: DuvitAppTheme.caption,
                        ),
                      ),
                    ],
                  )
                ),
              ),
            );
          },
        );
      },
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
            child: Text(
              'Proyectos',
              style: DuvitAppTheme.estiloTituloPagina
            ),
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
                  Icons.add,
                  color: DuvitAppTheme.darkerText,
                ),
            )
          ),
        ],
      ),
    );
  }

}
