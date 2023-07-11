import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/layout/supervisor/supervisorcubit/cubit.dart';
import 'package:project/layout/supervisor/supervisorcubit/states.dart';
class superviasorLayoutScreen extends StatelessWidget {
  const superviasorLayoutScreen({Key? key}) : super(key: key);

  @override  Widget build(BuildContext context) {
    supervisorLayoutcubit.get(context).supersetupInteractedMessage(context);
    return BlocConsumer<supervisorLayoutcubit,supervisorLayoutstates>(
      listener: (context, state) {
      },builder: (context, state) {
      var cubit =supervisorLayoutcubit.get(context);
   return Scaffold(
        body:  cubit.superbottomScreens[cubit.currentIndex],
        bottomNavigationBar:BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon:Icon(
                IconBroken.Home,
              ),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon( Icons.list),
              label: 'doctors',
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
            cubit.changebottomsupervisor(index);
          },
        ),
      );
    },
    );

  }
}
