import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/modules/student/categories/partial%20cases/partial_screen.dart';
import 'package:project/modules/student/categories/single_denture.dart';
import 'package:project/shared/components/components.dart';
import 'package:project/shared/styles/colors.dart';
import '../../../layout/student/studentcubit/cubit.dart';
import '../../../layout/student/studentcubit/states.dart';
import '../student_search.dart';
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
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/login_background'),
                // مسار الصورة من مجلد assets
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
// حقل البحث الجديد
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(IconBroken.Search, color: Colors.grey),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              onTap: () {
                                navigateto(context, studentSearchScreen());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Text(
                        'Categories',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF004E7F),
                          fontSize: 28,
                        ),
                      ),
                    ), // مسافة إضافية
                    SizedBox(
                      height: 25,
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
                                await studentLayoutcubit
                                    .get(context)
                                    .getCompleteCases();

                                navigateto(context, completeDentureScreen());
                              },
                              child: Container(
                                height: 140,
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Color(0xFF6BC9FF),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Image(
                                      image: AssetImage(
                                          'images/The_Different_Types_of_Teeth 1.png'),
                                      fit: BoxFit.cover,
                                      height: 140,
                                      width: 140,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Complete Denture',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF004E7F),
                                            fontSize: 16)),
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
                                  border: Border.all(
                                    color: Color(0xFF6BC9FF),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Image(
                                      image: AssetImage('images/partial.png'),
                                      fit: BoxFit.cover,
                                      height: 140,
                                      width: 140,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Partial Denture',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF004E7F),
                                            fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await studentLayoutcubit
                                    .get(context)
                                    .getSingleCases();
                                navigateto(context, singlrdentureScreen());
                              },
                              child: Container(
                                height: 140,
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Color(0xFF6BC9FF),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Image(
                                      image: AssetImage('images/images 3.png'),
                                      fit: BoxFit.cover,
                                      height: 140,
                                      width: 140,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Single denture',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF004E7F),
                                            fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await studentLayoutcubit
                                    .get(context)
                                    .getOverCases();
                                navigateto(context, overdentureScreen());
                              },
                              child: Container(
                                height: 140,
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Color(0xFF6BC9FF),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Image(
                                      image: AssetImage('images/images 2.png'),
                                      fit: BoxFit.cover,
                                      height: 140,
                                      width: 140,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Over denture',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF004E7F),
                                            fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await studentLayoutcubit
                                    .get(context)
                                    .getFullMouthCases();
                                navigateto(context, fullMouthScreen());
                              },
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Color(0xFF6BC9FF),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage('images/images 4.png'),
                                      fit: BoxFit.scaleDown,
                                      height: 120,
                                      width: 140,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Full Mouth Rehabilitation Cases ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF004E7F),
                                            fontSize: 16),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await studentLayoutcubit
                                    .get(context)
                                    .getMaxilloCases();
                                navigateto(context, maxillofacialScreen());
                              },
                              child: Container(
                                height: 140,
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Color(0xFF6BC9FF),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Image(
                                      image: AssetImage('images/images 5.png'),
                                      fit: BoxFit.scaleDown,
                                      height: 140,
                                      width: 140,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Maxillofacial Cases',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF004E7F),
                                            fontSize: 16)),
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
          ),
        );
      },
    );
  }
}
