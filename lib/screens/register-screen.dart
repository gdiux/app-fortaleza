// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable, use_build_context_synchronously
import 'package:flutter/material.dart';

import 'package:fortaleza/services/auth_services.dart';

import 'package:provider/provider.dart';
import 'package:fortaleza/providers/register_form_provider.dart';

import 'package:fortaleza/widgets/widgets.dart';
import 'package:fortaleza/ui/input_decorations.dart';

// ignore: use_key_in_widget_constructors
class RegisterScreen extends StatelessWidget{

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
                    Text('Crear Cuenta', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey),),
                    SizedBox( height: 30 ),
                    
                    ChangeNotifierProvider(
                      create: ( _ ) => RegisterFormProvider(),
                      child: _RegsiterForm(),
                    ),                                  

                  ],
                )
              ),

              SizedBox(height: 50),

              // BOTON DE LOGIN
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())
                ),
                child: Text('Ya tienes cuenta?', style: TextStyle(fontSize: 20, color: Colors.black54),)
              ),

              
              SizedBox(height: 50), 
            ],
          ),
        )
      )
    );
  
  }

}

class _RegsiterForm extends StatelessWidget{

  const _RegsiterForm ({ Key? key }): super(key: key);

  @override
  Widget build( BuildContext context) {

    final registerForm = Provider.of<RegisterFormProvider>(context);

    // ignore: avoid_unnecessary_containers
    return Container(
      child: Form(

        key: registerForm.formKeyRegister,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [

            // NOMBRES
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Tu nombre completo aquí',
                labelText: 'Nombres y Apellidos',
                prefixIcon: Icons.person_2_outlined
              ),
              onChanged: (value) => registerForm.name = value,
              validator: (value){
                
                if (value != null && value.length >= 6 ) return null; 

                return 'Debes de escribir tu nombre completo';

              }

            ),

            SizedBox(height: 20), 
            // CORREO
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                hintText: '00000000',
                labelText: 'Cedula de ciudadania',
                prefixIcon: Icons.person_pin_outlined
              ),
              onChanged: (value) => registerForm.cedula = value,
              validator: (value){
                
                if (value != null && value.length >= 8 ) return null; 

                return 'Debes de agregar tu cedula';

              }

            ),

            SizedBox(height: 20), 
            // TELEFONO
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.phone,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Tu telefono',
                labelText: 'Telefono',
                prefixIcon: Icons.phone_android_outlined
              ),
              onChanged: (value) => registerForm.phone = value,
              validator: (value){
                
                if (value != null && value.length >= 6 ) return null; 

                return 'Debes de escribir tu numero telefonico';

              }

            ),

            SizedBox(height: 20), 
            // CORREO
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'ejemplo@gmail.com',
                labelText: 'Correo Electrónico',
                prefixIcon: Icons.alternate_email_sharp
              ),
              onChanged: (value) => registerForm.email = value,
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
              onChanged: (value) => registerForm.password = value,
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
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                child: Text(
                  registerForm.isLoading 
                  ? 'Cargando'
                  :'Registrarme', 
                  style: TextStyle(color: Colors.white),
                )
              ),
              onPressed: registerForm.isLoading? null : () async {

                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);

                if (!registerForm.isValidFormRegister()) return;

                registerForm.isLoading = true;

                // HACER LA PETICION DE CREAR USUARIO
                final String? errorMsg = await authService.createWorker(registerForm.name, registerForm.cedula, registerForm.phone, registerForm.email, registerForm.password);

                if (errorMsg == null) {                  
                  Navigator.pushReplacementNamed(context, 'home');                
                }else{
                  registerForm.isLoading = false;
                  // ignore: avoid_print
                  print(errorMsg);

                }


              }
            )

          ],
        )
        ),
    );
  }
}