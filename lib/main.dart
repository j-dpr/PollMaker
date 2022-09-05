import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:survey_app/screens/screens.dart';
import 'package:survey_app/services/services.dart';
import 'package:survey_app/services/surveys_services.dart';

void main() => runApp(AppState());


class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthService()),
      ChangeNotifierProvider(create: (_) => SurveysServices())
    ],
    child: MyApp(),
    );
  }

}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Survey App',
      initialRoute: 'home',
      routes: {
        'login': ( _ ) => LoginScreen(),
        'home':  ( _ ) => HomeScreen(),
        'signup':  ( _ ) => SignUpScreen(),
        'checkAuth':  ( _ ) => CheckAuthScreen(),
        'survey':  ( _ ) => SurveyScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData( 
          backgroundColor: Colors.indigo,
          elevation: 0
          )
      ),
    );
  }
}
