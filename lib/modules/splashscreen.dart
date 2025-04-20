
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
import 'loginscreen/onboarding.dart';

class splashScreen extends StatelessWidget {
  final bool seenOnboarding;

  const splashScreen({super.key, required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'images/splash.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'images/HELLO !.png',
                  height: 30,
                ),
                SizedBox(height: 20),
                Text(
                  'Easy medical solutions',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF004E7F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      nextScreen: _getNextScreen(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Colors.white,
      splashIconSize: double.infinity,
      duration: 3000,
    );
  }

  Widget _getNextScreen() {
    print('Onboarding Status: $seenOnboarding');
    print('User Status: UID=$UID, ROLE=$ROLE');

    // إذا كان المستخدم مسجل دخول
    if (UID != null && ROLE != null) {
      switch (ROLE) {
        case 'student': return studentLayoutScreen();
        case 'Doctor': return doctorLayoutScreen();
        case 'Supervisor': return superviasorLayoutScreen();
        case 'admin': return adminLayoutScreen();
      }
    }

    // إذا لم يكن مسجل دخول
    return seenOnboarding ? loginScreen() : OnboardingScreen();
  }
}