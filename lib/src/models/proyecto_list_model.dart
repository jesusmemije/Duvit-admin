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
