
import 'dart:convert';

import 'package:duvit_admin/src/models/contacto_model.dart';
import 'package:duvit_admin/src/models/llamada_pendiente_model.dart';
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

  Future<List<LlamadaPendienteModel>> mostrarLlamadasPendientesActivas() async {

    final url = '$_url/llamadas-pendientes.php';
    final resp = await http.get( url );
  
    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<LlamadaPendienteModel> llamadasPendientes = new List();

    decodedData.forEach((id, llamadaPendiente) {

      final llamadaPendienteTemp = LlamadaPendienteModel.fromJson(llamadaPendiente);
      llamadaPendienteTemp.id    = id;
      llamadasPendientes.add( llamadaPendienteTemp );

    });

    return llamadasPendientes;

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