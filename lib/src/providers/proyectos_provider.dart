import 'dart:convert';
import 'package:duvit_admin/src/models/agregar_tarea_model.dart';
import 'package:duvit_admin/src/models/proyecto_model.dart';
import 'package:http/http.dart' as http;

class ProyectosProvider {

  final String _url = "http://www.duvitapp.com/WebService/v1";

  Future<List> getProyectos() async {

    final url      = '$_url/proyectos.php?type=get_projects';
    final response = await http.get(url);
    
    List listaProyectosByGroup = json.decode(response.body);

    return listaProyectosByGroup;

  }

  Future<List<ProyectoModel>> buscarProyectosByStaffSinRelacion( String idstaff ) async {

    final url = '$_url/proyectos.php?type=search_projects&idstaff=$idstaff';
    var response = await http.get(url);

      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<ProyectoModel> listaProyectos = items.map<ProyectoModel>((json) {
        return ProyectoModel.fromJson(json);
      }).toList();

      return listaProyectos;
      
  }

  Future<bool> crearRelacionProyectoStaff( ProyectoToStaffModel proyectoToStaff ) async {

    final url = '$_url/proyectos.php?type=relationship';

    final response = await http.post(url, body: proyectoToStaffModelToJson( proyectoToStaff ) );
    final decodedData = json.decode(response.body);

    if ( decodedData['code'] == "201" ) {
      return true;
    } else {
      return false;
    }

  }  

}