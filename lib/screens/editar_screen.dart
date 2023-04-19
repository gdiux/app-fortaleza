// ignore_for_file: sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fortaleza/services/services.dart';
import 'package:fortaleza/screens/screens.dart';
import 'package:fortaleza/widgets/widgets.dart';
import 'package:fortaleza/providers/perfil_form_provider.dart';
import 'package:fortaleza/ui/input_decorations.dart';


// ignore: unused_element
class EditarPerfilScreen extends StatelessWidget{

  const EditarPerfilScreen ({ Key? key }): super(key: key);

  @override
  Widget build( BuildContext context) {

    final workerService = Provider.of<WorkerService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if( workerService.isLoading && workerService.token ) return LoadingScreen();

    if (workerService.token == false) return LoginScreen();

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Center(child: Text('Fortaleza Temp Job Plus Est SAS', style: TextStyle(fontSize: 16),)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              child: IconButton(
                  icon: const Icon( Icons.login_outlined ),
                  onPressed: () {
                    authService.logout();
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                ),
              backgroundColor: Colors.indigo,
              
            ),
          )
        ],
      ),
      drawer: const SideMenu(),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox( height: 50 ),              
              ChangeNotifierProvider(
                create: ( _ ) => PerfilFormProvider(),
                child: _UpdateImg(workerService: workerService)
              ),
              SizedBox( height: 20 ),              
              ChangeNotifierProvider(
                create: ( _ ) => PerfilFormProvider(),
                child: CardContainer(
                  child: _EditarPerfil(workerService: workerService)
                ),
              ),
              SizedBox( height: 20 ),              
              ChangeNotifierProvider(
                create: ( _ ) => PasswordFormProvider(),
                child: CardContainer(
                  child: _PasswordUpdate(workerService: workerService)
                ),
              ),
              SizedBox( height: 50 ),  
            ],
          ),
        )
      ),
      
    );
  }
}

// ============================================================
// EDITAR FOTO
// ============================================================
class _UpdateImg extends StatelessWidget{

  const _UpdateImg 
  ({ Key? key ,
    required this.workerService,
  }): super(key: key);

  final WorkerService workerService;

  @override
  Widget build( BuildContext context) {

  final workerService = Provider.of<WorkerService>(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
                    
          SizedBox(height: 16),
          

          // TYPE: FOTO
          Container(
            height: 180.0,
            child: Stack(
              children: [
          
                // IMG
                CircleAvatar(
                  radius: 80,
                  backgroundImage: (workerService.worker.img! != null) ? NetworkImage('https://grupofortalezasas.com/api/uploads/worker/${workerService.worker.img}') : NetworkImage('https://grupofortalezasas.com/api/uploads/worker/no-image'),
                ),
          
                // CAMARA
                Positioned(
                    top: 115,
                    right: 1,
                    child: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      radius: 30,
                      child: IconButton(
                        onPressed: () async {

                          showModalBottomSheet(
                          context: context,
                          builder: ( BuildContext context ) {
                            return Container(
                              child: Column(
                                children: [
                                  SizedBox(height: 50),
                                  Text('Actualizar foto de perfil', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),),
                                  SizedBox(height: 50),

                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.indigo,
                                              radius: 40,
                                              child: IconButton(onPressed: () async {
                                                
                                                // ignore: unnecessary_new
                                                final picker = new ImagePicker();
                                                final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
                                                
                                                if( pickedFile == null ) {
                                                  print('No seleccionó nada');
                                                  return;
                                                }

                                                                    
                                                workerService.updateImageWorker(pickedFile.path);

                                              }, icon: Icon(Icons.camera_alt_outlined, size: 35, color: Colors.white )),
                                            ),
                                            SizedBox(height: 10),
                                            Text('Camara')
                                          ],
                                        ),
                                  
                                        Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.indigo,
                                              radius: 40,
                                              child: IconButton(onPressed: () async {
                                                
                                                // ignore: unnecessary_new
                                                final picker = new ImagePicker();
                                                final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
                                                
                                                if( pickedFile == null ) {
                                                  print('No seleccionó nada');
                                                  return;
                                                }

                                                                    
                                                workerService.updateImageWorker(pickedFile.path);

                                              }, icon: Icon(Icons.image_outlined , size: 35, color: Colors.white )),
                                            ),
                                            SizedBox(height: 10),
                                            Text('Galeria')
                                          ],
                                        ),
                                      ],
                                    ),
                                  )

                                  ],
                                ),
                              );
                            },
                          );
                          
                          
                          
                          
                    
                        }, 
                        icon: Icon( Icons.camera_alt_outlined, size: 30, color: Colors.white ),
                      ),
                    )
                  )
          
              ]
            ),
          ),
          // NOMBRE
          SizedBox(height: 16),
          
        ],
      ),
    );
  
  }
}


// ===================================================================================
// EDITAR PERFIL
// ===================================================================================
// ignore: unused_element
class _EditarPerfil extends StatelessWidget{

  const _EditarPerfil 
  ({ Key? key ,
    required this.workerService,
  }): super(key: key);

  final WorkerService workerService;

  @override
  Widget build( BuildContext context) {

  final perfilForm = Provider.of<PerfilFormProvider>(context);
  
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),

      child: Column(
        children: [

          Text('Editar mi perfil', style: TextStyle(fontSize: 20, color: Colors.grey),),
          SizedBox( height: 20 ), 
          Form(
            key: perfilForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [

                // NOMBRES
                TextFormField(
                  autocorrect: false,
                  initialValue: workerService.worker.name,
                  keyboardType: TextInputType.name,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: 'Pedro Miguel Perez Perez',
                    labelText: 'Nombres y Apellidos',
                    prefixIcon: Icons.person_2_outlined
                  ),
                  onChanged: (value) => perfilForm.name = value,
                  validator: (value){

                    perfilForm.name = value!;

                    if (value != null && value.length >= 6 ) return null;
                    return 'Debes de escribir tu nombre completo';

                  }

                ),

                SizedBox( height: 20 ),

                // CEDULA
                TextFormField(
                  autocorrect: false,
                  initialValue: workerService.worker.cedula,
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: '0000000000',
                    labelText: 'Cedula',
                    prefixIcon: Icons.person_pin_outlined
                  ),
                  onChanged: (value) => perfilForm.cedula = value,
                  validator: (value){

                    perfilForm.cedula = value!;
                    if (value != null && value.length >= 8 ) return null; 
                    return 'La cedula es obligatoria';

                  }

                ),

                SizedBox( height: 20 ),

                // TELEFONO
                TextFormField(
                  autocorrect: false,
                  initialValue: workerService.worker.phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: '3160000000',
                    labelText: 'Telefono',
                    prefixIcon: Icons.phone_android_outlined
                  ),
                  onChanged: (value) => perfilForm.phone = value,
                  validator: (value){
                    
                    perfilForm.phone = value!;
                    if (value != null && value.length >= 6 ) return null; 
                    return 'El telefono es obligatorio';

                  }

                ),

                SizedBox( height: 20 ),

                // CIUDAD
                TextFormField(
                  autocorrect: false,
                  initialValue: workerService.worker.city,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: 'Bucaramanga',
                    labelText: 'Ciudad',
                    prefixIcon: Icons.location_city_outlined
                  ),
                  onChanged: (value) => perfilForm.city = value,
                  validator: (value){

                    perfilForm.city = value!;
                    if (value != null && value.length >= 4 ) return null; 
                    return 'Campo Obligatorio';

                  }

                ),

                SizedBox( height: 20 ),

                // DEPARTAMENTO
                TextFormField(
                  autocorrect: false,
                  initialValue: workerService.worker.department,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: 'Santander',
                    labelText: 'Departamento',
                    prefixIcon: Icons.map_outlined
                  ),
                  onChanged: (value) => perfilForm.department = value,
                  validator: (value){

                    perfilForm.department = value!;
                    
                    if (value != null && value.length >= 4 ) return null; 
                    return 'Campo Obligatorio';

                  }

                ),

                SizedBox( height: 20 ),

                // DIRECCION
                TextFormField(
                  autocorrect: false,
                  initialValue: workerService.worker.address,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: 'Sector',
                    labelText: 'Dirección',
                    prefixIcon: Icons.maps_home_work
                  ),
                  onChanged: (value) => perfilForm.address = value,
                  validator: (value){
                    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp  = RegExp(pattern);

                    perfilForm.address = value!;
                    if (value != null && value.length >= 4 ) return null; 
                    return 'Campo Obligatorio';
                  }

                ),

                SizedBox( height: 20 ),

                // BARRIO
                TextFormField(
                  autocorrect: false,
                  initialValue: workerService.worker.barrio,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: 'Calle, Sector',
                    labelText: 'Barrio',
                    prefixIcon: Icons.gps_fixed_outlined
                  ),
                  onChanged: (value) => perfilForm.barrio = value,
                  validator: (value){
                    
                    perfilForm.barrio = value!;
                    if (value != null && value.length >= 4 ) return null; 
                    return 'Campo Obligatorio';

                  }

                ),

                // BTN DE ACTUALIZAR
                SizedBox(height: 20),  

                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.indigo,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Center(
                      child: Text(
                        perfilForm.isLoading 
                        ? 'Cargando'
                        :'Actualizar', 
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ),
                  onPressed: perfilForm.isLoading? null : () async {

                    FocusScope.of(context).unfocus();
                    final authService = Provider.of<AuthService>(context, listen: false);

                    if (!perfilForm.isValidForm()) return;

                    perfilForm.isLoading = true;
                   
                    // HACER LA PETICION DE ACTUALIZAR USUARIO
                    final String? resp = await workerService.updateWorker(perfilForm.name, perfilForm.cedula, perfilForm.phone, perfilForm.address, perfilForm.city, perfilForm.department, perfilForm.barrio );

                    perfilForm.isLoading = false;
                    NotificacionServices.showSnackbar(resp!);

                  }
                )                 

              ],
            ),
          )

        ],
      ),

    );
  }
}

// ===================================================================================
// CAMBIAR CONTRASEÑA
// ===================================================================================
// ignore: unused_element
class _PasswordUpdate extends StatelessWidget{

  const _PasswordUpdate 
  ({ 
  Key? key,
  required this.workerService,
  }): super(key: key);

  final WorkerService workerService;

  @override
  Widget build( BuildContext context) {

    final passwordForm = Provider.of<PasswordFormProvider>(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Cambiar Contraseña', style: TextStyle(fontSize: 20, color: Colors.grey),),
          SizedBox( height: 20 ), 

          Form(
            key: passwordForm.formKeyPassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(

              children: [

                // Password
                TextFormField(
                  autocorrect: false,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: 'Escribe tu contraseña',
                    labelText: 'Contraseña',
                    prefixIcon: Icons.lock_outline_sharp
                  ),
                  onChanged: (value) => passwordForm.password = value,
                  validator: (value){

                    if (value != null && value.length >= 6 ) return null;
                    return 'La contraseña debe ser mayor a 6 caracteres';

                  }

                ),

                SizedBox( height: 20 ),

                // REPassword
                TextFormField(
                  autocorrect: false,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: 'Confirma tu contraseña',
                    labelText: 'Repetir Contraseña',
                    prefixIcon: Icons.lock_outline_sharp
                  ),
                  onChanged: (value) => passwordForm.repassword = value,
                  validator: (value){

                    if (value != null && value.length >= 6   ){ 
                      
                      if (passwordForm.repassword != passwordForm.password) {
                        return 'La contraseña deben ser iguales';
                      }

                      return null; 
                      
                    }else{
                      return 'La contraseña debe ser mayor a 6 caracteres';
                    }

                  }

                ),

                SizedBox( height: 20 ),

                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.indigo,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Center(
                      child: Text(
                        passwordForm.isLoadingPass 
                        ? 'Cargando'
                        :'Actualizar', 
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ),
                  onPressed: passwordForm.isLoadingPass? null : () async {

                    FocusScope.of(context).unfocus();
                    final authService = Provider.of<AuthService>(context, listen: false);

                    if (!passwordForm.isValidFormPass()) return;

                    passwordForm.isLoadingPass = true;
                   
                    // HACER LA PETICION DE ACTUALIZAR USUARIO
                    final String? resp = await workerService.updatePassword(passwordForm.password, passwordForm.repassword);

                    passwordForm.isLoadingPass = false;
                    NotificacionServices.showSnackbar(resp!);

                  }
                )

              ],

            ),
          )

        ],
      ),

    );
  }
}