import 'dart:convert';

LlamadaPendienteModel llamadaPendienteModelFromJson(String str) => LlamadaPendienteModel.fromJson(json.decode(str));

String llamadaPendienteModelToJson(LlamadaPendienteModel data) => json.encode(data.toJson());

class LlamadaPendienteModel {

    LlamadaPendienteModel({
        this.id,
        this.nombre,
        this.celular,
        this.status,
        this.fecha,
        this.tipo,
    });

    String id      = '';
    String nombre  = '';
    String celular = '';
    String status  = '';
    String fecha   = '';
    String tipo    = '';

    factory LlamadaPendienteModel.fromJson(Map<String, dynamic> json) => LlamadaPendienteModel(
        id      : json["id"],
        nombre  : json["nombre"],
        celular : json["celular"],
        status  : json["status"],
        fecha   : json["fecha"],
        tipo    : json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id"      : id,
        "nombre"  : nombre,
        "celular" : celular,
        "status"  : status,
        "fecha"   : fecha,
        "tipo"    : tipo,
    };
}
