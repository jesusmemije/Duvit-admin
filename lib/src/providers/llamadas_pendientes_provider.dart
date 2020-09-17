
import 'dart:convert';

import 'package:duvit_admin/src/models/contacto_model.dart';
import 'package:http/http.dart' as http;

class LlamadasPendientesProvider {

  final String _url = "http://www.duvitapp.com/WebService/v1";

  Future<bool> crearLlamadaPendiente( ContactoModel contacto ) async {
    
    final url  = '$_url/llamadas-pendientes.php';
    final resp = await http.post(url, body: contactoModelToJson( contacto ) );

    final decodedData = json.decode(resp.body);

    if ( decodedData['code'] == '201' ) {
      return true;
    } else {
      return false;
    }

  }

  Future<List> mostrarLlamadasPendientesActivas() async {

    final url = '$_url/llamadas-pendientes.php';
    final response = await http.get( url );
    
    List listaLlamadasPendientesByGroup = json.decode(response.body);

    return listaLlamadasPendientesByGroup;

  }

  Future<bool> deleteLlamadaPendiente( String id ) async {

    final url = '$_url/llamadas-pendientes.php?iddelete=$id';
    final resp = await http.get( url );

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if ( decodedData['code'] == '201' ) {
      return true;
    } else {
      return false;
    }

  }


}