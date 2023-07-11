import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/modules/student/categories/partial%20cases/partial1_denture.dart';
import 'package:project/modules/student/categories/partial%20cases/partial2_denture.dart';
import 'package:project/modules/student/categories/partial%20cases/partial3_denture.dart';
import 'package:project/modules/student/categories/partial%20cases/partial4_denture.dart';
import '../../../../layout/student/studentcubit/cubit.dart';
import '../../../../layout/student/studentcubit/states.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/styles/colors.dart';
import '../../post_screen.dart';
class partialScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<studentLayoutcubit, studentLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: studentLayoutcubit.get(context).partialCases.length > 0,
          fallback: (context) => Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Partial denture Cases',
            ),
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
          builder:  (context) => Scaffold(
            appBar:  defaultAppBar(
              context:  context,
              title: 'Partial denture Cases',
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
               Container(
                padding: EdgeInsets.all(10.0),
            //    height: 50,
                width: double.infinity,
                child: Row(
                 crossAxisAlignment:  CrossAxisAlignment.center,
                 children: [
                  Expanded(

                   child: defaultbutton(
                    onpress: () {
                      studentLayoutcubit
                          .get(context)
                          .getPartial1Cases();
                      navigateto(context, partial1Screen());
                    },
                    text: 'kennedy |',textalign:TextAlign.center ,
                    radius: 30,
                    hight: 35,
                   ),
                  ),
                  SizedBox(width: 5,),
                  Expanded(

                   child: defaultbutton(
                    onpress: () {
                      studentLayoutcubit
                          .get(context)
                          .getPartial2Cases();
                      navigateto(context, partial2Screen());
                    },
                    text: 'kennedy ||',textalign:TextAlign.center ,
                    radius: 30,
                    hight: 35,
                   ),
                  ),

                 ],
                ),
               ),
               Container(
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                child: Row(
                 crossAxisAlignment:  CrossAxisAlignment.center,
                 children: [
                  Expanded(

                   child: defaultbutton(
                    onpress: () {
                      studentLayoutcubit
                          .get(context)
                          .getPartial3Cases();
                      navigateto(context, partial3Screen());
                    },
                    text: 'kennedy |||',textalign:TextAlign.center ,
                    radius: 30,
                    hight: 35,                 ),
                  ),
                  SizedBox(width: 5,),
                  Expanded(

                   child: defaultbutton(
                    onpress: () {
                      studentLayoutcubit
                          .get(context)
                          .getPartial4Cases();
                      navigateto(context, partial4Screen());
                    },
                    text: 'kennedy |v',textalign:TextAlign.center ,
                    radius: 30,
                    hight: 35,
                   ),
                  ),

                 ],
                ),
               ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => studentDefaultbuildPost(
                    studentLayoutcubit.get(context).partialCases[index],
                    context,
                    studentPostScreen(),
                    studentLayoutcubit.get(context),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.0,
                  ),
                  itemCount: studentLayoutcubit.get(context).partialCases.length,
                ),
                SizedBox(
                  height: 8.0,
                ),
              ]),
            ),
          ),
        );
      },
    );
  }


}
