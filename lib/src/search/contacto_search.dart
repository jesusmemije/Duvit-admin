import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/models/contacto_model.dart';
import 'package:duvit_admin/src/providers/contactos_provider.dart';
import 'package:duvit_admin/src/providers/llamadas_pendientes_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactoSearch extends SearchDelegate {

  final contactosProvider          = new ContactosProvider();
  final llamadasPendientesProvider = new LlamadasPendientesProvider();

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
      future: contactosProvider.buscarContactos(query),
      builder: (BuildContext context, AsyncSnapshot<List<ContactoModel>> snapshot) {
        
        final contactos = snapshot.data;

        if ( snapshot.hasData ){

          if ( contactos.isNotEmpty ) {

            return ListView(
              children: contactos.map( (contacto) {
                return ListTile(
                  leading: Container(
                    width: 60.0,
                    child: new FlatButton(
                      onPressed: () => launch("tel://${ contacto.celular == '' ? contacto.telefonoCelular : contacto.celular }"),
                      child: new Icon(
                        Icons.call,
                        size: 30.0,
                        color: Theme.of(context).primaryColor,
                      )
                    ),
                  ),
                  title: Text(contacto.nombreCompleto),
                  subtitle: Text(
                    contacto.tipo + " - " + "${ contacto.celular == '' ? contacto.telefonoCelular : contacto.celular }",
                  ),
                  trailing: Container(
                    width: 60.0,
                    child: new FlatButton(
                      onPressed: (){
                        final code = llamadasPendientesProvider.crearLlamadaPendiente( contacto );
                        code.then((value) {

                          if( value ){
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Agregado a la lista de llamadas pendientes"),
                            ));
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Hemos tenido un problema interno, intente nuevamente por favor."),
                            ));
                          }

                        });
                      },
                      child: new Icon(
                        Icons.notifications,
                        size: 30.0,
                        color: DuvitAppTheme.grey,
                      )
                    ),
                  ),
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
