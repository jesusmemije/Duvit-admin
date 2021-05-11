import 'dart:convert';

ProyectoListModel proyectoListModelFromJson(String str) => ProyectoListModel.fromJson(json.decode(str));
String proyectoListModelToJson(ProyectoListModel data) => json.encode(data.toJson());

class ProyectoListModel {
  
    ProyectoListModel({
        this.idPlaneacion,
        this.nombreProyecto,
        this.detalleTarea,
        this.nombreStaff,
    });

    int idPlaneacion;
    String nombreProyecto;
    String detalleTarea;
    String nombreStaff;

    factory ProyectoListModel.fromJson(Map<String, dynamic> json) => ProyectoListModel(
        idPlaneacion   : json["idPlaneacion"],
        nombreProyecto : json["nombreProyecto"],
        detalleTarea   : json["detalleTarea"],
        nombreStaff    : json["nombreStaff"],
    );

    Map<String, dynamic> toJson() => {
        "idPlaneacion"   : idPlaneacion,
        "nombreProyecto" : nombreProyecto,
        "detalleTarea"   : detalleTarea,
        "nombreStaff"    : nombreStaff,
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
