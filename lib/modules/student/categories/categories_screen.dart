import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/modules/student/categories/partial%20cases/partial_screen.dart';
import 'package:project/modules/student/categories/single_denture.dart';
import 'package:project/shared/components/components.dart';
import 'package:project/shared/styles/colors.dart';
import '../../../layout/student/studentcubit/cubit.dart';
import '../../../layout/student/studentcubit/states.dart';
import 'complete cases/completedenture_screen.dart';
import 'full_mouth_screen.dart';
import 'maxillofacial_screen.dart';
import 'overdenture_screen.dart';

class categoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<studentLayoutcubit, studentLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Categories',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                       width: double.infinity,
                      decoration: BoxDecoration(),
                      child: GridView.count(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: [
                          InkWell(
                            onTap: () async {
                       await studentLayoutcubit .get(context).getCompleteCases() ;

                                navigateto(context, completeDentureScreen());

                            },
                            child: Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: defaultcol),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Image(
                                    image: AssetImage('images/complete.jpeg'),
                                    fit: BoxFit.scaleDown,
                                    height: 120,
                                    width: 120,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Complete Denture',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                             await studentLayoutcubit
                                  .get(context)
                                  .getPartialCases();
                                navigateto(context, partialScreen());
                            },
                            child: Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: defaultcol),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Image(
                                    image: AssetImage('images/partial.jpeg'),
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Partial Denture',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await    studentLayoutcubit.get(context).getSingleCases();
                                navigateto(context, singlrdentureScreen());
                            },
                            child: Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: defaultcol),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Image(
                                    image: AssetImage('images/complete 2.jpeg'),
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Single denture',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await  studentLayoutcubit.get(context).getOverCases();
                              navigateto(context, overdentureScreen());
                            },
                            child: Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: defaultcol),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Image(
                                    image: AssetImage('images/overdenture.png'),
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Over denture',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await   studentLayoutcubit
                                  .get(context)
                                  .getFullMouthCases();
                              navigateto(context, fullMouthScreen());
                            },
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: defaultcol),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage('images/Рот.jpg'),
                                    fit: BoxFit.scaleDown,
                                    height: 100,
                                    width: double.infinity,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Full Mouth Rehabilitation Cases ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await   studentLayoutcubit.get(context).getMaxilloCases();
                              navigateto(context, maxillofacialScreen());
                            },
                            child: Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: defaultcol),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Image(
                                    image: AssetImage('images/maxillo2.png'),
                                    fit: BoxFit.scaleDown,
                                    height: 120,
                                    width: 120,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Maxillofacial Cases',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
