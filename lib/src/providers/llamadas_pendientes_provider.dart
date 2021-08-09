
import 'dart:convert';

import 'package:duvit_admin/src/models/contacto_model.dart';
import 'package:duvit_admin/src/preferencias_usuario/preferencias_usuarios.dart';
import 'package:http/http.dart' as http;

class LlamadasPendientesProvider {

  final String _url = "http://www.duvitapp.com/WebService/v1";
  final _prefs      = new PreferenciasUsuario();

  Future<bool> crearLlamadaPendiente( ContactoModel contacto ) async {
    
    String idStaff = _prefs.idStaff;
    
    final url  = '$_url/llamadas-pendientes.php?type=insert&idStaff=$idStaff';
    final resp = await http.post( Uri.parse(url), body: contactoModelToJson( contacto ) );

    final decodedData = json.decode(resp.body);

    if ( decodedData['code'] == '201' ) {
      return true;
    } else {
      return false;
    }

  }

  Future<List> mostrarLlamadasPendientesActivas() async {

    String idStaff = _prefs.idStaff;
    
    final url  = '$_url/llamadas-pendientes.php?type=show&idStaff=$idStaff';
    final response = await http.get( Uri.parse(url) );
    
    List listaLlamadasPendientesByGroup = json.decode(response.body);

    return listaLlamadasPendientesByGroup;

  }

  Future<bool> deleteLlamadaPendiente( String id ) async {

    String idStaff = _prefs.idStaff;
    
    final url  = '$_url/llamadas-pendientes.php?type=delete&idStaff=$idStaff&iddelete=$id';
    final resp = await http.get( Uri.parse(url) );

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if ( decodedData['code'] == '201' ) {
      return true;
    } else {
      return false;
    }

  }


}