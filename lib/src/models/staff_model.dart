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
        this.correoCorporativo,
        this.correoPersonal,
        this.celular,
        this.telefonoCelular,
        this.idGenero,
        this.lat,
        this.long,
        this.validarGPS,
        this.idEmpresa,
        this.activo,
    });

    String id                = ''; 
    String nombre            = '';
    String correoCorporativo = '';
    String correoPersonal    = '';
    String celular           = '';
    String telefonoCelular   = '';
    int idGenero             = 0;
    double lat               = 0.0;
    double long              = 0.0;
    int validarGPS           = 0;
    int idEmpresa            = 0;
    int activo               = 0;

    factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
        id                : json["id"],
        nombre            : json["nombre"],
        correoCorporativo : json["correoCorporativo"],
        correoPersonal    : json["correoPersonal"],
        celular           : json["celular"],
        telefonoCelular   : json["telefonoCelular"],
        idGenero          : json["idGenero"],
        lat               : json["lat"],
        long              : json["long"],
        validarGPS        : json["validarGPS"],
        idEmpresa         : json["idEmpresa"],
        activo            : json["activo"],
    );

    Map<String, dynamic> toJson() => {
        "id"                : id,
        "nombre"            : nombre,
        "correoCorporativo" : correoCorporativo,
        "correoPersonal"    : correoPersonal,
        "celular"           : celular,
        "telefonoCelular"   : telefonoCelular,
        "idGenero"          : idGenero,
        "lat"               : lat,
        "long"              : long,
        "validarGPS"        : validarGPS,
        "idEmpresa"         : idEmpresa,
        "activo"            : activo,
    };
}
