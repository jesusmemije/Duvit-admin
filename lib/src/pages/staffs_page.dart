import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/models/staff_model.dart';
import 'package:duvit_admin/src/providers/staffs_provider.dart';
import 'package:duvit_admin/src/search/staff_search.dart';
import 'package:flutter/material.dart';

class StaffsPage extends StatelessWidget {

  final staffsProvider = new StaffsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _crearAppBar( context ),
      body: _crearListado(),
    );
  }

  Widget _crearListado() {

    return FutureBuilder(
      future: staffsProvider.cargarStaffs(),
      builder:
          (BuildContext context, AsyncSnapshot<List<StaffModel>> snapshot) {

        if (snapshot.hasData) {
          final staffs = snapshot.data;
          return ListView.builder(
            itemCount: staffs.length,
            itemBuilder: (context, i) => _crearItem(context, staffs[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }

      },
    );
  }

  Widget _crearItem(BuildContext context, StaffModel staff) {

    return Card(
      key: ValueKey(staff.id),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right:
                          new BorderSide(width: 1.0, color: Colors.black54))),
              child: Hero(
                  tag: "avatar_" + staff.nombre,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Theme.of(context).primaryColor,
                    backgroundImage: staff.idGenero == 1
                        ? AssetImage('assets/img/avatar_hombre.png')
                        : AssetImage('assets/img/avatar_mujer.png'),
                  ))),
          title: Text(
            staff.nombre,
            style: DuvitAppTheme.title,
          ),
          subtitle: Row(
            children: <Widget>[
              new Flexible(
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: staff.correoCorporativo == ''
                            ? staff.correoCorporativo
                            : staff.correoPersonal,
                        style: DuvitAppTheme.subtitle,
                      ),
                      maxLines: 3,
                      softWrap: true,
                    )
                  ]))
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.black54, size: 30.0),
          onTap: () {
            Navigator.pushNamed(context, 'tareas', arguments: staff);
          },
        ),
      ),
    );
  }

  Widget _crearAppBar( BuildContext context ) {

    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 30.0),
          child: Align(
            alignment: Alignment.center,
            child: Text('Empleados', 
            style: DuvitAppTheme.estiloTituloPagina
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
                  showSearch(
                    context: context,
                    delegate: StaffSearch(),
                  );
                },
                child: Icon(
                  Icons.search,
                  color: DuvitAppTheme.darkerText,
                ),
            )
          ),
        ],
      ),
    );
  }
}
