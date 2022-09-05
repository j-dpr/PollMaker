import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/providers/survey_form_provider.dart';
import 'package:survey_app/services/surveys_services.dart';

import '../ui/input_decoration.dart';

class SurveyScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final surveyService = Provider.of<SurveysServices>(context);

    return ChangeNotifierProvider(
      create: (_) => SurveyFormProvider( surveyService.selectedItem),
      child: _productScreenBody(surveyServices: surveyService),
      );
  }
}

class _productScreenBody extends StatelessWidget {
  
  const _productScreenBody({
    Key? key,
    required this.surveyServices,
  }) : super(key: key);

  final SurveysServices surveyServices;

  @override
  Widget build(BuildContext context) {

    final form = Provider.of<SurveyFormProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text('Survey'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            /*IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async{
                //await surveyServices.deleteSurvey(form.survey);
                //Navigator.of(context).pop();
              },
            ),*/
            ConfirmDialog(surveyServices: surveyServices) 
          ],
        ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
          const SizedBox(height: 100),
          _surveyForm(),
          const SizedBox(height: 100)
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton (
        child: Icon(Icons.save),
        onPressed: () async{
          if (!form.isValidForm()) return;
          await surveyServices.saveOrCreateSurvey(form.survey);
        },
      ),
    );
  }
}

class _surveyForm extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final sForm = Provider.of<SurveyFormProvider>(context);
    final item = sForm.survey;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container( 
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 500,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: sForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                initialValue: item.name,
                onChanged: ( value ) => item.name = value,
                validator: (value){
                  if (value == null || value.length < 1)
                  return 'Este campo es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(hintText: 'Mi primer encuesta', labelText: 'Nombre Encuesta'),
              ),
              const SizedBox(height: 10),

              TextFormField(
                initialValue: item.questions.qst.title,
                onChanged: ( value ) => item.questions.qst.title = value,
                validator: (value){
                  if (value == null || value.length < 1)
                  return 'Este campo es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(hintText: 'Escribe aqui la pregunta a contestar', labelText: 'Pregunta'),
              ),
              
              const SizedBox(height: 10),


              TextFormField(
                initialValue: item.desc,
                onChanged: ( value ) => item.desc = value,
                validator: (value){
                  if (value == null || value.length < 1)
                  return 'Este campo es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(hintText: 'Breve encuesta para conocer preferencias en colores', labelText: 'Descripcion Encuesta'),
              ),
                /*SwitchListTile.adaptive(
                  value: true,
                  title: Text('Nombre de campo'), 
                  onChanged: (value ){
                  }
                ), */

                const SizedBox(height: 10),
            ]
            )
          ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration()=> BoxDecoration( 
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0,5),
        blurRadius: 5,
      )
    ]
  );
}

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    required this.surveyServices,
  }) : super(key: key);

  final SurveysServices surveyServices;

  @override
  Widget build(BuildContext context) {

  final sForm = Provider.of<SurveyFormProvider>(context);
  final itemToDelete = sForm.survey;

    return Center(
      child: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Remove"),
              content: const Text(" Do you really want to remove this item?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () async{
                    await surveyServices.deleteSurvey(itemToDelete);
                    Navigator.pop(context, 'Cancel');
                    Navigator.of(context).pop();
                  },
                  child: const Text('Confirm'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                  //onPressed: () {
                    //Navigator.of(ctx).pop();
                    
                  //},
                
              ],
            ),
          );
        },
      ),
      );
  }
    
}


