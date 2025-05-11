import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../layout/student/studentcubit/cubit.dart';
import '../../../../layout/student/studentcubit/states.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/styles/colors.dart';
import '../../post_screen.dart';


class partial1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<studentLayoutcubit, studentLayoutstates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ConditionalBuilder(
          //if level =post &   studentLayoutcubit.get(context).studentCases.length>0,
          condition: studentLayoutcubit.get(context).partialCases1.length > 0,
          builder: (context) => Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Tooth Cases',
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => studentDefaultbuildPost(
                    studentLayoutcubit.get(context).partialCases1[index],
                    context,
                    studentPostScreen(),
                    studentLayoutcubit.get(context),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.0,
                  ),
                  itemCount: studentLayoutcubit.get(context).partialCases1.length,
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
                title: 'Tooth Cases',
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
        );
      },
    );
  }
}
