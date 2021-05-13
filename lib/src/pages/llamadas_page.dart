import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/providers/llamadas_pendientes_provider.dart';
import 'package:duvit_admin/src/search/contacto_search.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:url_launcher/url_launcher.dart';

class LlamadasPage extends StatefulWidget {
  @override
  _LlamadasPageState createState() => _LlamadasPageState();
}

class _LlamadasPageState extends State<LlamadasPage> {
  final llamadasPendientesProvider = new LlamadasPendientesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _crearAppBar(),
      body: _crearListado(),
    );
  }

  Widget _crearListado() {

    return FutureBuilder(
      future: llamadasPendientesProvider.mostrarLlamadasPendientesActivas(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        final llamadasPendientes = snapshot.data;

        if (snapshot.hasData) {
          if (llamadasPendientes.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: GroupedListView<dynamic, String>(
                groupBy: (llamadaPendiente) {
                  return llamadaPendiente['fecha_group'];
                },
                elements: llamadasPendientes,
                //order: GroupedListOrder.DESC,
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
                itemBuilder: (context, llamadaPendiente) =>
                    _crearItem(context, llamadaPendiente),
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
                      Icons.done,
                      color: DuvitAppTheme.lightText,
                      size: 40.0,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'No tiene llamadas pendientes',
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

  Widget _crearItem(BuildContext context, dynamic llamadaPendiente) {

    return Container(
      child: Dismissible(
        key: ValueKey(llamadaPendiente['id']),
        background: Container(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Icon(Icons.call, color: Colors.white),
                Text(' Llamar', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.delete, color: Colors.white),
                Text('Eliminar', style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Llamando..."),
              ),
            );
            
            launch("tel://${llamadaPendiente['celular']}");
            setState(() {});
          }

          if (direction == DismissDirection.endToStart) {
            final code = llamadasPendientesProvider
                .deleteLlamadaPendiente(llamadaPendiente['id'].toString());
            code.then((value) {
              if (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Llamada pendiente eliminada correctamente"),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Hemos tenido un problema interno, no eliminado."),
                  ),
                );
              }
            });
          }
        },
        child: Card(
          key: ValueKey(llamadaPendiente['id']),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                title: Text(
                  llamadaPendiente['nombre'],
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
                            text: llamadaPendiente['tipo'] +
                                " • " +
                                llamadaPendiente['celular'],
                            style: DuvitAppTheme.subtitle,
                          )),
                          RichText(
                              text: TextSpan(
                            text: llamadaPendiente['fecha'],
                            style: DuvitAppTheme.subtitle,
                          )),
                        ]))
                  ],
                ),
                trailing: Icon(Icons.call,
                    color: Theme.of(context).primaryColor, size: 30.0),
                onTap: () => launch("tel://${llamadaPendiente['celular']}")),
          ),
        ),
      ),
    );
  }

  Widget _crearAppBar() {

    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('Llamadas', style: DuvitAppTheme.estiloTituloPagina),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 8.0, right: 4.0),
            child: IconButton(
              color: Colors.red,
              icon: Icon(
                Icons.search,
                color: DuvitAppTheme.darkerText,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ContactoSearch(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
