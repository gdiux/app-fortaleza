import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:fortaleza/models/models.dart';

class JobsService extends ChangeNotifier{

  final storage = const FlutterSecureStorage();

  final String _baseUrl = 'https://grupofortalezasas.com/api';

  late List<Job> jobs = [];

  Future<List<Job>>  loadJobsWorker(String wid) async {

    final token = await storage.read(key:'token') ?? '';

    final url = Uri.parse('$_baseUrl/jobs/worker/$wid');

    final  resp = await http.get(url, headers: {
      'x-token': token
    });

    final Map<String, dynamic> respJobs = json.decode( resp.body );

    final List<dynamic> jobsDB = respJobs['jobs'];

    jobs = [];

    for (var job in jobsDB) { 

      final jobTemp = Job.fromJson(job);
      jobs.add(jobTemp);

    }

    return jobs;

  }

  // FIN DE LA CLASE
}