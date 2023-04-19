// To parse this JSON data, do
//
//     final newResponseEntrevista = newResponseEntrevistaFromJson(jsonString);
import 'package:fortaleza/models/worker_model.dart';
import 'dart:convert';

NewResponseEntrevista newResponseEntrevistaFromJson(String str) => NewResponseEntrevista.fromJson(json.decode(str));

String newResponseEntrevistaToJson(NewResponseEntrevista data) => json.encode(data.toJson());

class NewResponseEntrevista {
    NewResponseEntrevista({
        required this.entrevista,
    });

    Entrevista entrevista;

    factory NewResponseEntrevista.fromJson(Map<String, dynamic> json) => NewResponseEntrevista(
        entrevista: Entrevista.fromJson(json["entrevista"]),
    );

    Map<String, dynamic> toJson() => {
        "entrevista": entrevista.toJson(),
    };
}

class Entrevista {
    Entrevista({
        this.control,
        this.enlace,
        this.worker,
        this.confirm,
        this.status,
        this.cancel,
        this.day,
        this.fecha,
        this.eid,
        this.id,
    });

    int? control;
    String? enlace;
    Worker? worker;
    bool? confirm;
    bool? status;
    bool? cancel;
    DateTime? day;
    DateTime? fecha;
    String? eid;
    String? id;

    factory Entrevista.fromJson(Map<String, dynamic> json) => Entrevista(
        control: json["control"],
        enlace: json["enlace"],
        // worker: json["worker"],
        confirm: json["confirm"],
        status: json["status"],
        cancel: json["cancel"],
        day: DateTime.parse(json["day"]),
        fecha: DateTime.parse(json["fecha"]),
        eid: json["eid"],
        id: json["_id"],
    );

    factory Entrevista.fromMap(Map<String, dynamic> json) => Entrevista(
      control: json["control"],
      enlace: json["enlace"],
      // worker: json["worker"],
      confirm: json["confirm"],
      status: json["status"],
      cancel: json["cancel"],
      day: DateTime.parse(json["day"]),
      fecha: DateTime.parse(json["fecha"]),
      eid: json["eid"],
      id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "control": control,
        "enlace": enlace,
        "worker": worker,
        "confirm": confirm,
        "status": status,
        "cancel": cancel,
        "day": day!.toIso8601String(),
        "fecha": fecha!.toIso8601String(),
        "eid": eid,
        "_id": id,
    };
}
