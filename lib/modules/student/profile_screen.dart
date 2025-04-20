import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/layout/student/studentcubit/cubit.dart';
import 'package:project/layout/student/studentcubit/states.dart';
import 'package:project/modules/student/change_password.dart';
import 'package:project/modules/student/edit_profile.dart';
import 'package:project/shared/styles/colors.dart';
import '../../shared/components/components.dart';

class studentProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<studentLayoutcubit, studentLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = studentLayoutcubit.get(context).studentmodel;
        return Scaffold(
          body: Container(
            color: Color(0xFFB8F5FF),
            child: Column(
              children: [
                Expanded(
                  //  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    color: Color(0xFFB8F5FF),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          ConditionalBuilder(
                            condition: userModel?.image != null,
                            builder: (context) => Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                CircleAvatar(
                                  radius: 68.0,
                                  backgroundColor:
                                      Color.fromRGBO(255, 255, 255, 0.66),
                                  child: CircleAvatar(
                                    radius: 64.0,
                                    backgroundImage: NetworkImage(
                                      '${userModel?.image}',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            fallback: (context) => Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                CircleAvatar(
                                  radius: 68.0,
                                  backgroundColor:
                                      Color.fromRGBO(255, 255, 255, 0.66),
                                  child: CircleAvatar(
                                    radius: 64.0,
                                    backgroundImage:
                                        AssetImage('images/profileimage.jpg'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${userModel?.name}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF003E65),
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            // LEVEL!=null ? LEVEL! : ' ',
                            '${userModel?.level}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF003E65),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  // flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.66),
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(30),
                        topEnd: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  studentLayoutcubit
                                      .get(context)
                                      .getSupervisorsData();
                                  navigateto(context, editProfileScreen());
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor:
                                      Colors.transparent,
                                      child: Icon(
                                        IconBroken.Edit,
                                        color: Color(0xFF003E65),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('Edit Profile',
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: Color(0xFF003E65),
                                        )),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          studentLayoutcubit
                                              .get(context)
                                              .getSupervisorsData();
                                          navigateto(
                                              context, editProfileScreen());
                                        },
                                        icon: Icon(
                                          IconBroken.Arrow___Right_2,
                                          color: Color(0xFF003E65),
                                        ))
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigateto(context, changePasswordScreen());
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.transparent,
                                      child: Icon(
                                        IconBroken.Password,
                                        color: Color(0xFF003E65),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('Change Password',
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: Color(0xFF003E65),
                                        )),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          navigateto(
                                              context, changePasswordScreen());
                                        },
                                        icon: Icon(
                                          IconBroken.Arrow___Right_2,
                                          color: Color(0xFF003E65),
                                        ))
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  studentLayoutcubit
                                      .get(context)
                                      .logoutStudent(context);
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.transparent,
                                      child: Icon(
                                        IconBroken.Logout,
                                        color: Color(0xFF003E65),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('Logout',
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: Color(0xFF003E65),
                                        )),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          studentLayoutcubit
                                              .get(context)
                                              .logoutStudent(context);
                                        },
                                        icon: Icon(
                                          IconBroken.Arrow___Right_2,
                                          color: Color(0xFF003E65),
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
