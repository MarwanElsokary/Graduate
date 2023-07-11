import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/models/user_model.dart';
import 'package:project/modules/supervisor/posts_perDoctor_screen.dart';
import '../../layout/supervisor/supervisorcubit/cubit.dart';
import '../../layout/supervisor/supervisorcubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class doctorsScreen extends StatelessWidget {
  const doctorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<supervisorLayoutcubit, supervisorLayoutstates>(
        listener: (context, state) {
        },
        builder: (context, state)
        {
            var   cubit=supervisorLayoutcubit.get(context).doctors;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Doctors List',
              ),),
            body: ConditionalBuilder(
              condition:cubit.length>0 ,
              builder: (context) =>  ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildItem(cubit[index],context),
                separatorBuilder: (context, index) => SizedBox(
                  height: 8.0,
                ),
                itemCount: cubit.length,
              ),
              fallback:(context) => Scaffold(
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

            ),
          );


        },
      );
  }
  Widget buildItem(userModel modell ,context){
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Card(
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
                        condition: modell. image!=null ,
                        builder: (context) => Stack(
                          children: [
                            CircleAvatar(
                              radius: 35.0,
                              backgroundImage: NetworkImage(
                                '${modell.image}',
                              ),

                            ),
                          ],
                        ),
                        fallback: (context) => Stack(
                          children: [
                            CircleAvatar(
                              radius: 35.0,
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
                                '${modell.name}',
                                style: TextStyle(
                                  height: 1.4,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                                    defaultTextButton(
                                      onpress: () {
                                        supervisorLayoutcubit.get(context).supervisorGetCasesPerDoctor(modell!.uId as String);
                                        navigateto(context, postPerDoctorScreen());
                                      },
                                      text: 'View the cases',
                                      size: 12,textalign: TextAlign.center,
                                    ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}
