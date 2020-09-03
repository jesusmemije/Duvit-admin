import 'package:duvit_admin/duvit_app_theme.dart';
import 'package:duvit_admin/src/models/staff_model.dart';
import 'package:duvit_admin/src/providers/staffs_provider.dart';
import 'package:duvit_admin/src/search/search_delegate.dart';
import 'package:flutter/material.dart';

class StaffsPage extends StatefulWidget {
  static const Color transparent = Color(0x00000000);

  @override
  _StaffsPageState createState() => _StaffsPageState();
}

class _StaffsPageState extends State<StaffsPage> with TickerProviderStateMixin {
  final staffsProvider = new StaffsProvider();

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
      future: staffsProvider.cargarStaffs(),
      builder:
          (BuildContext context, AsyncSnapshot<List<StaffModel>> snapshot) {
        if (snapshot.hasData) {
          final staffs = snapshot.data;

          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 30 + MediaQuery.of(context).padding.bottom,
            ),
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
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border( right:new BorderSide(width: 1.0, color: Colors.black54))
              ),
              child: Hero(
                tag: "avatar_" + staff.nombre,
                child: CircleAvatar(
                  radius: 32,
                  backgroundColor: Theme.of(context).primaryColor,
                  backgroundImage: staff.idGenero == 1
                        ? AssetImage('assets/img/avatar_hombre.png')
                        : AssetImage('assets/img/avatar_mujer.png'),
                )
              )
            ),
          title: Text(
            staff.nombre,
            style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
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
                        style: TextStyle(color: Colors.black54),
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
              Icon(Icons.keyboard_arrow_right, color: Colors.black54, size: 30.0),
          onTap: () {
            Navigator.pushNamed(context, 'tareas', arguments: staff);
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
                        child: Text(
                          'Empleados',
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
                            delegate: StaffSearch(),
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
