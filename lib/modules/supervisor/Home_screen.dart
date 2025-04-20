import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/layout/supervisor/supervisorcubit/cubit.dart';
import 'package:project/layout/supervisor/supervisorcubit/states.dart';
import 'package:project/modules/supervisor/post_screen.dart';
import 'package:project/modules/supervisor/supervisor_search.dart';
import 'package:project/shared/styles/colors.dart';
import '../../shared/components/components.dart';

class supervisorHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<supervisorLayoutcubit, supervisorLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:
              supervisorLayoutcubit.get(context).supervisorCases.length > 0,
          fallback: (context) => Scaffold(
            appBar: AppBar(
                title: Text(
                  'Home',
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      navigateto(context, supervisorSearchScreen());
                    },
                    icon: Icon(IconBroken.Search),
                  ),
                ]),
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                color: Color(0xFFb8f5ff),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        'images/no_data_found1.png',
                        width: double.infinity,
                        // تحكمي في الحجم حسب الحاجة
                        height: 347,
                      ),
                    ),
                    SizedBox(height: 20), // مسافة بين الصورة والنص
                    Expanded(
                      child: Text(
                        "Sorry We Can’t Find Any Data!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF004E7F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          builder: (context) {
            return Scaffold(
              backgroundColor: Color(0xFFB8F5FF),
              appBar: AppBar(
                  title: Text(
                    'Home',
                  ),
                  backgroundColor: Color(0xFFB8F5FF),
                  ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Container(
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
                                navigateto(context, supervisorSearchScreen());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox( height: 15,),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => supervisorBuildPost(
                      supervisorLayoutcubit.get(context).supervisorCases[index],
                      context,
                      superPostScreen(),
                      supervisorLayoutcubit.get(context),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 8.0,
                    ),
                    itemCount: supervisorLayoutcubit
                        .get(context)
                        .supervisorCases
                        .length,
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
