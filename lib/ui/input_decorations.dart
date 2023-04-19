import 'package:flutter/material.dart';

class InputDecorations {

  static InputDecoration authInputDecoration({
    required String labelText, 
    required String hintText,
    IconData? prefixIcon
  }){

  return InputDecoration(
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.indigo
      )
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.indigo,
        width: 2
      )
    ),
    labelText: labelText,
    hintText: hintText,
    labelStyle: const TextStyle(
      color: Colors.indigo
    ),
    prefixIcon: prefixIcon != null
      ? Icon( prefixIcon, color: Colors.indigo )
      : null
  );

  }
}
