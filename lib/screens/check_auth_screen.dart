// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fortaleza/screens/screens.dart';
import 'package:fortaleza/services/services.dart';


class CheckAuthScreen extends StatelessWidget{


  @override
  Widget build( BuildContext context) {

    final authService = Provider.of<AuthService>( context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){

              if (!snapshot.hasData) return const Text('Cargando');

              if ( snapshot.data == '' ) {                
                Future.microtask(() {
                  Navigator.pushReplacement(context, PageRouteBuilder(
                    pageBuilder: ( _, __, ___) => LoginScreen(),
                    transitionDuration: const Duration(seconds: 0)
                    )
                  );               
                });
              }else{
                Future.microtask(() {
                  Navigator.pushReplacement(context, PageRouteBuilder(
                    pageBuilder: ( _, __, ___) => HomeScreen(),
                    transitionDuration: const Duration(seconds: 0)
                    )
                  );               
                });
              }


              return Container();

            },
          ),
      ),
    );
  }
}