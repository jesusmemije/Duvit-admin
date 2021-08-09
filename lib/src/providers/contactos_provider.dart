import 'dart:convert';
import 'package:duvit_admin/src/models/contacto_model.dart';
import 'package:http/http.dart' as http;

class ContactosProvider {

  final String _url = "http://www.duvitapp.com/WebService/v1";

  Future<List<ContactoModel>> buscarContactos( String query ) async {

    final url = '$_url/contactos.php?query=$query';
    final resp = await http.get( Uri.parse(url) );

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ContactoModel> contactos = [];
    //final List<ContactoModel> contactos = new List<ContactoModel>.empty();
    //final List<ContactoModel> contactos = List<ContactoModel>.empty(growable: true);

    decodedData.forEach((id, contacto) {

      final contactoTemp = ContactoModel.fromJson(contacto);
      contactoTemp.id    = id;

      contactos.add( contactoTemp );

    });

    return contactos;

  }

}