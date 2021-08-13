
import 'dart:convert';

class ProyectoModel {

    ProyectoModel({
        this.id,
        this.idCotizacion,
        this.tiempoEstimado,
        this.tiempoReal,
        this.fechaEntrega,
        this.fechaEntregaReal,
        this.descripcion,
        this.responsable,
        this.fechaContratacion,
        this.fechaInicio,
        this.statusProyecto,
        this.tipoProyecto,
        this.archivoPropuestaAceptada,
        this.prioridad,
        this.idPropuestaDisenio,
        this.codigoProyecto,
        this.nombreProyecto,
        this.idCliente,
    });

    int id;
    int idCotizacion;
    String tiempoEstimado;
    String tiempoReal;
    String fechaEntrega;
    String fechaEntregaReal;
    String descripcion;
    int responsable;
    String fechaContratacion;
    String fechaInicio;
    int statusProyecto;
    int tipoProyecto;
    String archivoPropuestaAceptada;
    int prioridad;
    int idPropuestaDisenio;
    String codigoProyecto;
    String nombreProyecto;
    int idCliente;

    factory ProyectoModel.fromJson(Map<String, dynamic> json) => ProyectoModel(
        id                       : json["id"],
        idCotizacion             : json["idCotizacion"],
        tiempoEstimado           : json["tiempoEstimado"],
        tiempoReal               : json["tiempoReal"],
        fechaEntrega             : json["fechaEntrega"],
        fechaEntregaReal         : json["fechaEntregaReal"],
        descripcion              : json["descripcion"],
        responsable              : json["responsable"],
        fechaContratacion        : json["fechaContratacion"],
        fechaInicio              : json["fechaInicio"],
        statusProyecto           : json["statusProyecto"],
        tipoProyecto             : json["tipoProyecto"],
        archivoPropuestaAceptada : json["archivoPropuestaAceptada"],
        prioridad                : json["prioridad"],
        idPropuestaDisenio       : json["idPropuestaDiseño"],
        codigoProyecto           : json["codigoProyecto"],
        nombreProyecto           : json["nombreProyecto"],
        idCliente                : json["idCliente"],
    );

    Map<String, dynamic> toJson() => {
        "id"                       : id,
        "idCotizacion"             : idCotizacion,
        "tiempoEstimado"           : tiempoEstimado,
        "tiempoReal"               : tiempoReal,
        "fechaEntrega"             : fechaEntrega,
        "fechaEntregaReal"         : fechaEntregaReal,
        "descripcion"              : descripcion,
        "responsable"              : responsable,
        "fechaContratacion"        : fechaContratacion,
        "fechaInicio"              : fechaInicio,
        "statusProyecto"           : statusProyecto,
        "tipoProyecto"             : tipoProyecto,
        "archivoPropuestaAceptada" : archivoPropuestaAceptada,
        "prioridad"                : prioridad,
        "idPropuestaDiseño"        : idPropuestaDisenio,
        "codigoProyecto"           : codigoProyecto,
        "nombreProyecto"           : nombreProyecto,
        "idCliente"                : idCliente,
    };
}

class ActividadModel {

    ActividadModel({
        this.id,
        this.nombreActividad,
        this.idTipoProyecto,
    });

    int id;
    String nombreActividad;
    int idTipoProyecto;

    factory ActividadModel.fromJson(Map<String, dynamic> json) => ActividadModel(
        id              : json["id"],
        nombreActividad : json["nombreActividad"],
        idTipoProyecto  : json["idTipoProyecto"],
    );

    Map<String, dynamic> toJson() => {
        "id"              : id,
        "nombreActividad" : nombreActividad,
        "idTipoProyecto"  : idTipoProyecto,
    };
}

class TareaModel {

    TareaModel({
        this.id,
        this.nombreTarea,
        this.idActividad,
    });

    int id;
    String nombreTarea;
    int idActividad;

    factory TareaModel.fromJson(Map<String, dynamic> json) => TareaModel(
        id          : json["id"],
        nombreTarea : json["nombreTarea"],
        idActividad : json["idActividad"],
    );

    Map<String, dynamic> toJson() => {
        "id"          : id,
        "nombreTarea" : nombreTarea,
        "idActividad" : idActividad,
    };
}

class EstatuPlaneacionModel {

    EstatuPlaneacionModel({
        this.id,
        this.estatusPlaneacion,
    });

    int id;
    String estatusPlaneacion;

    factory EstatuPlaneacionModel.fromJson(Map<String, dynamic> json) => EstatuPlaneacionModel(
        id                : json["id"],
        estatusPlaneacion : json["estatusPlaneacion"],
    );

    Map<String, dynamic> toJson() => {
        "id"                : id,
        "estatusPlaneacion" : estatusPlaneacion,
    };
}

class DependenciaModel {
  
    DependenciaModel({
        this.idPlaneacion,
        this.detalleTarea,
    });

    int idPlaneacion;
    String detalleTarea;

    factory DependenciaModel.fromJson(Map<String, dynamic> json) => DependenciaModel(
        idPlaneacion : json["idPlaneacion"],
        detalleTarea : json["detalleTarea"],
    );

    Map<String, dynamic> toJson() => {
        "idPlaneacion" : idPlaneacion,
        "detalleTarea" : detalleTarea,
    };
}

FodPlaneacionModel fodPlaneacionModelFromJson(String str) => FodPlaneacionModel.fromJson(json.decode(str));
String fodPlaneacionModelToJson(FodPlaneacionModel data) => json.encode(data.toJson());

class FodPlaneacionModel {

    FodPlaneacionModel({
        this.idPlaneacion,
        this.idEmpresa,
        this.idResponsable,
        this.idProyecto,
        this.dias = 0,
        this.horas = 0,
        this.minutos = 0,
        this.fechaInicio,
        this.statusPlaneacion,
        this.fechaFin,
        this.idDependencia,
        this.idTarea,
        this.detalleTarea,
        this.requerimientos,
        this.fechaLimite,
    });

    int idPlaneacion = 0;
    int idEmpresa = 0;
    int idResponsable = 0;
    int idProyecto = 0;
    int dias;
    int horas;
    int minutos;
    String fechaInicio = "";
    int statusPlaneacion = 0;
    String fechaFin = "";
    int idDependencia = 0;
    int idTarea = 0;
    String detalleTarea = "";
    String requerimientos = "";
    String fechaLimite = "";

    factory FodPlaneacionModel.fromJson(Map<String, dynamic> json) => FodPlaneacionModel(
        idPlaneacion     : json["idPlaneacion"],
        idEmpresa        : json["idEmpresa"],
        idResponsable    : json["idResponsable"],
        idProyecto       : json["idProyecto"],
        dias             : json["dias"],
        horas            : json["horas"],
        minutos          : json["minutos"],
        fechaInicio      : json["fechaInicio"],
        statusPlaneacion : json["statusPlaneacion"],
        fechaFin         : json["fechaFin"],
        idDependencia    : json["idDependencia"],
        idTarea          : json["idTarea"],
        detalleTarea     : json["detalleTarea"],
        requerimientos   : json["requerimientos"],
        fechaLimite      : json["fechaLimite"],
    );

    Map<String, dynamic> toJson() => {
        "idPlaneacion"     : idPlaneacion,
        "idEmpresa"        : idEmpresa,
        "idResponsable"    : idResponsable,
        "idProyecto"       : idProyecto,
        "dias"             : dias,
        "horas"            : horas,
        "minutos"          : minutos,
        "fechaInicio"      : fechaInicio,
        "statusPlaneacion" : statusPlaneacion,
        "fechaFin"         : fechaFin,
        "idDependencia"    : idDependencia,
        "idTarea"          : idTarea,
        "detalleTarea"     : detalleTarea,
        "requerimientos"   : requerimientos,
        "fechaLimite"      : fechaLimite,
    };
}


