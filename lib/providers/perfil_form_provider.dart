import 'package:flutter/material.dart';

//  ==============================================================
//  FORMULARIO DE PERFIL
// =============================================================== 

class PerfilFormProvider extends ChangeNotifier {

  // ignore: unnecessary_new
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String name    = '';
  String cedula = '';
  String phone = '';
  String address = '';
  String city = '';
  String department = '';
  String barrio = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm(){
 
    return formKey.currentState?.validate() ?? false;
    
  }

}

//  ==============================================================
//  FORMULARIO DE ACTUALIZAR PASSWORD
// =============================================================== 
class PasswordFormProvider extends ChangeNotifier {

  // ignore: unnecessary_new
  GlobalKey<FormState> formKeyPassword = new GlobalKey<FormState>();

  String password = '';
  String repassword = '';

  bool _isLoadingPass = false;
  bool get isLoadingPass => _isLoadingPass;
  
  set isLoadingPass( bool value ) {
    _isLoadingPass = value;
    notifyListeners();
  }

  bool isValidFormPass(){
 
    return formKeyPassword.currentState?.validate() ?? false;
    
  }

}
