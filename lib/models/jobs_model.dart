// To parse this JSON data, do
//
//     final newResponseJobs = newResponseJobsFromJson(jsonString);

import 'dart:convert';

import 'package:fortaleza/models/models.dart';

NewResponseJobs newResponseJobsFromJson(String str) => NewResponseJobs.fromJson(json.decode(str));

String newResponseJobsToJson(NewResponseJobs data) => json.encode(data.toJson());

class NewResponseJobs {
    NewResponseJobs({
        required this.job,
    });

    Job job;

    factory NewResponseJobs.fromJson(Map<String, dynamic> json) => NewResponseJobs(
        job: Job.fromJson(json["job"]),
    );

    Map<String, dynamic> toJson() => {
        "job": job.toJson(),
    };
}

class Job {
    Job({
        this.control,
        this.name,
        this.description,
        this.sueldo,
        this.bussiness,
        this.worker,
        this.status,
        this.type,
        this.fechain,
        this.fechaout,
        this.fecha,
        this.jid,
    });

    int? control;
    String? name;
    String? description;
    int? sueldo;
    Bussiness? bussiness;
    Worker? worker;
    bool? status;
    String? type;
    DateTime? fechain;
    DateTime? fechaout;
    DateTime? fecha;
    String? jid;

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        control: json["control"],
        name: json["name"],
        description: json["description"],
        sueldo: json["sueldo"],
        bussiness: Bussiness.fromJson(json["bussiness"]),
        status: json["status"],
        type: json["type"],
        fechain: DateTime.parse(json["fechain"]),
        fecha: DateTime.parse(json["fecha"]),
        jid: json["jid"],
    );

    Map<String, dynamic> toJson() => {
        "control": control,
        "name": name,
        "description": description,
        "sueldo": sueldo,
        "bussiness": bussiness,
        "worker": worker,
        "status": status,
        "type": type,
        "fechain": fechain?.toIso8601String(),
        "fechaout": fechaout?.toIso8601String(),
        "fecha": fecha?.toIso8601String(),
        "jid": jid,
    };
}
