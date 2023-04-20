// ignore_for_file: unused_local_variable, body_might_complete_normally_nullable, non_constant_identifier_names, avoid_print, slash_for_doc_comments, unused_import
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:fortaleza/models/models.dart';

class WorkerService extends ChangeNotifier{

  final String _baseUrl = 'https://grupofortalezasas.com/api';
  final String _localUrl = 'http://192.168.0.150:3000/api';
  /** ============================================================
   * RENOVAR TOKEN /renew/worker
  =============================================================== */
  late Worker worker;
  bool isLoading = true;
  bool token = true;
  bool isSaving = false;

  WorkerService() {
    renewTokenWorker();
  }

  Future renewTokenWorker() async {

    isLoading = true;
    notifyListeners();

    final token = await storage.read(key:'token') ?? '';

    final url = Uri.parse('$_baseUrl/login/renew/worker');

    final resp = await http.get(url, headers: {
      'x-token': token
    });

    final dynamic respToken = json.decode(resp.body);

    if (respToken['ok'] == false) {      
      await storage.delete(key:'token');
      return false;      
    }
    
    this.token = true;

    worker = Worker.fromJson(respToken['worker']);
    
    var skillWorker = [];

    skillWorker = respToken['worker']['skills'];

    if (skillWorker.isNotEmpty) {
      worker.skills = [];
      for (var skill in skillWorker) {        
        final tempSkill = Skill.fromMap( skill );
        tempSkill.skid = skill['_id'];
        worker.skills?.add(tempSkill);
      }
    }

    isLoading = false;
    notifyListeners();

    return worker;

  }

  

  /** ============================================================
   * ADD SKILL OF WORKER
  =============================================================== */
  Future addSkill(String name, int years) async {

    final Map<String, dynamic> formData = {
      'name': name,
      'years': years
    };

    final url = Uri.parse('$_baseUrl/worker/add/skill/${worker.wid}');

    final tokenWorker = await storage.read(key:'token') ?? '';

    // ignore: unnecessary_cast
    final resp = await http.post(url, body: {"skill": json.encode(formData)}, headers: {
      'x-token': tokenWorker
    });

    final respUpdate = json.decode(resp.body);

    if (respUpdate['ok'] == true ) {

      worker = Worker.fromJson(respUpdate['worker']);

      var skillWorker = [];

      skillWorker = respUpdate['worker']['skills'];

      if (skillWorker.isNotEmpty) {
        worker.skills = [];
        for (var skill in skillWorker) {        
          final tempSkill = Skill.fromMap( skill );
          tempSkill.skid = skill['_id'];
          worker.skills?.add(tempSkill);
        }
      }

      notifyListeners();
      return 'Se ha agregado la habilidad exitosamente!';

    }else{
      return respUpdate['msg'];
    }


  }

  /** ============================================================
   * DELETE SKILL OF WORKER
  =============================================================== */
  Future dellSkill(String skill) async {
    
    final url = Uri.parse('$_baseUrl/worker/del/$skill/${worker.wid}');

    final tokenWorker = await storage.read(key:'token') ?? '';

    // ignore: unnecessary_cast
    final resp = await http.delete(url, body: {}, headers: {
      'x-token': tokenWorker
    });

    final respUpdate = json.decode(resp.body);

    if (respUpdate['ok'] == true ) {

      worker = Worker.fromJson(respUpdate['worker']);

      var skillWorker = [];

      skillWorker = respUpdate['worker']['skills'];

      if (skillWorker.isNotEmpty) {
        worker.skills = [];
        for (var skill in skillWorker) {        
          final tempSkill = Skill.fromMap( skill );
          tempSkill.skid = skill['_id'];
          worker.skills?.add(tempSkill);
        }
      }

      notifyListeners();
      return 'Se ha eliminado la habilidad exitosamente!';

    }else{
      return respUpdate['msg'];
    }

  }

  /** ============================================================
   * LOAD WORKER
  =============================================================== */
  final storage = const FlutterSecureStorage();

  Future<String?> loadWorker(String id) async {

    final url = Uri.parse('$_baseUrl/worker/$id');

    final resp = await http.get(url);

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    // if (decodeResp.containsKey('token')) {
    //   await storage.write(key: 'token', value: decodeResp['token']);
    //   return null;
    // }else{
    //   return decodeResp['msg'];
    // }


  }

  /** ============================================================
   * ACTUALIZAR PERFIL
  =============================================================== */
  Future<String?> updateWorker( String name, String cedula, String phone, String address, String city, String department, String barrio) async {

    final Map<String, dynamic> perfilData = {
      'name': name,
      'cedula': cedula,
      'phone': phone,
      'address': address,
      'city': city,
      'department': department,
      'barrio': barrio,
    };
    notifyListeners();

    final tokenWorker = await storage.read(key:'token') ?? '';

    final url = Uri.parse('$_baseUrl/worker/${worker.wid}');

    final resp = await http.put(url, body: perfilData, headers: {
      'x-token': tokenWorker
    });

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp['ok'] == false) {
      return decodeResp['msg'];
    }

    worker = Worker.fromJson(decodeResp['worker']);

    notifyListeners();
    
    return 'Se ha actualizado el perfil exitosamente!';


  }

  /** ============================================================
   * CAMBIAR CONTRASEÑA
  =============================================================== */
  Future<String?> updatePassword( String password, String repassword) async {

    if (password != repassword) {
      return 'Las contraseñas no son iguales';
    }

    final Map<String, dynamic> passwordData = {
      'password': password,
    };
    notifyListeners();

    final tokenWorker = await storage.read(key:'token') ?? '';

    final url = Uri.parse('$_baseUrl/worker/${worker.wid}');

    final resp = await http.put(url, body: passwordData, headers: {
      'x-token': tokenWorker
    });

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp['ok'] == false) {
      return decodeResp['msg'];
    }

    notifyListeners();
    
    return 'Se ha actualizado la contraseña exitosamente!';


  }

  /** ============================================================
   * UPDATE IMAGE PERFIL WORKER
  =============================================================== */
  Future<String?> updateImageWorker(String path) async {

    final newPictureFile = File.fromUri( Uri(path: path) );

    final tokenWorker = await storage.read(key:'token') ?? '';
    Map<String, String> headers = { "x-token": tokenWorker};

    notifyListeners();

    final url = Uri.parse('$_baseUrl/uploads/worker/app');

    final imageUploadRequest = http.MultipartRequest('PUT', url );
    imageUploadRequest.headers.addAll(headers);

    final file = await http.MultipartFile.fromPath('file', newPictureFile.path );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    print(json.decode(resp.body));

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp['ok'] == false) {
      return decodeResp['msg'];
    }

    worker = Worker.fromJson(decodeResp['worker']);

    notifyListeners();

    return 'ok';

  }

}