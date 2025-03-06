import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icon_broken/icon_broken.dart';

import '../../layout/doctor/doctorcubit/cubit.dart';
import '../../layout/doctor/doctorcubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import 'change_password.dart';
import 'edit_profile.dart';

class doctorProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<doctorLayoutcubit, doctorLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = doctorLayoutcubit.get(context).doctormodel;
        return Scaffold(
          body: Container(
            color: defaultcol,
            child: Column(
              children: [
                Expanded(
                  //  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    color: defaultcol,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          ConditionalBuilder(
                            fallback: (context) => Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                CircleAvatar(
                                  radius: 68.0,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 64.0,
                                    backgroundImage:
                                        AssetImage('images/profileimage.jpg'),
                                  ),
                                ),
                              ],
                            ),
                            condition: userModel?.image != null,
                            builder: (context) => Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                CircleAvatar(
                                  radius: 68.0,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 64.0,
                                    backgroundImage: NetworkImage(
                                      '${userModel?.image}',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${userModel?.name}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 5,
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
                      color: Colors.white,
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
                                  navigateto(
                                      context, doctorEditProfileScreen());
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: cc.defcol,
                                      child: Icon(IconBroken.Edit,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('Edit Profile',
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: HexColor('#87b4c6'),
                                        )),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          navigateto(context,
                                              doctorEditProfileScreen());
                                        },
                                        icon: Icon(
                                          IconBroken.Arrow___Right,
                                          color: defaultcol,
                                        ))
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // doctorLayoutcubit.get(context). getCasesOfDoctor();
                                  // navigateto(context,  casesOfDoctor());
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: cc.defcol,
                                      child: Icon(IconBroken.Paper,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('Your Cases',
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: HexColor('#87b4c6'),
                                        )),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          // doctorLayoutcubit.get(context). getCasesOfDoctor();
                                          // navigateto(context,  casesOfDoctor());
                                        },
                                        icon: Icon(
                                          IconBroken.Arrow___Right,
                                          color: defaultcol,
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
                                      backgroundColor: cc.defcol,
                                      child: Icon(IconBroken.Password,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('Change Password',
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: HexColor('#87b4c6'),
                                        )),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          navigateto(
                                              context, changePasswordScreen());
                                        },
                                        icon: Icon(
                                          IconBroken.Arrow___Right,
                                          color: defaultcol,
                                        ))
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // doctorLayoutcubit.get(context). logoutdoctor(context);
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: cc.defcol,
                                      child: Icon(IconBroken.Logout,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('Logout',
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: HexColor('#87b4c6'),
                                        )),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          // doctorLayoutcubit.get(context). logoutdoctor(context);
                                        },
                                        icon: Icon(
                                          IconBroken.Arrow___Right,
                                          color: defaultcol,
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
