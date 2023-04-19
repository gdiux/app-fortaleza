// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fortaleza/screens/screens.dart';
import 'package:fortaleza/services/services.dart';


// RUN
void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService() ),
        ChangeNotifierProvider(create: ( _ ) => WorkerService() ),
        ChangeNotifierProvider(create: ( _ ) => EntrevistasService() ),
        ChangeNotifierProvider(create: ( _ ) => JobsService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fortaleza Temp Job Plus Est SAS',
      initialRoute: 'cheking',
      routes: {
        'loading':  ( _ ) => LoadingScreen(),
        'cheking':  ( _ ) => CheckAuthScreen(),
        'home':     ( _ ) => HomeScreen(),
        'login':    ( _ ) => LoginScreen(),
        'register': ( _ ) => RegisterScreen(),
        'editar':   ( _ ) => EditarPerfilScreen(),
      },
      scaffoldMessengerKey: NotificacionServices.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[50]
      ),
    );

  }

}