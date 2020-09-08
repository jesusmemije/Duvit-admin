import 'dart:convert';

TareaModel tareasModelFromJson(String str) => TareaModel.fromJson(json.decode(str));

String tareasModelToJson(TareaModel data) => json.encode(data.toJson());

class TareaModel {

    TareaModel({
        this.idPlaneacion,
        this.tarea,
        this.actividad,
        this.detalle,
        this.idEstatusTarea,
        this.idProyecto,
        this.proyecto,
    });

    String idPlaneacion = '';
    String tarea        = '';
    String actividad    = '';
    String detalle      = '';
    int idEstatusTarea  = 0;
    int idProyecto      = 0;
    String proyecto     = '';

    factory TareaModel.fromJson(Map<String, dynamic> json) => TareaModel(
        idPlaneacion   : json["idPlaneacion"],
        tarea          : json["tarea"],
        actividad      : json["actividad"],
        detalle        : json["detalle"],
        idEstatusTarea : json["idEstatusTarea"],
        idProyecto     : json["idProyecto"],
        proyecto       : json["proyecto"],
    );

    Map<String, dynamic> toJson() => {
        "idPlaneacion"   : idPlaneacion,
        "tarea"          : tarea,
        "actividad"      : actividad,
        "detalle"        : detalle,
        "idEstatusTarea" : idEstatusTarea,
        "idProyecto"     : idProyecto,
        "proyecto"       : proyecto,
    };
}
