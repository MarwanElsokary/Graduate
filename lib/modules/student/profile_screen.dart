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
    return BlocConsumer<studentLayoutcubit,studentLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = studentLayoutcubit.get(context).studentmodel;
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
                          SizedBox(height: 70,),
                          ConditionalBuilder(
                            condition: userModel?.image != null,
                            builder:(context) =>  Stack(
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
                            fallback: (context) => Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                CircleAvatar(
                                  radius: 68.0,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 64.0,
                                    backgroundImage: AssetImage('images/profileimage.jpg'),
                                  ),
                                ),
                              ],
                            ),

                          ),
                          SizedBox(height: 5,),
                          Text(
                            '${userModel?.name}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:  Colors.white,
                              fontSize: 18,
                            ),
                          ), SizedBox(height: 5,),
                          Text(
                            // LEVEL!=null ? LEVEL! : ' ',
                            '${userModel?.level}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:  Colors.white,
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
                                  studentLayoutcubit.get(context).getSupervisorsData();
                                  navigateto(context,  editProfileScreen());
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: cc.defcol,
                                      child: Icon(IconBroken.Edit,
                                          color: Colors.white),
                                    ),
                                    SizedBox(width: 8,),
                                    Text('Edit Profile',style: TextStyle(
                                      fontSize: 19,color:  HexColor('#87b4c6'),
                                    )),
                                    Spacer(),
                                    IconButton(onPressed: (){
                                      studentLayoutcubit.get(context).getSupervisorsData();
                                      navigateto(context,  editProfileScreen());
                                    }, icon: Icon(IconBroken.Arrow___Right,color: defaultcol,))
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigateto(context,  changePasswordScreen());                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: cc.defcol,
                                      child: Icon(IconBroken.Password,
                                          color: Colors.white),
                                    ),
                                    SizedBox(width: 8,),
                                    Text('Change Password',style: TextStyle(
                                      fontSize: 19,color:  HexColor('#87b4c6'),
                                    )),
                                    Spacer(),
                                    IconButton(onPressed: (){
                                      navigateto(context,  changePasswordScreen());
                                    }, icon: Icon(IconBroken.Arrow___Right,color: defaultcol,))
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  studentLayoutcubit.get(context). logoutStudent(context);

                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: cc.defcol,
                                      child: Icon(IconBroken.Logout,
                                          color: Colors.white),
                                    ),
                                    SizedBox(width: 8,),
                                    Text('Logout',style: TextStyle(
                                      fontSize: 19,color:  HexColor('#87b4c6'),
                                    )),
                                    Spacer(),
                                    IconButton(onPressed: (){
                                     studentLayoutcubit.get(context). logoutStudent(context);
                                    }, icon: Icon(IconBroken.Arrow___Right,color: defaultcol,))
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