import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/modules/student/categories/partial%20cases/partial1_denture.dart';
import 'package:project/modules/student/categories/partial%20cases/partial2_denture.dart';
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
              backgroundColor: Color(0xFFB8F5FF),
              appBar: defaultAppBar(
                context: context,
                title: 'Single denture Cases',
              ),
              body: Container(
                color: Color(0xFFb8f5ff),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'images/no_data_found1.png',
                        width: double.infinity, // تحكم في الحجم حسب الحاجة
                        height: 347,
                      ),
                    ),
                    SizedBox(height: 20), // مسافة بين الصورة والنص
                    Expanded(
                      child: Text(
                        "Sorry We Can’t Find Any Data!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF004E7F),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          builder: (context) => Scaffold(
            backgroundColor: Color(0xFFB8F5FF),

            appBar: defaultAppBar(
              context: context,
              title: 'Single denture Cases',
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  //    height: 50,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 5,
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
                  itemCount:
                      studentLayoutcubit.get(context).partialCases.length,
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
