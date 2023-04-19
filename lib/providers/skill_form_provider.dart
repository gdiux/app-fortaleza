import 'package:flutter/material.dart';

class SkillFormProvider extends ChangeNotifier {

  // ignore: unnecessary_new
  GlobalKey<FormState> formKeySkill = new GlobalKey<FormState>();

  String name  = '';
  String years = '0';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidFormSkill(){ 
    return formKeySkill.currentState?.validate() ?? false;    
  }

}
