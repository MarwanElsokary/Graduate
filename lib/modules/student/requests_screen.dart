import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/models/user_model.dart';
import 'package:project/modules/student/post_screen.dart';
import '../../../layout/student/studentcubit/cubit.dart';
import '../../../layout/student/studentcubit/states.dart';
import '../../models/request.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
class studentRequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<studentLayoutcubit, studentLayoutstates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var cubitcase = studentLayoutcubit.get(context).requestedCasesStudent;
        var cubitsuper = studentLayoutcubit.get(context). RequestedCasesSupervisor;

        return ConditionalBuilder(
            condition: cubitcase.length>0,
            builder: (context) {return
              Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Request status',
                  ),
                ),
                body: ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>  buildRequestItem(cubitcase[index],cubitsuper[index],context),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.0,
                  ),
                  itemCount: cubitcase.length,
                ),
              );
            },
            fallback: (context) => Scaffold(
              appBar: AppBar(
                title: Text(
                  'Request status',
                ),),
              body: Container(
                width: double.infinity,
                padding: EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('images/nodataavailable.gif'),
                      //  width: 250,
                      //    height: 250,
                    ),
                    Text(
                      'Sorry We Can\'t Find Any Data ',
                      style: TextStyle(
                        fontSize: 20,
                        color: defaultcol,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          );


      },
    );
  }
   Widget buildRequestItem(requestModel model, userModel supermodel,context ){
     return  Padding(
         padding: const EdgeInsets.all(10.0),
         child: Column(
           children: [

             ConditionalBuilder(
                 condition: model.requeststatus == 'accept',
                 builder: (context) =>Card(
               clipBehavior: Clip.antiAliasWithSaveLayer,
               elevation: 5.0,
               margin: EdgeInsets.symmetric(
                 horizontal: 10.0,
               ),
               child: Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Column(
                   children: [
                     Row(
                       children: [
                        ConditionalBuilder(
                           condition: supermodel. image!=null ,
                           builder: (context) => Stack(
                             children: [
                               CircleAvatar(
                                 radius: 25.0,
                                 backgroundImage: NetworkImage(
                                   '${supermodel.image}',
                                 ),

                               ),
                             ],
                           ),
                           fallback: (context) => Stack(
                             children: [
                               CircleAvatar(
                                 radius: 25.0,
                                 backgroundImage: AssetImage('images/profileimage.jpg'),
                               ),

                             ],
                           ), ),
                         SizedBox(
                           width: 10.0,
                         ),
                         Expanded(
                           child: Container(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 SizedBox(
                                   height: 5,
                                 ),
                                 Text(
                                 '${ supermodel.name}',
                                   style: TextStyle(
                                     height: 1.4,
                                     fontSize: 15,
                                     fontWeight: FontWeight.w600,
                                   ),
                                 ),
                                 SizedBox(
                                   height: 5,
                                 ),
                                 Text(
                                   'Accepted your request ',
                                   style:
                                   TextStyle(
                                     color:  Colors.green[600],
                                   ),
                                 ),SizedBox(
                                   height: 5,
                                 ),


                               ],
                             ),
                           ),
                         ),
                       ],
                     ),

                     Padding(
                       padding: const EdgeInsets.symmetric(
                         vertical: 8.0,
                       ),
                       child: Container(
                         width: double.infinity,
                         height: 1.0,
                         color: Colors.grey[300],
                       ),
                     ),
                     Align(
                       alignment:  Alignment.centerLeft,
                       child: Text(
                         'Patient Phone : ${model.patientPhone} ',
                       ),
                     ),
                     Container(
                       alignment: Alignment.topLeft,
                       child: defaultTextButton(
                         onpress: ()   async {
                          await  studentLayoutcubit.get(context).studentGetCase(model.caseid as String);
                           navigateto(context, studentPostScreen());
                         },
                         text:'View the case',
                         textalign: TextAlign.start,

                         size: 12,
                       ),
                     ),
                   ],
                 ),
               ),
             ),
                 fallback: (context) => Card(
                   clipBehavior: Clip.antiAliasWithSaveLayer,
                   elevation: 5.0,
                   margin: EdgeInsets.symmetric(
                     horizontal: 10.0,
                   ),
                   child: Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: Column(
                       children: [
                         Row(
                           children: [
                             ConditionalBuilder(
                               condition: supermodel. image!=null ,
                               builder: (context) => Stack(
                                 children: [
                                   CircleAvatar(
                                     radius: 25.0,
                                     backgroundImage: NetworkImage(
                                       '${supermodel.image}',
                                     ),

                                   ),
                                 ],
                               ),
                               fallback: (context) => Stack(
                                 children: [
                                   CircleAvatar(
                                     radius: 25.0,
                                     backgroundImage: AssetImage('images/profileimage.jpg'),
                                   ),

                                 ],
                               ), ),

                             SizedBox(
                               width: 10.0,
                             ),
                             Expanded(
                               child: Container(
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     SizedBox(
                                       height: 5,
                                     ),
                                     Text(
                                       '${supermodel.name}',
                                       style: TextStyle(
                                         height: 1.4,
                                         fontSize: 15,
                                         fontWeight: FontWeight.w600,
                                       ),
                                     ),
                                     SizedBox(
                                       height: 5,
                                     ),
                                     Text(
                                       'Rejected your request ',
                                       style:
                                       TextStyle(
                                         color:  Colors.red[600],
                                       ),
                                     ),SizedBox(
                                       height: 5,
                                     ),


                                   ],
                                 ),
                               ),
                             ),
                           ],
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(
                             vertical: 8.0,
                           ),
                           child: Container(
                             width: double.infinity,
                             height: 1.0,
                             color: Colors.grey[300],
                           ),
                         ),
                         Container(
                           alignment: Alignment.topLeft,
                           child: defaultTextButton(
                             onpress: () async {
                            await   studentLayoutcubit.get(context).studentGetCase(model.caseid as String);
                               navigateto(context, studentPostScreen());
                             },
                             text:'View the case',
                             textalign: TextAlign.start,

                             size: 12,
                           ),
                         ),
                       ],
                     ),
                   ),
                 )

         ),

           ],
         ),

     );
   }
}
