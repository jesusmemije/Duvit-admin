import 'dart:convert';
import 'package:duvit_admin/src/models/agregar_tarea_model.dart';
import 'package:duvit_admin/src/models/proyecto_model.dart';
import 'package:http/http.dart' as http;

class ProyectosProvider {

  final String _url = "http://www.duvitapp.com/WebService/v1";

  Future<List<ProyectoModel>> getProyectos() async {

    final url      = '$_url/proyectos.php?type=get_projects';
    final response = await http.get( Uri.parse(url) );

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<ProyectoModel> listaProyectos = items.map<ProyectoModel>((json) {
      return ProyectoModel.fromJson(json);
    }).toList();

    return listaProyectos;

  }

  Future<List<ProyectoListModel>> getTareasByProyecto( String idProject ) async {

    final url      = '$_url/proyectos.php?type=get_tareas_by_project&id_project=' + idProject;
    final response = await http.get( Uri.parse(url) );

    final Map<String, dynamic> decodedData = json.decode(response.body);
    final List<ProyectoListModel> tareas = [];
    if ( decodedData == null ) return [];
    decodedData.forEach((id, tarea) {
      final staffTemp = ProyectoListModel.fromJson(tarea);
      staffTemp.id = id;
      tareas.add( staffTemp );
    });

    return tareas;

  }

  Future<List<ProyectoModel>> buscarProyectosByStaffSinRelacion( String idstaff ) async {

    final url = '$_url/proyectos.php?type=search_projects&idstaff=$idstaff';
    var response = await http.get( Uri.parse(url) );

      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<ProyectoModel> listaProyectos = items.map<ProyectoModel>((json) {
        return ProyectoModel.fromJson(json);
      }).toList();

      return listaProyectos;
      
  }

  Future<bool> crearRelacionProyectoStaff( ProyectoToStaffModel proyectoToStaff ) async {

    final url = '$_url/proyectos.php?type=relationship';

    final response = await http.post( Uri.parse(url), body: proyectoToStaffModelToJson( proyectoToStaff ) );
    final decodedData = json.decode(response.body);

    if ( decodedData['code'] == "201" ) {
      return true;
    } else {
      return false;
    }

  }  

}