// ignore_for_file: unused_local_variable, body_might_complete_normally_nullable, non_constant_identifier_names, avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class EntrevistasService extends ChangeNotifier{

  final storage = const FlutterSecureStorage();

  final String _baseUrl = 'https://grupofortalezasas.com/api';

  late List<dynamic> entrevistas = [];

  Future loadEntrevistas(String wid) async {

    final token = await storage.read(key:'token') ?? '';

    final url = Uri.parse('$_baseUrl/entrevistas/worker/$wid');

    final  resp = await http.get(url, headers: {
      'x-token': token
    });

    final Map<String, dynamic> respEntrevista = json.decode( resp.body );

    // List? entre = respEntrevista['entrevistas'];

    // entre?.forEach( (value) {

    //   final temp = Entrevista.fromMap(value);
    //   entrevistas.addAll({temp});

    // });

    entrevistas = respEntrevista['entrevistas'] as List<dynamic>;

    return entrevistas;

  }

}