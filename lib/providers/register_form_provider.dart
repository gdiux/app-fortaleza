import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {

  // ignore: unnecessary_new
  GlobalKey<FormState> formKeyRegister = new GlobalKey<FormState>();

  String name    = '';
  String cedula    = '';
  String phone    = '';
  String email    = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidFormRegister(){
 
    return formKeyRegister.currentState?.validate() ?? false;
    
  }

}
