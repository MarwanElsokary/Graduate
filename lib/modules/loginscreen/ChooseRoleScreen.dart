import 'package:flutter/material.dart';
import '../registerscreen/SupervisorRegisterScreen.dart';
import '../registerscreen/doctorsregisterScreen.dart';
import '../registerscreen/registerScreen.dart';

class ChooseRoleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('images/login_background.png'),
    // مسار الصورة من مجلد assets
    fit: BoxFit.cover,
    ),
    ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF004E7F),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Sign Up as",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF004E7F),
                  ),
                ),
                const SizedBox(height: 25),

                _buildRoleButton(context, "Doctor"),
                const SizedBox(height: 25),
                _buildRoleButton(context, "Student"),
                const SizedBox(height: 25),
                _buildRoleButton(context, "Supervisor"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, String role) {
    return GestureDetector(
      onTap: () {
        // التوجيه حسب الـ Role
        if (role == "Doctor") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DoctorRegisterScreen()),
          );
        } else if (role == "Student") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => registerScreen()),
          );
        } else if (role == "Supervisor") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SupervisorRegisterScreen()),
          );
        }
      },
      child: Container(
        width: 190,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFF6BC9FF), width: 1),
        ),
        child: Text(
          role,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF003366),
          ),
        ),
      ),
    );
  }
}
