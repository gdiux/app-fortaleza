// To parse this JSON data, do
//
//     final newResponse = newResponseFromJson(jsonString);

import 'dart:convert';

NewResponse newResponseFromJson(String str) => NewResponse.fromJson(json.decode(str));

String newResponseToJson(NewResponse data) => json.encode(data.toJson());

class NewResponse {
    NewResponse({
        required this.worker,
    });

    Worker worker;

    factory NewResponse.fromJson(Map<String, dynamic> json) => NewResponse(
        worker: Worker.fromJson(json["worker"]),
    );

    Map<String, dynamic> toJson() => {
        "worker": worker.toJson(),
    };
}

class Worker {
    Worker({
        this.name,
        this.cedula,
        this.phone,
        this.email,
        this.address,
        this.city,
        this.department,
        this.barrio,
        this.zip,
        this.status,
        this.google,
        this.img,
        this.description,
        this.confirm,
        this.type,
        this.attachments,
        this.skills,
        this.fecha,
        this.wid,
    });

    String? name;
    String? cedula;
    String? phone;
    String? email;
    String? address;
    String? city;
    String? department;
    String? barrio;
    String? zip;
    bool? status;
    bool? google;
    String? img;
    String? description;
    bool? confirm;
    String? type;
    List<Attachment>? attachments;
    List<Skill>? skills;
    DateTime? fecha;
    String? wid;

    factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        name: json["name"],
        cedula: json["cedula"],
        phone: json["phone"],
        email: json["email"],
        address: json["address"],
        city: json["city"],
        department: json["department"],
        barrio: json["barrio"],
        zip: json["zip"],
        status: json["status"],
        google: json["google"],
        img: json["img"],
        description: json["description"],
        confirm: json["confirm"],
        type: json["type"],
        attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
        skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
        fecha: DateTime.parse(json["fecha"]),
        wid: json["wid"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "cedula": cedula,
        "phone": phone,
        "email": email,
        "address": address,
        "city": city,
        "department": department,
        "barrio": barrio,
        "zip": zip,
        "status": status,
        "google": google,
        "img": img,
        "description": description,
        "confirm": confirm,
        "type": type,
        "attachments": List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "skills": List<dynamic>.from(skills!.map((x) => x.toJson())),
        "fecha": fecha?.toIso8601String(),
        "wid": wid,
    };
}

class Attachment {
    Attachment({
        this.attachment,
        this.type,
        this.desc,
        this.status,
        this.approved,
        this.fecha,
    });

    String? attachment;
    String? type;
    String? desc;
    bool? status;
    bool? approved;
    DateTime? fecha;

    factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        attachment: json["attachment"],
        type: json["type"],
        desc: json["desc"],
        status: json["status"],
        approved: json["approved"],
        fecha: DateTime.parse(json["fecha"]),
    );

    Map<String, dynamic> toJson() => {
        "attachment": attachment,
        "type": type,
        "desc": desc,
        "status": status,
        "approved": approved,
        "fecha": fecha?.toIso8601String(),
    };
}

class Skill {
    Skill({
        this.name,
        this.skid,
        this.years,
        this.fecha,
    });

    String? name;
    String? skid;
    int? years;
    DateTime? fecha;

    factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        name: json["name"],
        skid: json["skid"],
        years: json["years"],
        fecha: DateTime.parse(json["fecha"]),
    );

    factory Skill.fromMap(Map<String, dynamic> json) => Skill(
      name: json["name"],
      skid: json["skid"],
      years: json["years"],
      // fecha: DateTime.parse(json["fecha"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "skid": skid,
        "years": years,
        "fecha": fecha?.toIso8601String(),
    };

    // @override
    // String toString() { return '{ name: $name, years: $years }'; }
}
