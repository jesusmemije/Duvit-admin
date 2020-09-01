// To parse this JSON data, do
//
//     final staffModel = staffModelFromJson(jsonString);

import 'dart:convert';

StaffModel staffModelFromJson(String str) => StaffModel.fromJson(json.decode(str));

String staffModelToJson(StaffModel data) => json.encode(data.toJson());

class StaffModel {
  
    StaffModel({
        this.id,
        this.nombre,
        this.correo,
        this.idGenero,
        this.lat,
        this.long,
        this.validarGPS,
        this.idEmpresa,
        this.activo,
    });

    String id       = ''; 
    String nombre   = '';
    String correo   = '';
    int idGenero    = 0;
    double lat      = 0.0;
    double long     = 0.0;
    int validarGPS  = 0;
    int idEmpresa   = 0;
    int activo      = 0;

    factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
        id         : json["id"],
        nombre     : json["nombre"],
        correo     : json["correo"],
        idGenero   : json["idGenero"],
        lat        : json["lat"],
        long       : json["long"],
        validarGPS : json["validarGPS"],
        idEmpresa  : json["idEmpresa"],
        activo     : json["activo"],
    );

    Map<String, dynamic> toJson() => {
        "id"         : id,
        "nombre"     : nombre,
        "correo"     : correo,
        "idGenero"   : idGenero,
        "lat"        : lat,
        "long"       : long,
        "validarGPS" : validarGPS,
        "idEmpresa"  : idEmpresa,
        "activo"     : activo,
    };
}
