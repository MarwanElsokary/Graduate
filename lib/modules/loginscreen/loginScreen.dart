import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/layout/admin/admin_Layout_screen.dart';
import 'package:project/layout/admin/admincubit/cubit.dart';
import 'package:project/layout/doctor/doctorcubit/cubit.dart';
import 'package:project/layout/student/Layout_screen.dart';
import 'package:project/layout/student/studentcubit/cubit.dart';
import 'package:project/layout/supervisor/supervisor_layout.dart';
import 'package:project/layout/supervisor/supervisorcubit/cubit.dart';
import 'package:project/modules/loginscreen/forget_password.dart';
import 'package:project/modules/registerscreen/registerScreen.dart';
import 'package:project/shared/network/local/cache_helper.dart';
import 'package:project/shared/styles/colors.dart';

import '../../layout/doctor/doctor_Layout_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../registerscreen/doctorsregisterScreen.dart';
import 'logincubit.dart';
import 'loginstates.dart';

class loginScreen extends StatelessWidget {
  var emailcon = TextEditingController();
  var passwordcon = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool ispass = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => logincubit(),
      child: BlocConsumer<logincubit, loginstates>(
        listener: (context, state) async {
          if (state is loginErrorState) {
            showtoast(
              text:
                  'The email address or password that you have entered doesn\'t match any account ',
              state: toaststates.ERROR,
            );
          }
          if (state is loginSucessState) {
            cacheHelper
                .savedata(
              key: 'uId',
              value: state.uId,
            )
                .then((value) {
              UID = state.uId;
              FirebaseFirestore.instance
                  .collection('users')
                  .where('uId', isEqualTo: state.uId)
                  .get()
                  .then((QuerySnapshot querySnapshot) {
                querySnapshot.docs.forEach((doc) async {
                  cacheHelper
                      .savedata(
                    key: 'role',
                    value: doc["role"],
                  )
                      .then((value) {
                    ROLE = doc["role"];
                  }).catchError((error) {
                    print(error);
                  });
                  if (doc["role"] == 'student') {
                    await studentLayoutcubit.get(context).getStudentData();
                    await studentLayoutcubit.get(context).studentGetCases();
                    await studentLayoutcubit.get(context).getRequestedCases();
                    navigate(context, studentLayoutScreen());
                  } else if (doc["role"] == 'Doctor') {
                    await doctorLayoutcubit.get(context).getDoctorData();
                    // await  doctorLayoutcubit.get(context). docotrGetCases();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: BlocProvider.of<doctorLayoutcubit>(
                              context), // Use the existing cubit
                          child: doctorLayoutScreen(),
                        ),
                      ),
                    );
                  } else if (doc["role"] == 'Supervisor') {
                    await supervisorLayoutcubit
                        .get(context)
                        .getSupervisorData();
                    await supervisorLayoutcubit
                        .get(context)
                        .supervisorGetCases();
                    await supervisorLayoutcubit.get(context).getAllDoctors();
                    await supervisorLayoutcubit
                        .get(context)
                        .getRequestedCases();
                    navigate(context, superviasorLayoutScreen());
                  } else if (doc["role"] == 'admin') {
                    await adminLayoutcubit.get(context).getStudents();
                    await adminLayoutcubit.get(context).getDoctors();
                    await adminLayoutcubit.get(context).getSupervisors();
                    navigate(context, adminLayoutScreen());
                  } else {
                    print('cant login');
                  }
                });
              });
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              color: defaultcol,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      color: defaultcol,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Sign in ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(30),
                          topEnd: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Form(
                                key: formkey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Welcome Back',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: defaultcol,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'sign in to continue',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      defaulttextformfield(
                                        controller: emailcon,
                                        radius: 30,
                                        keyboardtype:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'please enter your email address';
                                          }
                                        },
                                        label: 'Email Address',
                                        prefix: IconBroken.Message,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      defaulttextformfield(
                                        controller: passwordcon,
                                        radius: 30,
                                        onsubmit: (p0) {
                                          if (formkey.currentState!
                                              .validate()) {
                                            if (state is! loginLoadingState) {
                                              logincubit.get(context).userLogin(
                                                  email: emailcon.text,
                                                  password: passwordcon.text);
                                            }
                                          }
                                        },
                                        keyboardtype:
                                            TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'please enter your  password';
                                          }
                                        },
                                        label: 'Password',
                                        prefix: IconBroken.Password,
                                        suffix: logincubit.get(context).suffix,
                                        suffixPressed: () => logincubit
                                            .get(context)
                                            .changepassvisibility(),
                                        hidepassword:
                                            logincubit.get(context).hidepass,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          navigateto(
                                              context, forgetPasswordScreen());
                                        },
                                        child: Text('Forget your password ?'),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      ConditionalBuilder(
                                        condition: state is! loginLoadingState,
                                        builder: (context) => defaultbutton(
                                          onpress: () {
                                            if (formkey.currentState!
                                                .validate()) {
                                              logincubit.get(context).userLogin(
                                                  email: emailcon.text,
                                                  password: passwordcon.text);
                                            }
                                          },
                                          text: 'sign in ',
                                          upercase: true,
                                          radius: 30,
                                        ),
                                        fallback: (context) => Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Don\'t have an account?'),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: defaultTextButton(
                                                  onpress: () {
                                                    navigateto(context,
                                                        doctorRegisterScreen());
                                                  },
                                                  text: 'sign up as doctor ',
                                                  size: 13,
                                                ),
                                              ),
                                              Expanded(
                                                child: defaultTextButton(
                                                  onpress: () {
                                                    navigateto(context,
                                                        registerScreen());
                                                  },
                                                  text: 'sign up as Student ',
                                                  size: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
