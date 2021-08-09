import 'dart:convert';

import 'package:duvit_admin/src/preferencias_usuario/preferencias_usuarios.dart';
import 'package:http/http.dart' as http;

class LoginProvider {

  final String _url = "http://www.duvitapp.com/WebService/v1";
  final _prefs      = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login( String usuario, String password ) async {

    final url = '$_url/login.php?usuario=$usuario&password=$password';
    final response = await http.get( Uri.parse(url) );
    
    final Map<String, dynamic> decodedData = json.decode(response.body);

    if ( decodedData['ok'] ) {
      _prefs.logeado = decodedData['ok'];
      _prefs.idStaff = decodedData['idStaff'].toString();
      _prefs.nombre  = decodedData['nombre'];
      _prefs.correo  = decodedData['correo'];
    }

    return decodedData;

  }

}