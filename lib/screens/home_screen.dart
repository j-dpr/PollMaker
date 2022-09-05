import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/models/survey.dart';
import 'package:survey_app/screens/screens.dart';
import 'package:survey_app/services/services.dart';
import 'package:survey_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final surveyServices = Provider.of<SurveysServices>(context, listen: true);

    if( surveyServices.isLoading ) return LoadingScreen();

    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          leading: IconButton(
            icon: Icon(Icons.login_outlined),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ),
        body: ListView.builder(
          itemCount: surveyServices.surveys.length,
          itemBuilder: (BuildContext context, index) => GestureDetector(
            onTap: () {
              surveyServices.selectedItem = surveyServices.surveys[index].copy();
              Navigator.pushNamed(context, 'survey');
            },
            onPanUpdate: (details){
              if (details.delta.dx > 0) {
                print(' Right Swipe');
              }
  
              // Swiping in left direction.
              if (details.delta.dx < 0) {
                print(' Left Swip ');
              }
            },
            child: SurveyCard(
              survey: surveyServices.surveys[index], 
            )
          )
        ),
        floatingActionButton: FloatingActionButton (
          child: Icon(Icons.add),
          onPressed: (){
            // ignore: unnecessary_new
            surveyServices.selectedItem = new SurveyClass(
              desc: '', 
              name: '', 
              answers: Answers(answ: Answ(questionId: '', id: '')), 
              optionals: Optionals(opq: Opq(id: '', optional: false, questionId: '')), 
              questions: Questions(qst: Qst(questionId: '', title: '')),
              url: '',
              );
              Navigator.pushNamed(context, 'survey');
          },
        ),
    );
  }
}
