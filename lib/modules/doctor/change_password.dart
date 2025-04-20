import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/layout/doctor/doctorcubit/cubit.dart';
import 'package:project/shared/components/components.dart';
import '../../layout/doctor/doctor_Layout_screen.dart';
import '../../layout/doctor/doctorcubit/states.dart';
import '../../shared/styles/colors.dart';

class changePasswordScreen extends StatelessWidget {
  var oldPasswordcon = TextEditingController();
  var newPasswordcon = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool ispass = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => doctorLayoutcubit(),
      child: BlocConsumer<doctorLayoutcubit, doctorLayoutstates>(
        listener: (context, state) {
          if (state is doctorChangePasswordSucessState) {
            showtoast(
                text: 'Password Changed Successfully',
                state: toaststates.SUCCESS);
            navigate(context, doctorLayoutScreen());
          }
          if (state is doctorChangePasswordErrorState) {
            showtoast(
                text: 'Enter a valid password and try again.',
                state: toaststates.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              color: Color(0xFFB8F5FF),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Color(0xFFB8F5FF),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  IconBroken.Arrow___Left_2,
                                  color: Color(0xFF004E7F),
                                ),
                              ),
                              Text(
                                'Change Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF004E7F),
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, .88),
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(30),
                          topEnd: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Form(
                              key: formkey,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        IconBroken.Arrow___Left_2,
                                        color:
                                            Color.fromRGBO(255, 255, 255, .88),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                      child: Text(
                                        'Change Password',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: defaultcol,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Enter your current password and your new password to change it',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Current Password',
                                      style: TextStyle(
                                        color: Color(0xFF004E7F),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    defaulttextformfield(
                                      controller: oldPasswordcon,
                                      radius: 30,
                                      bordercolor: Color(0xFF6BC9FF),
                                      keyboardtype:
                                          TextInputType.visiblePassword,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'please enter your Current Password';
                                        }
                                        if (value.length < 6) {
                                          return 'Password must be greater than six characters';
                                        }
                                      },
                                      label: '',
                                      suffix:
                                          doctorLayoutcubit.get(context).suffix,
                                      suffixPressed: () => doctorLayoutcubit
                                          .get(context)
                                          .changepassvisibility(),
                                      hidepassword: doctorLayoutcubit
                                          .get(context)
                                          .hidepass,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'New Password',
                                      style: TextStyle(
                                        color: Color(0xFF004E7F),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    defaulttextformfield(
                                      controller: newPasswordcon,
                                      radius: 30,
                                      keyboardtype:
                                          TextInputType.visiblePassword,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'please enter your New password';
                                        }
                                        if (value.length < 4) {
                                          return 'Password must be greater than six characters';
                                        }
                                      },
                                      label: '',
                                      bordercolor: Color(0xFF6BC9FF),

                                      suffix:
                                          doctorLayoutcubit.get(context).suffix,
                                      suffixPressed: () => doctorLayoutcubit
                                          .get(context)
                                          .changepassvisibility(),
                                      hidepassword: doctorLayoutcubit
                                          .get(context)
                                          .hidepass,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ConditionalBuilder(
                                      condition: state
                                          is! doctorChangePasswordLoadingState,
                                      fallback: (context) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      builder: (context) => defaultbutton(
                                        onpress: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            doctorLayoutcubit
                                                .get(context)
                                                .changePassword(
                                                  oldPassword:
                                                      oldPasswordcon.text,
                                                  newPassword:
                                                      newPasswordcon.text,
                                                );
                                          }
                                        },
                                        text: 'update Password ',
                                        upercase: true,
                                        radius: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
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
