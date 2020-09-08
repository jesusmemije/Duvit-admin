import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/models/llamada_pendiente_model.dart';
import 'package:duvit_admin/src/providers/llamadas_pendientes_provider.dart';
import 'package:duvit_admin/src/search/contacto_search.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LlamadasPage extends StatefulWidget {

  @override
  _LlamadasPageState createState() => _LlamadasPageState();
}

class _LlamadasPageState extends State<LlamadasPage> with TickerProviderStateMixin {

  final llamadasPendientesProvider = new LlamadasPendientesProvider();

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
    return Stack(
      children: [
        _crearListado(),
        _getAppBarUI(),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        ),
      ],
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: llamadasPendientesProvider.mostrarLlamadasPendientesActivas(),
      builder: (BuildContext context, AsyncSnapshot<List<LlamadaPendienteModel>> snapshot) {

        final llamadasPendientes = snapshot.data;
        if (snapshot.hasData) {

          if ( llamadasPendientes.isNotEmpty ) {

            return ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.only(
                top: AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top +
                    24,
                bottom: 30 + MediaQuery.of(context).padding.bottom,
              ),
              itemCount: llamadasPendientes.length,
              itemBuilder: (context, i) => _crearItem(context, llamadasPendientes[i]),
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

  Widget _crearItem(BuildContext context, LlamadaPendienteModel llamadasPendientes) {
    return Card(
      key: ValueKey(llamadasPendientes.id),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: Dismissible(
          key: UniqueKey(),
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
          onDismissed: ( direction ) {

            if ( direction == DismissDirection.startToEnd ) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Llamando..."),
              ));
              launch("tel://${ llamadasPendientes.celular }");
              setState(() {});
            }

            if ( direction == DismissDirection.endToStart ) {
              final code = llamadasPendientesProvider.deleteLlamadaPendiente(llamadasPendientes.id);
              code.then((value) {
                
                if( value ){
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Llamada pendiente eliminada correctamente"),
                  ));
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Hemos tenido un problema interno, no eliminado."),
                  ));
                }
              });
            }

          },
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            title: Text(
              llamadasPendientes.nombre,
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
                          text: llamadasPendientes.tipo + " - " + llamadasPendientes.celular,
                          style: DuvitAppTheme.subtitle,
                        )
                      ),
                      RichText(
                        text: TextSpan(
                          text: llamadasPendientes.fecha,
                          style: DuvitAppTheme.subtitle,
                        )
                      ),
                    ]
                  )
                )
              ],
            ),
            trailing:
                Icon(Icons.call, color: Theme.of(context).primaryColor, size: 30.0),
            onTap: () => launch("tel://${llamadasPendientes.celular}")
          ),
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
                        child: Text(
                          'Llamadas',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: DuvitAppTheme.fontName,
                            fontWeight: FontWeight.w700,
                            fontSize: 22 + 6 - 6 * topBarOpacity,
                            letterSpacing: 1.2,
                            color: DuvitAppTheme.darkerText,
                          ),
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
                          showSearch(
                            context: context,
                            delegate: ContactoSearch(),
                          );
                        },
                        child: Center(
                          child: Icon(
                            Icons.search,
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
