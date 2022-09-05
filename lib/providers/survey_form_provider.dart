import 'package:flutter/material.dart';
import 'package:survey_app/models/survey.dart';

class SurveyFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SurveyClass survey;
  SurveyFormProvider( this.survey );

  updateSwitch(bool value){
    print(value);
    notifyListeners();
  }

  bool isValidForm (){
    print(survey.name);
    print(survey.desc);
    return formKey.currentState?.validate() ?? false; 
  }

}