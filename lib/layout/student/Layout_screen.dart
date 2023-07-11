import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/layout/student/studentcubit/cubit.dart';
import 'package:project/layout/student/studentcubit/states.dart';
import 'package:project/modules/loginscreen/loginScreen.dart';
import 'package:project/shared/styles/colors.dart';

import '../../shared/components/constants.dart';


class studentLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    studentLayoutcubit.get(context).studentsetupInteractedMessage(context);

    return BlocConsumer<studentLayoutcubit,studentLayoutstates>(
      listener: (context, state) {
      },builder: (context, state) {
      var cubit =studentLayoutcubit.get(context);
        return Scaffold(
          body:  cubit.studentBottomScreens[cubit.currentIndex],
          bottomNavigationBar:BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
               icon:Icon(
          IconBroken.Home,
          ),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon( IconBroken.Category),
                label: 'categories',
              ),
              BottomNavigationBarItem(
                icon: Icon( IconBroken.Message),
                label: 'requests',
              ),
              BottomNavigationBarItem(
                icon: Icon( IconBroken.Profile),
                label: 'Profile',
              ),
            ] ,
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changebottom(index);
            },
          ),
        );
    },

    );
  }
}


