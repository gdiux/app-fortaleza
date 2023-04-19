// ignore_for_file: file_names, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fortaleza/services/services.dart';
import 'package:fortaleza/providers/login_form_provider.dart';
import 'package:fortaleza/widgets/widgets.dart';
import 'package:fortaleza/ui/input_decorations.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatelessWidget{

  @override
  Widget build( BuildContext context){
    return Scaffold(
      // ignore: 
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox( height: 10 ),
                    Text('Ingresar', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey),),
                    SizedBox( height: 30 ),
                    
                    ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),                                  

                  ],
                )
              ),

              SizedBox(height: 50),

              // BOTON DE REGISTRARME
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())
                ),
                child: Text('Crear cuenta nueva', style: TextStyle(fontSize: 20, color: Colors.black54),)
              ),

              
              SizedBox(height: 50), 
            ],
          ),
        )
      )
    );
  
  }

}


class _LoginForm extends StatelessWidget{

  const _LoginForm ({ Key? key }): super(key: key);

  @override
  Widget build( BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    // ignore: avoid_unnecessary_containers
    return Container(
      child: Form(

        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [

            // CORREO
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'ejemplo@gmail.com',
                labelText: 'Correo Electrónico',
                prefixIcon: Icons.alternate_email_sharp
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value){
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                  ? null 
                  : 'El correo electrónico no es correcto';

              }

            ),

            SizedBox(height: 20), 

            // CONTRASEÑA
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                hintText: '******',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value){
                
                if (value != null && value.length >= 6 ) return null; 

                return 'La contraseña debe de ser de 6 caracteres';

              }
            ),
            SizedBox(height: 20),  

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.indigo,
              // ignore: sort_child_properties_last
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                child: Text(
                  loginForm.isLoading 
                  ? 'Cargando'
                  :'Ingresar', 
                  style: TextStyle(color: Colors.white),
                )
              ),
              onPressed: loginForm.isLoading? null : () async {

                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);

                if (!loginForm.isValidForm()) return;

                loginForm.isLoading = true;

                // HACER LA PETICION DE CREAR USUARIO
                final String? errorMsg = await authService.loginWorker(loginForm.email, loginForm.password);

                if (errorMsg == null) {                  
                  Navigator.pushReplacementNamed(context, 'home');                
                }else{

                  loginForm.isLoading = false;
                  NotificacionServices.showSnackbar(errorMsg);

                }                

              }
            )

          ],
        )
        ),
    );
  }
}