import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/models/staff_model.dart';
import 'package:duvit_admin/src/providers/staffs_provider.dart';
import 'package:flutter/material.dart';

class StaffSearch extends SearchDelegate {

  final staffsProvider = new StaffsProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    //Acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: (){
          query = '';
        }
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crear los resultados quevamos a mostrar en la misma pantalla de búsqueda
    // En este caso no me sirve.
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las segurencias que aparecen cuando la persona escribe.

    if ( query.isEmpty ) return Container();

    return FutureBuilder(
      future: staffsProvider.buscarStaff(query),
      builder: (BuildContext context, AsyncSnapshot<List<StaffModel>> snapshot) {
        
        final staffs = snapshot.data;

        if ( snapshot.hasData ){

          if ( staffs.isNotEmpty ) {

            return ListView(
              children: staffs.map( (staff) {
                return ListTile(
                  leading: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'), 
                    image: staff.idGenero == 1
                                    ? AssetImage('assets/img/avatar_hombre.png') 
                                    : AssetImage('assets/img/avatar_mujer.png'),
                    fit: BoxFit.contain,
                  ),
                  title: Text(staff.nombre),
                  subtitle: Text(staff.correoCorporativo),
                  onTap: (){
                    close(context, null);
                    Navigator.pushNamed(context, 'tareas', arguments: staff);
                  },
                );
              }).toList(),
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
                      'No se encontraron datos relacionados',
                      style: TextStyle(color: DuvitAppTheme.lightText),
                    ),
                  ],
                ),
              ],
            );

          }
          
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

      },
    );

  }

}
