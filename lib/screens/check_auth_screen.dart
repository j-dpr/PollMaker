import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/screens/screens.dart';
import 'package:survey_app/services/auth_services.dart';

class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){

            if( !snapshot.hasData) 
            return Text('');
            

            if (snapshot.data == ''){
              Future.microtask(() {
                //Navigator.of(context).pushReplacementNamed('login');
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_, __, ___) => LoginScreen(),
                  transitionDuration: const Duration(seconds: 0)
                  )
                );
              });
            }else{
              Future.microtask(() {
                //Navigator.of(context).pushReplacementNamed('login');
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_, __, ___) => HomeScreen(),
                  transitionDuration: const Duration(seconds: 0)
                  )
                );
              });
            }

            
            
            return Container();
            
          },
        )
      ), 
    );
  }

}