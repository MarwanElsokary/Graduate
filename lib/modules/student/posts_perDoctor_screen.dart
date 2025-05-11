import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/layout/supervisor/supervisorcubit/cubit.dart';
import 'package:project/layout/supervisor/supervisorcubit/states.dart';
import 'package:project/modules/student/post_screen.dart';
import 'package:project/modules/student/post_screen_student.dart';
import 'package:project/modules/supervisor/post_screen.dart';
import 'package:project/shared/styles/colors.dart';
import '../../shared/components/components.dart';

class postPerDoctorScreenStudent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer< supervisorLayoutcubit, supervisorLayoutstates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: supervisorLayoutcubit.get(context).casesperdoctor.length > 0,
          builder: (context) => Scaffold(
            backgroundColor: Color(0xFFB8F5FF),

            appBar: defaultAppBar(
              context: context,
              title: 'Doctor Cases',
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => supervisorBuildPost(
                      supervisorLayoutcubit.get(context).casesperdoctor[index],
                      context,
                      studentPostScreen(),
                      supervisorLayoutcubit.get(context)
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.0,
                  ),
                  itemCount: supervisorLayoutcubit.get(context).casesperdoctor.length,
                ),
                SizedBox(
                  height: 8.0,
                ),
              ]),
            ),
          ),
          fallback: (context) => Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Doctor Cases',
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
                      width: double.infinity, // تحكمي في الحجم حسب الحاجة
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
            ),
          ),
        );

      },
    );
  }


}
