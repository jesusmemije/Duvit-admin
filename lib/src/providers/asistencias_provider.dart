import 'dart:convert';

import 'package:http/http.dart' as http;

class AsistenciasProvider {

  final String _url = "http://www.duvitapp.com/WebService/v1";

  Future<List> mostrarAsistenciasByDate( _fechaAsistencia ) async {

    final url = '$_url/asistencia.php?method=getAsistencias&date=$_fechaAsistencia';
    final response = await http.get( Uri.parse(url) );
    
    List listaAsistenciasByGroup = json.decode(response.body);

    return listaAsistenciasByGroup;

  }

}