// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, use_key_in_widget_constructors, unused_element, unused_local_variable, deprecated_member_use, unnecessary_string_escapes, use_build_context_synchronously, file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

import 'package:fortaleza/models/models.dart';
import 'package:fortaleza/screens/screens.dart';
import 'package:fortaleza/providers/skill_form_provider.dart';
import 'package:fortaleza/ui/input_decorations.dart';


import 'package:fortaleza/services/services.dart';
import 'package:fortaleza/widgets/widgets.dart';

class HomeScreen extends StatelessWidget{

  @override
  Widget build( BuildContext context)  {

    final workerService = Provider.of<WorkerService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if( workerService.isLoading && workerService.token ) return LoadingScreen();

    if (workerService.token == false) return LoginScreen();
    
    final entrevistasService = Provider.of<EntrevistasService>(context, listen: false);
    final entrevistas = entrevistasService.loadEntrevistas(workerService.worker.wid!);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Center(child: Text('Fortaleza Temp Job Plus Est SAS', style: TextStyle(fontSize: 16),)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              child: IconButton(
                  icon: Icon( Icons.login_outlined ),
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
      drawer: SideMenu(),

      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(     
          child: Column(            
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(height: 50),              
              CardContainer(child: ProfileWorker()),
              SizedBox(height: 20),              
              CardContainer(child: _SkillsWorker()),            
              SizedBox(height: 20),           
              CardContainer(child: _EntrevistasWorker()),            
              SizedBox(height: 20),           
              CardContainer(child: _AttachmentsWorker()),            
              SizedBox(height: 20),           
              CardContainer(child: _JobsWorker()),            
              SizedBox(height: 20),           
         
            ],
          )
        ),
      ),
    );
  }

}

// ============================================================
// PERFIL DEL USUARIO
// ============================================================
class ProfileWorker extends StatelessWidget{

  @override
  Widget build( BuildContext context) {

  final workerService = Provider.of<WorkerService>(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          
          // TYPE: ASPIRANTE O TRABAJADOE
          Container(            
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: workerService.worker.type == 'Aspirante'? Colors.amber[300]: Colors.indigo ,
              ),
              child: Text( workerService.worker.type!,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),

          SizedBox(height: 16),

          // TYPE: FOTO
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://grupofortalezasas.com/api/uploads/worker/${workerService.worker.img}'),
          ),
          // NOMBRE
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            child: Text(
              workerService.worker.name!,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          // CEDULA
          SizedBox(height: 8),
          Text(
            'CC: ${workerService.worker.cedula}',
            style: TextStyle(fontSize: 16),
          ),
          // TELEFONO
          SizedBox(height: 8),
          Text(
            'Telefono: ${workerService.worker.phone}',
            style: TextStyle(fontSize: 16),
          ),
          // EMAIL
          SizedBox(height: 8),
          Text(
            'Email: ${workerService.worker.phone}',
            style: TextStyle(fontSize: 16),
          ),
          // DIRECCIOn
          SizedBox(height: 8),
          Text(
            'Dirección: ${workerService.worker.address}',
            style: TextStyle(fontSize: 16),
          ),

          SizedBox(height: 10),
          TextButton( 
            child: Text('Actualizar Perfil', style: TextStyle(color: Colors.indigo),),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'editar');
            },
          )
        ],
      ),
    );
  
  }
}

// ============================================================
// SKILLS
// ============================================================
class _SkillsWorker extends StatelessWidget{

  const _SkillsWorker ({ Key? key}) : super(key: key);

  @override
  Widget build( BuildContext context) {

    final workerService = Provider.of<WorkerService>(context);

    final List<Skill> skills =  workerService.worker.skills!;
    
    return Container(
      width: double.infinity,

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text('Habilidades', style: TextStyle(fontSize: 20, color: Colors.grey),),
              IconButton(
                color: Colors.indigo,
                icon: Icon( Icons.add ),
                onPressed: () {

                  showModalBottomSheet(
                  context: context,
                  builder: ( BuildContext context ) {
                    return Container(
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          Text('Agrega una experiencia o habilidad', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),),
                          SizedBox(height: 20),
                          ChangeNotifierProvider(
                            create: ( _ ) => SkillFormProvider(),
                            child: _AddSkillForm(),
                            ),  
                          ],
                        ),
                      );
                    },
                  );

                },
              ),
            ],
          ),

          // LISTA DE SKILLS O HABILIDADES
          Container(
            height: 300.0,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 30.0,
                  horizontalMargin: 16.0,
                  dataRowHeight: 48.0,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text('',),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text('',),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text('',),
                      ),
                    ),
                  ],

                  // RESULTADOS 
                  rows: skills.map((skill) => 
                    DataRow(cells: [
                          DataCell( IconButton(
                            onPressed: ()async {
                              
                              final delSkill = await workerService.dellSkill(skill.skid!);

                              NotificacionServices.showSnackbar(delSkill);

                            }, 
                            color: Colors.red,
                            icon: Icon(Icons.close)
                            ) 
                          ),
                          DataCell(
                            Container( width: 150.0, padding: EdgeInsets.symmetric(vertical: 1.0), child: Text( skill.name!, ))
                          ),
                          DataCell(Chip(
                                    backgroundColor: Colors.indigo,
                                    label: Text('${skill.years.toString()} años', style: TextStyle(color: Colors.white),),
                                  )
                          )
                        ]))
                    .toList(),
                ),
              ),
            ),
          )

        ],
      ),

    );
  }

}

// ============================================================
// FORM ADD HABILIDAD
// ============================================================
class _AddSkillForm extends StatelessWidget{

  const _AddSkillForm ({ Key? key }): super(key: key);

  @override
  Widget build( BuildContext context) {

    final skillForm = Provider.of<SkillFormProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Form(
          key: skillForm.formKeySkill,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
    
              SizedBox(height: 20),
              // HABILIDAD
              TextFormField(
                autocorrect: false,
                initialValue: skillForm.name,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Experiencia',
                  labelText: 'Experiencia ó Habilidad',
                  prefixIcon: Icons.post_add_rounded
                ),
                onChanged: (value) => skillForm.name = value,
                validator: (value){
                  
                  if (value!.isNotEmpty) { return null; } else { return 'Este campo es obligatorio'; }
    
                }
    
              ),
              
              SizedBox(height: 20),
    
              // AÑOS
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.number,
                initialValue: skillForm.years.toString(),
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Años',
                  labelText: 'Años de experiencia',
                  prefixIcon: Icons.calendar_month_outlined
                ),
                onChanged: (value) => skillForm.years = value,
                validator: (value){
                  
                  // if (value!.isNotEmpty) { return null;}else{ return 'Este campo es obligatorio';}

                String pattern = '^[0-9]';
                RegExp regExp  = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                  ? null 
                  : 'Solo Numeros';   
                }
    
              ),

               
              SizedBox(height: 20),
              
              // BTN GUARDAR HABILIDAD
              MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.indigo,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                child: Text(
                  skillForm.isLoading 
                  ? 'Guardando'
                  :'Guardar', 
                  style: TextStyle(color: Colors.white),
                  )
                ),
                onPressed: skillForm.isLoading? null : () async {      

                  FocusScope.of(context).unfocus();
                  final workerService = Provider.of<WorkerService>(context, listen: false);

                  if (!skillForm.isValidFormSkill()) return;

                  skillForm.isLoading = true;

                  final addSkillWorker = await workerService.addSkill(skillForm.name, int.parse(skillForm.years));

                  skillForm.isLoading = false;
                  NotificacionServices.showSnackbar(addSkillWorker);

                }
              ),

              SizedBox(height: 50),
            ],
          )
        ),
      ),
    );
  }
}

// ============================================================
// ENTREVISTAS
// ============================================================
class _EntrevistasWorker extends StatelessWidget{

  const _EntrevistasWorker ({ Key? key}): super(key: key);
    
  @override
  Widget build( BuildContext context) {        
    
    return Container(
      width: double.infinity,

      child: Column(

        // ignore: prefer_const_literals_to_create_immutables
        children: [
          
          // TITULO          
          Text('Entrevistas', style: TextStyle(fontSize: 20, color: Colors.grey),),

          // Lista de entrevistas
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 16.0,
                    horizontalMargin: 16.0,
                    dataRowHeight: 48.0,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text('Fecha',),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text('Enlace',),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text('Confirmada',),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text('Estatus',),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text('',),
                        ),
                      ),
                    ], 
                  rows: _createRowsEntrevistas(Provider.of<EntrevistasService>(context).entrevistas)),
                ),
              ),
            ],
          )
        
        ],

      ),

    );
  }
}

// ============================================================
// TABLA DE HABILIDADES
// ============================================================
List<DataRow> _createRowsEntrevistas( List<dynamic> entrevistas ) {

  // print(entrevistas);

  // ignore: unnecessary_cast
  final List<Entrevista> entrevistasList = [];

  // ignore: avoid_function_literals_in_foreach_calls
  entrevistas.forEach( (value) {

    final temp = Entrevista.fromMap(value);
    entrevistasList.add(temp);

  });
  
  // ignore: prefer_const_literals_to_create_immutables
  return entrevistasList.map((entrevista) => DataRow(cells: [
          
          

          DataCell( Text( '${entrevista.day!.day}/${entrevista.day!.month}/${entrevista.day!.year}' )),
          DataCell(Text( entrevista.enlace! )),
          DataCell(
            Chip(
                    backgroundColor: ( entrevista.confirm == true )? Colors.green: Colors.amber ,
                    label: Text( ( entrevista.confirm == true )? 'Confirmada': 'Espera' , style: TextStyle(color: Colors.white),),
                  )
          ),
          DataCell(Chip(
                    backgroundColor: ( entrevista.status == true )? Colors.green: Colors.amber ,
                    label: Text( ( entrevista.status == true )? 'Completada': 'Pendiete' , style: TextStyle(color: Colors.white),),
                  )),
          DataCell(
            IconButton(
                color: Colors.indigo,
                icon: Icon( Icons.arrow_outward_outlined ),
                onPressed: () async {
                  if (await canLaunch(entrevista.enlace!)) {
                    await launch(entrevista.enlace!);
                  }else{
                    print('No se puede');
                    return;
                  }
                },
              ),
          ),          
          
        ]))
    .toList();
}

// ============================================================
// ARCHIVOS GUARDADOS
// ============================================================
class _AttachmentsWorker extends StatelessWidget{

  const _AttachmentsWorker ({ Key? key }): super(key: key);

  @override
  Widget build( BuildContext context) {

    final List<Attachment> attachmentsWorker =  Provider.of<WorkerService>(context).worker.attachments!;

    return Container(
      width: double.infinity,

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text('Archivos Guardados', style: TextStyle(fontSize: 20, color: Colors.grey),),
              // IconButton(
              //   color: Colors.indigo,
              //   icon: Icon( Icons.add ),
              //   onPressed: () {
              //   },
              // ),
            ],
          ),

          // LISTA DE ARCHIVOS
          SingleChildScrollView(
            
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 16.0,
              horizontalMargin: 16.0,
              dataRowHeight: 48.0,
              columns: const <DataColumn>
              [
                DataColumn(
                  label: Expanded(
                    child: Text('#',),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Descripción',),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Fecha',),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Estado',),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('',),
                  ),
                ),
              ],
          
              rows: _createRowsAttachments(attachmentsWorker),
            ),
          )

        ],
      ),
    );
  }
}

// ============================================================
// TABLA DE ARCHIVOS
// ============================================================
List<DataRow> _createRowsAttachments( List<Attachment> attachments){

  var i = 1;
  
  return attachments.map((att) => DataRow(cells: [
                    
          DataCell(Text( (i++).toString()  )),
          DataCell(Text( att.desc! )),
          DataCell(Text( '${att.fecha!.day.toString()}/${att.fecha!.month.toString()}/${att.fecha!.year.toString()} ' )),
          DataCell(Chip(
                    backgroundColor: (att.approved!)? Colors.green : Colors.amber,
                    label: Text((att.approved!)? 'Aprobado' : 'Pendiente', style: TextStyle(color: Colors.white),),
                  )
          ),
          DataCell(  
            IconButton(
              color: Colors.indigo,
              icon: Icon( Icons.download ),
              onPressed: () async {
                
                String url = 'https://grupofortalezasas.com/api/uploads/archivos/${att.attachment}'; // URL del archivo a descargar
                if (await canLaunch(url)) {
                  var response = await get(Uri.parse(url)); // Realizar una petición GET a la URL
                  var documentDirectory = await getApplicationDocumentsDirectory();
                  var filePath = '${documentDirectory.path}${att.attachment}'; // Definir la ruta de almacenamiento local
                  File file = File(filePath);
                  file.writeAsBytesSync(response.bodyBytes); // Guardar el archivo en la ruta especificada
                  await launch(url); // Descargar el archivo utilizando la URL
                }

              },
            ),
          ),
        ]))
    .toList();
}

// ============================================================
// JOBS WORKERS
// ============================================================
class _JobsWorker extends StatelessWidget{

  const _JobsWorker ({ Key? key }): super(key: key);

  @override
  Widget build( BuildContext context) {

    final worker = Provider.of<WorkerService>(context).worker;
    final jobsService = Provider.of<JobsService>(context).loadJobsWorker(worker.wid!);
    final jobs = Provider.of<JobsService>(context).jobs;

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text('Tabajos Asignados', style: TextStyle(fontSize: 20, color: Colors.grey),),

          Container(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                // TABLA DE TRABAJOS
                child: (jobs.isEmpty)?

                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text('No tienes ningun trabajo asignado...', style: TextStyle(fontSize: 18, color: Colors.grey),)
                    )
                    
                    :DataTable(
                    columnSpacing: 30.0,
                    horizontalMargin: 16.0,
                    dataRowHeight: 48.0,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text('#',),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text('Empresa',),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text('Pago',),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text('Fecha de inicio',),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text('',),
                        ),
                      ),
                    ], 
                    rows: jobs.map( (job) =>  
                      DataRow(
                        cells: [
                          DataCell(
                            Text( job.control.toString() )
                          ),
                          DataCell(
                            Text( job.bussiness!.name! )
                          ),
                          DataCell(
                            Text(job.sueldo.toString())
                          ),
                          DataCell(
                            Text( '${job.fechain!.day}/${job.fechain!.month}/${job.fechain!.year}' )
                          ),
                          DataCell(
                            IconButton(
                              color: Colors.indigo,
                              icon: Icon( Icons.download ),
                              onPressed: () async {

                                String url = 'https://grupofortalezasas.com/api/jobs/certificado/${job.jid}'; // URL del archivo a descargar
                                if (await canLaunch(url)) {
                                  var response = await get(Uri.parse(url)); // Realizar una petición GET a la URL
                                  var documentDirectory = await getApplicationDocumentsDirectory();
                                  var filePath = '${documentDirectory.path}${ DateTime.now() }certificado-laboral.pdf'; // Definir la ruta de almacenamiento local
                                  File file = File(filePath);
                                  file.writeAsBytesSync(response.bodyBytes); // Guardar el archivo en la ruta especificada
                                  await launch(url); // Descargar el archivo utilizando la URL
                                }

                              },
                            ),
                          ),
                      ])
                    ).toList()
                  ),

              ),
          
            ),
          )

        ],
      ),
    );
  }
}
