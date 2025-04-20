import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/layout/student/studentcubit/cubit.dart';
import 'package:project/layout/student/studentcubit/states.dart';
import 'package:project/modules/loginscreen/loginScreen.dart';
import 'package:project/shared/styles/colors.dart';

import '../../shared/components/constants.dart';

class studentLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    studentLayoutcubit.get(context).studentsetupInteractedMessage(context);

    return BlocConsumer<studentLayoutcubit, studentLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = studentLayoutcubit.get(context);
        return Scaffold(
          body: cubit.studentBottomScreens[cubit.currentIndex],
          bottomNavigationBar: Container(
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
                  icon: Image.asset("images/home.icon.png", height: 24),
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
              ],
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changebottom(index);
              },
            ),
          ),
        );
      },
    );

  }
}
