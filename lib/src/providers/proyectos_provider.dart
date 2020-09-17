import 'dart:convert';
import 'package:http/http.dart' as http;

class ProyectosProvider {

  final String _url = "http://www.duvitapp.com/WebService/v1";

  Future<List> getProyectos() async {

    final url      = '$_url/proyectos.php';
    final response = await http.get(url);
    
    List listaProyectosByGroup = json.decode(response.body);

    return listaProyectosByGroup;

  }

}