import 'package:flutter/material.dart';
import 'package:survey_app/providers/login_form_provider.dart';
import 'package:survey_app/services/auth_services.dart';
import 'package:survey_app/ui/input_decoration.dart';
import '../widgets/widgets.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: AuthBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox( height: 250),

                CardContainer( 
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text('Sign', style: Theme.of(context).textTheme.headline4),
                      const SizedBox(height: 30),

                      ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: _LoginForm()
                      )
                    ]
                    ),
                ),

                SizedBox(height: 50),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, 'login'), 
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                  ),
                  child: const Text('Ya tienes una cuenta?', style: TextStyle(fontSize: 18, color: Colors.black87))
                  ),
                SizedBox(height: 50),
              ],
            )
          ),
        ),
      );
  }
}

class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(hintText: 'john.doe@gmail.com', labelText: 'E-mail'),
                onChanged: (value) => loginForm.email = value,
                validator: ( value ) {

                  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  = new RegExp(pattern);
                  
                  return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado corresponde a un correo';

                },
              ),

              SizedBox(height: 30),


              TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(hintText: '****', labelText: 'Password'),
                onChanged: (value) => loginForm.password = value,
                validator: ( value ) {

                  return ( value != null && value.length >= 6 ) 
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';                                    
                  
              },
              ),

              SizedBox(height: 30),

              MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: loginForm.isLoading ? null : () async {
                
                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);

                
                if( !loginForm.isValidForm() ) return;

                loginForm.isLoading = true;
                final String? messageResponse = await authService.createUser(loginForm.email, loginForm.password);
                if (messageResponse  == null ){
                  Navigator.pushReplacementNamed(context, 'home');
                }else{
                  print(messageResponse);
                  loginForm.isLoading = false;
                }
                
                

              },
              child: Container(
                padding: const EdgeInsets.symmetric( horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading 
                    ? 'Espere'
                    : 'Ingresar',
                  style: const TextStyle( color: Colors.white ),
                )
              )
            )
              
          ],
        ),
      ),
    );
  }
}