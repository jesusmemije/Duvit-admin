import 'dart:convert';
import 'package:duvit_admin/src/models/agregar_tarea_model.dart';
import 'package:http/http.dart' as http;

class AgregarTareaProvider {

  final String _url = "http://www.duvitapp.com/WebService/v1";

  Future<List<ProyectoModel>> buscarProyectosByStaff( String idstaff ) async {

    final url = '$_url/agregar-tarea.php?tipo=buscar_proyectos&idstaff=$idstaff';
    var response = await http.get(url);

      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<ProyectoModel> listaProyectos = items.map<ProyectoModel>((json) {
        return ProyectoModel.fromJson(json);
      }).toList();

      return listaProyectos;
      
  }

  Future<List<ActividadModel>> buscarActividadesByIdProyecto( String idproyecto ) async {

    final url = '$_url/agregar-tarea.php?tipo=buscar_actividades&idproyecto=$idproyecto';
    var response = await http.get(url);

      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<ActividadModel> listaActividades = items.map<ActividadModel>((json) {
        return ActividadModel.fromJson(json);
      }).toList();

      return listaActividades;
      
  }

  Future<List<TareaModel>> buscarTareasByIdActividad( String idactividad ) async {

    final url = '$_url/agregar-tarea.php?tipo=buscar_tareas&idactividad=$idactividad';
    var response = await http.get(url);

      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<TareaModel> listaTareas = items.map<TareaModel>((json) {
        return TareaModel.fromJson(json);
      }).toList();

      return listaTareas;
  }

  Future<List<EstatuPlaneacionModel>> buscarEstatus() async {

    final url = '$_url/agregar-tarea.php?tipo=buscar_estatus';
    var response = await http.get(url);

      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<EstatuPlaneacionModel> listaEstatus = items.map<EstatuPlaneacionModel>((json) {
        return EstatuPlaneacionModel.fromJson(json);
      }).toList();

      return listaEstatus;
  }

  Future<List<DependenciaModel>> buscarDependenciasByIdProyecto( String idproyecto ) async {

    final url = '$_url/agregar-tarea.php?tipo=buscar_dependencias&idproyecto=$idproyecto';
    var response = await http.get(url);

      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<DependenciaModel> listaDependencias = items.map<DependenciaModel>((json) {
        return DependenciaModel.fromJson(json);
      }).toList();

      return listaDependencias;
  }

  Future<bool> crearFODPlaneacion( FodPlaneacionModel fodPlaneacion ) async {

    final url = '$_url/agregar-tarea.php';

    final response = await http.post(url, body: fodPlaneacionModelToJson(fodPlaneacion) );
    final decodedData = json.decode(response.body);

    print(decodedData);

    if ( decodedData['code'] == "201" ) {
      return true;
    } else {
      return false;
    }

  }  

}