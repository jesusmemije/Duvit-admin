import 'dart:convert';

ProyectoListModel proyectoListModelFromJson(String str) => ProyectoListModel.fromJson(json.decode(str));
String proyectoListModelToJson(ProyectoListModel data) => json.encode(data.toJson());

class ProyectoListModel {
  
    ProyectoListModel({
        this.id,
        this.idPlaneacion,
        this.nombreProyecto,
        this.nombreTarea,
        this.requerimientos,
        this.estatusPlaneacion,
        this.fechaInicio,
        this.fechaFin,
        this.detalleTarea,
        this.nombreStaff,
    });

    String id = "";
    int idPlaneacion = 0;
    String nombreProyecto = "";
    String nombreTarea = "";
    String requerimientos = "";
    String estatusPlaneacion = "";
    String fechaInicio = "";
    String fechaFin = "";
    String detalleTarea = "";
    String nombreStaff = "";

    factory ProyectoListModel.fromJson(Map<String, dynamic> json) => ProyectoListModel(
        id                : json["id"],
        idPlaneacion      : json["idPlaneacion"],
        nombreProyecto    : json["nombreProyecto"],
        nombreTarea       : json["nombreTarea"],
        requerimientos    : json["requerimientos"],
        estatusPlaneacion : json["estatusPlaneacion"],
        fechaInicio       : json["fechaInicio"],
        fechaFin          : json["fechaFin"],
        detalleTarea      : json["detalleTarea"],
        nombreStaff       : json["nombreStaff"],
    );

    Map<String, dynamic> toJson() => {
        "id"                : id,
        "idPlaneacion"      : idPlaneacion,
        "nombreProyecto"    : nombreProyecto,
        "nombreTarea"       : nombreTarea,
        "requerimientos"    : requerimientos,
        "estatusPlaneacion" : estatusPlaneacion,
        "fechaInicio"       : fechaInicio,
        "fechaFin"          : fechaFin,
        "detalleTarea"      : detalleTarea,
        "nombreStaff"       : nombreStaff,
    };
}

ProyectoToStaffModel proyectoToStaffModelFromJson(String str) => ProyectoToStaffModel.fromJson(json.decode(str));
String proyectoToStaffModelToJson(ProyectoToStaffModel data) => json.encode(data.toJson());

class ProyectoToStaffModel {

    ProyectoToStaffModel({
      this.idStaff    = 0,
      this.idProyecto = 0,
    });

    int idStaff;
    int idProyecto;

    factory ProyectoToStaffModel.fromJson(Map<String, dynamic> json) => ProyectoToStaffModel(
      idStaff    : json["idStaff"],
      idProyecto : json["idProyecto"]
    );

    Map<String, dynamic> toJson() => {
      "idStaff"    : idStaff,
      "idProyecto" : idProyecto,
    };
}
