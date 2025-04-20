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
     backgroundColor: Color(0xFFB8F5FF),
        body:  cubit.superbottomScreens[cubit.currentIndex],
        bottomNavigationBar:Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.88),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -1),
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent, // مهم علشان ياخد لون الـ Container
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon:
                  Image.asset("images/home.icon.png", height: 24),
                activeIcon: Image.asset("images/home.icon.png", height: 28),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Image.asset("images/doctors.icon.png", height: 24),
                activeIcon: Image.asset("images/doctors.icon.png", height: 28),
                label: "Doctors",
              ),
              BottomNavigationBarItem(
                icon: Image.asset("images/requests.icon.png", height: 24),
                activeIcon: Image.asset("images/requests.icon.png", height: 28),
                label: "Requests",
              ),
              BottomNavigationBarItem(
                icon: Image.asset("images/profile.icon.png", height: 24),
                activeIcon: Image.asset("images/profile.icon.png", height: 28),
                label: "Profile",
              ),
            ] ,
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changebottomsupervisor(index);
            },
          ),
        ),
      );
    },
    );

  }
}
