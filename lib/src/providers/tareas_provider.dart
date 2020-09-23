import 'dart:convert';
import 'package:duvit_admin/src/models/tarea_model.dart';
import 'package:http/http.dart' as http;

class TareasProvider {

  final String _url = "http://www.duvitapp.com/WebService/v1";

  Future<List<TareaModel>> buscarTareasByIdStatus( String idstaff, int status ) async {

    final url = '$_url/tareas.php?idstaff=$idstaff&status=$status';
    final resp = await http.get( url );
  
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<TareaModel> staffs = new List();

    decodedData.forEach((id, staff) {

      final staffTemp        = TareaModel.fromJson(staff);
      staffTemp.idPlaneacion = id;

      staffs.add( staffTemp );

    });

    return staffs;

  }

}