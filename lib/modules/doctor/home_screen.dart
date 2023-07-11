import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:icon_broken/icon_broken.dart';
import 'package:project/layout/doctor/doctorcubit/cubit.dart';
import 'package:project/layout/doctor/doctorcubit/states.dart';
 import 'package:project/modules/doctor/doctor_search.dart';
import 'package:project/modules/doctor/post_screen.dart';
import 'package:project/shared/styles/colors.dart';

import '../../shared/components/components.dart';

class doctorHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<doctorLayoutcubit, doctorLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: doctorLayoutcubit.get(context).doctorCases.length>0,
          builder: (context) => Scaffold(
          appBar: AppBar(
              title: Text(
                'Home',
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateto(context, doctorSearchScreen());
                    },
                  icon: Icon(IconBroken.Search),
                ),
              ]),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => doctorBuildPost(
                  doctorLayoutcubit.get(context).doctorCases[index],
                  context,
                  doctorPostScreen(),
                  doctorLayoutcubit.get(context),
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 8.0,
                ),
                itemCount:doctorLayoutcubit.get(context).doctorCases.length ,
              ),
              SizedBox(
                height: 8.0,
              ),
            ]),
          ),
        ),
          fallback:(context) => Scaffold(
            appBar: AppBar(
                title: Text(
                  'Home',
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                 navigateto(context, doctorSearchScreen());
                    },
                    icon: Icon(IconBroken.Search),
                  ),
                ]),
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                width: double.infinity,
                 padding: EdgeInsets.all(18.0),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 100 ,),
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


}
