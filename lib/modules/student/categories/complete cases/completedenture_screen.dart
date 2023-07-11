import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../layout/student/studentcubit/cubit.dart';
import '../../../../layout/student/studentcubit/states.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/styles/colors.dart';
import '../../post_screen.dart';
import 'complete_flat.dart';
import 'complete_well_screen.dart';

class completeDentureScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<studentLayoutcubit, studentLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
           return ConditionalBuilder(
            condition:studentLayoutcubit.get(context).completeCases.length > 0,
            fallback: (context) => Scaffold(
              appBar: defaultAppBar(
                context: context,
                title: 'Complete Denture Cases',
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
            builder: (context) {
              return Scaffold(
                appBar: defaultAppBar(
                  context: context,
                  title: 'Complete Denture Cases',
                ),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      height: 60,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: defaultbutton(
                              onpress: () async {
                                await    studentLayoutcubit
                                    .get(context)
                                    .getCompleteFlatCases();
                                navigateto(context, completeFlatScreen());
                              },
                              text: 'Flat Ridge',
                              textalign: TextAlign.center,
                              radius: 30,
                              width: 20,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: defaultbutton(
                              onpress: () async {
                                await  studentLayoutcubit
                                    .get(context)
                                    .getCompleteWellCases();
                                navigateto(context, completeWellScreen());
                              },
                              text: 'Well Developed Ridge',
                              textalign: TextAlign.center,
                              radius: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => studentDefaultbuildPost(
                        studentLayoutcubit.get(context).completeCases[index],
                        context,
                        studentPostScreen(),
                        studentLayoutcubit.get(context),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 8.0,
                      ),
                      itemCount:
                      studentLayoutcubit.get(context).completeCases.length,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ]),
                ),
              );
            },
          );

      },
    );
  }
}
