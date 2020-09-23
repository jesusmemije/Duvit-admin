import 'dart:convert';

ContactoModel contactoModelFromJson(String str) => ContactoModel.fromJson(json.decode(str));

String contactoModelToJson(ContactoModel data) => json.encode(data.toJson());

class ContactoModel {
  
    ContactoModel({
        this.id,
        this.nombreCompleto,
        this.celular,
        this.telefonoCelular,
        this.telefonoCasa,
        this.tipo,
    });

    String id              = '';
    String nombreCompleto  = '';
    String celular         = '';
    String telefonoCelular = '';
    String telefonoCasa    = '';
    String tipo            = '';

    factory ContactoModel.fromJson(Map<String, dynamic> json) => ContactoModel(
        id              : json["id"],
        nombreCompleto  : json["nombreCompleto"],
        celular         : json["celular"],
        telefonoCelular : json["telefonoCelular"],
        telefonoCasa    : json["telefonoCasa"],
        tipo            : json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id"              : id,
        "nombreCompleto"  : nombreCompleto,
        "celular"         : celular,
        "telefonoCelular" : telefonoCelular,
        "telefonoCasa"    : telefonoCasa,
        "tipo"            : tipo,
    };
}
