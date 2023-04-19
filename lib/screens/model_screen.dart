// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fortaleza/services/services.dart';
import 'package:fortaleza/screens/screens.dart';
import 'package:fortaleza/widgets/widgets.dart';


// ignore: unused_element
class ModelScreen extends StatelessWidget{

  const ModelScreen ({ Key? key }): super(key: key);

  @override
  Widget build( BuildContext context) {

    final workerService = Provider.of<WorkerService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if( workerService.isLoading && workerService.token ) return LoadingScreen();

    if (workerService.token == false) return LoginScreen();

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Center(child: Text('Fortaleza Temp Job Plus Est SAS', style: TextStyle(fontSize: 16),)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              child: IconButton(
                  icon: const Icon( Icons.login_outlined ),
                  onPressed: () {
                    authService.logout();
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                ),
              backgroundColor: Colors.indigo,
              
            ),
          )
        ],
      ),
      drawer: const SideMenu(),
      body: const Center(
        child: Text('Hola Mundo')
      ),
      
    );
  }
}