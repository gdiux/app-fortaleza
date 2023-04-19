// ignore_for_file: unused_local_variable, body_might_complete_normally_nullable, non_constant_identifier_names, avoid_print, await_only_futures
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier{

  // ignore: slash_for_doc_comments
  /** ============================================================
   * CREATE WORKER
  =============================================================== */

  final String _baseUrl = 'https://grupofortalezasas.com/api/worker';
  
  final storage = const FlutterSecureStorage();

  Future<String?> createWorker( String name, String cedula, String phone, String email, String password) async {

    final Map<String, dynamic> authData = {
      'name': name,
      'cedula': cedula,
      'phone': phone,
      'email': email,
      'password': password
    };

    final url = Uri.parse(_baseUrl);

    final resp = await http.post(url, body: authData);

    final Map<String, dynamic> decodeResp = json.decode(resp.body) ;

    if (decodeResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodeResp['token']);
      return null;
    }else{
      return decodeResp['msg'];
    }


  }

  // ignore: slash_for_doc_comments
  /** ============================================================
   * LOGIN
  =============================================================== */
  final String _baseUrlLogin = 'https://grupofortalezasas.com/api/login';

  Future<String?> loginWorker( String email, String password) async {

    final Map<String, dynamic> authDataLogin = {
      'email': email,
      'password': password
    };

    final url = Uri.parse(_baseUrlLogin);

    final resp = await http.post(url, body: authDataLogin);

    final Map<String, dynamic> decodeRespLogin = json.decode(resp.body) ;

    if (decodeRespLogin.containsKey('token')) {
      await storage.write(key: 'token', value: decodeRespLogin['token']);
      return null;
    }else{
      return decodeRespLogin['msg'];
    }


  }

  // ignore: slash_for_doc_comments
  /** ============================================================
   * LOGOUT
  =============================================================== */
  Future logout() async {
    // Delete TOKEN
    await storage.delete(key:'token');
    return;
  }

  // ignore: slash_for_doc_comments
  /** ============================================================
   * VERIFICAR TOKEN
  =============================================================== */
  Future<String> readToken() async {
    return await storage.read(key:'token') ?? '';
  }

  

}
