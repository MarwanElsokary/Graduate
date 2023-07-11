
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:project/layout/doctor/doctor_Layout_screen.dart';
import 'package:project/layout/supervisor/supervisor_layout.dart';
import 'package:project/modules/loginscreen/loginScreen.dart';
import 'package:project/shared/styles/colors.dart';
import 'package:page_transition/page_transition.dart';
import '../layout/admin/admin_Layout_screen.dart';
import '../layout/student/Layout_screen.dart';
import '../shared/components/constants.dart';

class splashScreen extends StatelessWidget {
  late Widget widget;
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(

        splash: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage('images/131818-dental-clinic-color.gif'),
              width: 250,
              height: 250,

            ),
            Text('Easy Patient Finder', style: TextStyle(
              fontSize: 20,
              color: defaultcol,
              fontWeight: FontWeight.bold,
            ),),


    ],
        ),
      nextScreen: widget=getwidget(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.white,
        splashIconSize: 300,
        duration: 1500

    );
  }

 Widget  getwidget() {

   print('role is $ROLE');
   print('uid is $UID');
   if(UID != null && ROLE != null ){

        if (ROLE == 'student') {
          return studentLayoutScreen();
        }
        else if (ROLE == 'Doctor') {
          return doctorLayoutScreen();
        } else if (ROLE == 'Supervisor') {
          return superviasorLayoutScreen();
        }
        else if (ROLE == 'admin') {
          return adminLayoutScreen();
        }
      }
   else{
          return loginScreen();
    }
    throw('there is an error look at splash screen');

  }

}