import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {

  // ignore: unnecessary_new
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email    = '';
  String password = '';

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
