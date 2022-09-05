import 'package:flutter/material.dart';
import 'package:survey_app/models/survey.dart';


class SurveyCard extends StatelessWidget {

  final SurveyClass survey;

  const SurveyCard({Key? key, required this.survey}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container( 
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        width: double.infinity,
        height: 70,
        decoration: _itemStyle(),
        child: Stack(
          children: [
            _surveyItem(
              name: survey.name
            )
          ]
          ),
      ),
    );
  }

  BoxDecoration _itemStyle() => BoxDecoration( 
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0,7)
      )
    ]
  );
}

class _surveyItem extends StatelessWidget {

  final String name;
  
  const _surveyItem({required this.name});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only( left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
          name,
          style: TextStyle(fontSize: 20, color: Colors.indigo ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          )
        ]
      ),
    );
  }}