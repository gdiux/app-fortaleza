// ignore_for_file: sort_child_properties_last, unused_element

import 'package:flutter/material.dart';
import 'package:fortaleza/services/services.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget{

  const SideMenu ({ Key? key }): super(key: key);

  @override
  Widget build( BuildContext context) {

    final workerService = Provider.of<WorkerService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          _DrawerHeader(workerService: workerService),

          ListTile(
            iconColor: Colors.indigo,
            textColor: Colors.indigo,
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),
          
          ListTile(
            iconColor: Colors.indigo,
            textColor: Colors.indigo,
            leading: const Icon(Icons.people_alt_outlined),
            title: const Text('Editar Perfil'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'editar');
            },
          ),

          ListTile(
            iconColor: Colors.indigo,
            textColor: Colors.indigo,
            leading: const Icon(Icons.login_outlined),
            title: const Text('Salir'),
            onTap: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),

        ],
      ),
    );
  }
}

// ================================================================================
// DRAWER HEADER
// ================================================================================

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    super.key,
    required this.workerService,
  });

  final WorkerService workerService;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(

        children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://grupofortalezasas.com/api/uploads/worker/${workerService.worker.img}'),
            ),
            const SizedBox(height: 10),  
            Text(workerService.worker.name!, style: const TextStyle(fontSize: 20, color: Colors.white), ),
            
        ],

      ),
      decoration: const BoxDecoration(
        color: Colors.indigo
      ),
      
    );
  }
}