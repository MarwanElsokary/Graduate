
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

import 'admincubit/cubit.dart';
import 'admincubit/states.dart';

class adminLayoutScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<adminLayoutcubit,adminLayoutstates>(
      listener: (context, state) {

      },builder: (context, state) {
      var cubit =adminLayoutcubit.get(context);
        return Scaffold(
          body:  cubit.adminbottomScreens[cubit.currentIndex],
          bottomNavigationBar:BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
               icon:Icon(CupertinoIcons.group,
          ),
                label: 'students',
              ),

              BottomNavigationBarItem(
              //  icon: Icon( CupertinoIcons.person_2),
                icon: Icon(  IconBroken.User1),
                label: 'doctors',
              ),
              BottomNavigationBarItem(
             //   icon: Icon(  CupertinoIcons.person_badge_minus),
                icon: Icon(  IconBroken.User),
                label: 'supervisors',
              ),
            ] ,
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changebottomadmin(index);
            },
          ),
        );
    },

    );
  }
}


