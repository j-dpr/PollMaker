import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class SurveysServices extends ChangeNotifier{
  final String _baseUrl = 'surveyapp-7742d-default-rtdb.firebaseio.com';
  final List<SurveyClass> surveys = [];
  late SurveyClass selectedItem;

  bool isLoading = true;
  bool isSaving = false;

  SurveysServices(){
    this.loadSurveys();
  }

  Future <List<SurveyClass>> loadSurveys() async{

    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'encuestas.json');
    final resp = await http.get(url);

    final Map<String, dynamic> results = json.decode(resp.body);
    

    results.forEach((key, value) {
      final tempResults = SurveyClass.fromMap(value);
      this.surveys.add(tempResults);
    });

    this.isLoading = false;
    notifyListeners();
    
    return this.surveys;
  }

  Future saveOrCreateSurvey( SurveyClass surv ) async {
    isSaving = true;
    notifyListeners();


    if ( surv.id == null ){
      await this.createProduct(surv);
    }else{
      await this.updateSurvey(surv);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateSurvey ( SurveyClass surv) async {
    final url = Uri.https(_baseUrl, 'encuestas/${ surv.id }.json');
    final resp = await http.put(url, body: surv.toJson());
    final decodedData = resp.body;


    final index = this.surveys.indexWhere((element) => element.id == surv.id );
    this.surveys[index] = surv;
    return surv.id!;
  }

  Future createProduct ( SurveyClass surv) async {

    DateTime now = DateTime.now();
    var questionId = 'q${now.toString()}';
    surv.questions.qst.questionId = questionId;
    surv.optionals.opq.optional = false;
    surv.optionals.opq.questionId = questionId;
    surv.optionals.opq.id = 'o${now.toString()}';
    

    final url = Uri.https(_baseUrl, 'encuestas.json');
    final resp = await http.post(url, body: surv.toJson());
    final decodedData = json.decode(resp.body);

    surv.id = decodedData['name'];
    surv.url =  await shortenUrl(id: decodedData['name']);
  
    this.surveys.add(surv);

    await updateSurvey(surv);
  }

  Future<String?> shortenUrl({required String id }) async {
    try{
      final result = await http.post(
        Uri.parse("https://cleanuri.com/api/v1/shorten"),
        body: {
          'url': 'https://surveyapp-7742d-default-rtdb.firebaseio.com/encuestas/$id.json',
        }
      ); 

      if(result.statusCode == 200) {
        final jsonResult = jsonDecode(result.body);
        return jsonResult['result_url'] ;
      }else{
        return "There is some in shortening the url";
      }
    }catch(e){
      print('Error ${e.toString()}');
    }

    return null;
  }

  Future<String> deleteSurvey ( SurveyClass surv) async {
    final url = Uri.https(_baseUrl, 'encuestas/${ surv.id }.json');
    final resp = await http.delete(url, body: surv.toJson());
    this.surveys.removeWhere(((element) => element.id == surv.id ));

    notifyListeners();  
    return '';
  }
}