// ignore_for_file: unnecessary_new
import 'package:flutter/material.dart';


class NotificacionServices {

  static GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message){

    final snackBar = new SnackBar(
      content: Text( message, style: const TextStyle(color: Colors.white, fontSize: 20), )
    );

    messengerKey.currentState!.showSnackBar(snackBar);

  }

}