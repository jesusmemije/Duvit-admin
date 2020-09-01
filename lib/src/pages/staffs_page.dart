import 'package:duvit_admin/src/models/staff_model.dart';
import 'package:duvit_admin/src/providers/staffs_provider.dart';
import 'package:flutter/material.dart';

class StaffsPage extends StatelessWidget {

  final staffsProvider = new StaffsProvider();
  static const Color transparent = Color(0x00000000);

  @override
  Widget build(BuildContext context) {

    return _crearListado();
  }

  Widget _crearListado() {

    return FutureBuilder(
      future: staffsProvider.cargarStaffs(),
      builder: (BuildContext context, AsyncSnapshot<List<StaffModel>> snapshot) {
        
        if ( snapshot.hasData ) {

          final staffs = snapshot.data;

          return ListView.builder(
            itemCount: staffs.length,
            itemBuilder: ( context, i ) => _crearItem( context, staffs[i] ),
          );

        } else {
          return Center( child: CircularProgressIndicator() );
        }

      },
    );

  }

  Widget _crearItem(BuildContext context, StaffModel staff) {
    return Card(
      key: ValueKey(staff.id),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: <Color>[
              Color.fromRGBO(8, 2, 249, 1.0),
              Color.fromRGBO(239, 90, 38, 1.0)
            ])
      ),
        child: ListTile(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.white24))),
              child: Hero(
                  tag: "avatar_" + staff.nombre,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.deepPurple,
                    backgroundImage: staff.idGenero == 1
                                    ? AssetImage('assets/img/avatar_hombre.png') 
                                    : AssetImage('assets/img/avatar_mujer.png'),
                  )
              )
          ),
          title: Text(
            staff.nombre,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              new Flexible(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: staff.correo,
                        style: TextStyle(color: Colors.white),
                      ),
                      maxLines: 3,
                      softWrap: true,
                    )
                  ]
                )
              )
            ],
          ),
          trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.pushNamed(context, 'detalles');
           },
        ),
      ),
    );
  }

}