// To parse this JSON data, do
//
//     final newResponseBussiness = newResponseBussinessFromJson(jsonString);

import 'dart:convert';

NewResponseBussiness newResponseBussinessFromJson(String str) => NewResponseBussiness.fromJson(json.decode(str));

String newResponseBussinessToJson(NewResponseBussiness data) => json.encode(data.toJson());

class NewResponseBussiness {
    NewResponseBussiness({
        required this.bussiness,
    });

    Bussiness bussiness;

    factory NewResponseBussiness.fromJson(Map<String, dynamic> json) => NewResponseBussiness(
        bussiness: Bussiness.fromJson(json["bussiness"]),
    );

    Map<String, dynamic> toJson() => {
        "bussiness": bussiness.toJson(),
    };
}

class Bussiness {
    Bussiness({
        this.name,
        this.nit,
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
        this.bid,
        this.bussiness,
        this.fecha,
    });

    String? name;
    String? nit;
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
    String? bid;
    bool? bussiness;
    DateTime? fecha;

    factory Bussiness.fromJson(Map<String, dynamic> json) => Bussiness(
        name: json["name"],
        nit: json["nit"],
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
        bid: json["bid"],
        bussiness: json["bussiness"],
        // fecha: DateTime.parse(json["fecha"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "nit": nit,
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
        "bid": bid,
        "bussiness": bussiness,
        "fecha": fecha?.toIso8601String(),
    };
}
