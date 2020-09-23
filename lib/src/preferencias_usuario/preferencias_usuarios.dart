import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  void clear(){
    _prefs.clear();
  }

  // GET y SET
  get logeado {
    return _prefs.getBool('logeado') ?? false;
  }

  set logeado( bool value ) {
    _prefs.setBool('logeado', value);
  }

  get idStaff {
    return _prefs.getString('idStaff') ?? '';
  }

  set idStaff( String value ) {
    _prefs.setString('idStaff', value);
  }

  get nombre {
    return _prefs.getString('nombre') ?? '';
  }

  set nombre( String value ) {
    _prefs.setString('nombre', value);
  }

  get correo {
    return _prefs.getString('correo') ?? '';
  }

  set correo( String value ) {
    _prefs.setString('correo', value);
  }
  

}