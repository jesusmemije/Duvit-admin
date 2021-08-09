import 'dart:convert';
import 'package:duvit_admin/src/models/staff_model.dart';
import 'package:http/http.dart' as http;

class StaffsProvider {

  final String _url = "http://www.duvitapp.com/WebService/v1";

  Future<List<StaffModel>> cargarStaffs() async {

    final url = '$_url/staffs.php';
    final resp = await http.get( Uri.parse(url) );

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<StaffModel> staffs = [];

    if ( decodedData == null ) return [];

    decodedData.forEach((id, staff) {

      final staffTemp = StaffModel.fromJson(staff);
      staffTemp.id    = id;

      staffs.add( staffTemp );

    });

    return staffs;

  }

  Future<List<StaffModel>> buscarStaff( String query ) async {

    final url = '$_url/staffs.php?query=$query';
    final resp = await http.get( Uri.parse(url) );

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<StaffModel> staffs = [];

    decodedData.forEach((id, staff) {

      final staffTemp = StaffModel.fromJson(staff);
      staffTemp.id    = id;

      staffs.add( staffTemp );

    });

    return staffs;

  }

}