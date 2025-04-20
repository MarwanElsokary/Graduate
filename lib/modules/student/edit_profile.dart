import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/layout/student/studentcubit/cubit.dart';
import 'package:project/layout/student/studentcubit/states.dart';
import 'package:project/shared/components/components.dart';
import '../../shared/styles/colors.dart';

class editProfileScreen extends StatelessWidget {
  var namecon = TextEditingController();
  var phonecon = TextEditingController();
  var emailcon = TextEditingController();
  var passwordcon = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var formkey1 = GlobalKey<FormState>();
  var emailchaged = false;
  var supervisorName;
  var supervisorId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<studentLayoutcubit, studentLayoutstates>(
      listener: (context, state) {
        if (state is studentUploadProfileImageSucessState) {
          showtoast(
              text: 'image uploaded sucessfully ', state: toaststates.SUCCESS);
          studentLayoutcubit.get(context).studentSelectedImage = null;
        }
        if (state is studentUpdateScuessState) {
          showtoast(
              text: 'profile uploaded sucessfully ',
              state: toaststates.SUCCESS);
          studentLayoutcubit.get(context).studentSelectedImage = null;
          studentLayoutcubit.get(context).studentProfileImage = null;
          emailchaged = false;
          passwordcon.clear();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var usermodel = studentLayoutcubit.get(context).studentmodel;
        var studentProfileImage =
            studentLayoutcubit.get(context).studentProfileImage;
        var supervisorModel = studentLayoutcubit.get(context).supervisors;
        namecon.text = usermodel!.name!;
        phonecon.text = usermodel.phone!;
        emailcon.text = usermodel.email!;
        supervisorName = usermodel.supervisorName;
        supervisorId = usermodel.supervisorId;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFB8F5FF),
            title: Center(
              child: Text('Edit profile',
                  style: TextStyle(
                    color: Color(0xFF004E7F),
                    fontSize: 20,
                  )),
            ),
            leading: IconButton(
              onPressed: () {
                studentLayoutcubit.get(context).studentSelectedImage = null;
                studentLayoutcubit.get(context).studentProfileImage = null;
                emailchaged = false;
                passwordcon.clear();
                Navigator.pop(context);
              },
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: Color(0xFF004E7F),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  print(passwordcon.text);
                  if (emailchaged == true && passwordcon.text.length > 0) {
                    if (formkey.currentState!.validate()) {
                      studentLayoutcubit.get(context).updateStudentData(
                            name: namecon.text,
                            phone: phonecon.text,
                            email: emailcon.text,
                            supervisorname: supervisorName,
                            supervisorid: supervisorId,
                            password: passwordcon.text,
                          );
                    }
                  } else if (emailchaged == false &&
                      passwordcon.text.length == 0) {
                    if (formkey.currentState!.validate()) {
                      studentLayoutcubit.get(context).updateStudentData(
                            name: namecon.text,
                            phone: phonecon.text,
                            email: emailcon.text,
                            supervisorname: supervisorName,
                            supervisorid: supervisorId,
                            password: passwordcon.text,
                          );
                    }
                  } else {
                    showtoast(
                        text:
                            'you must enter your password if you want to change your email',
                        state: toaststates.ERROR);
                  }
                },
                icon: Icon(
                  Icons.check,
                  color: Color(0xFF004E7F),
                ),
              )
            ],
          ),
          body: Container(
            color: Color(0xFFB8F5FF),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    color: Color(0xFFB8F5FF),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ConditionalBuilder(
                            condition: usermodel.image != null,
                            fallback: (context) => Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                SizedBox(
                                  height: 3,
                                ),
                                CircleAvatar(
                                  radius: 54.0,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: studentProfileImage == null
                                        ? AssetImage('images/profileimage.jpg')
                                        : FileImage(studentProfileImage)
                                            as ImageProvider,
                                  ),
                                ),
                                IconButton(
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 16.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    studentLayoutcubit
                                        .get(context)
                                        .getStudentImage();
                                  },
                                ),
                              ],
                            ),
                            builder: (context) => Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                SizedBox(
                                  height: 3,
                                ),
                                CircleAvatar(
                                  radius: 54.0,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: studentProfileImage == null
                                        ? NetworkImage(
                                            '${usermodel.image}',
                                          )
                                        : FileImage(studentProfileImage)
                                            as ImageProvider,
                                  ),
                                ),
                                IconButton(
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 16.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    studentLayoutcubit
                                        .get(context)
                                        .getStudentImage();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
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
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          if (studentLayoutcubit
                                                  .get(context)
                                                  .studentSelectedImage !=
                                              null)
                                            defaultbutton(
                                              onpress: () {
                                                studentLayoutcubit
                                                    .get(context)
                                                    .uploadStudentProfileImage(
                                                        // name: namecon.text,
                                                        // phone: phonecon.text,
                                                        // email: emailcon.text,
                                                        // supervisorname: supervisorName,
                                                        // supervisorid: supervisorId
                                                        );
                                              },
                                              text: 'upload profile image',
                                              radius: 30,
                                            ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          if (state
                                              is studentUpdateLoadingState)
                                            LinearProgressIndicator(),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  'Name',
                                  style: TextStyle(
                                    color: Color(0xFF004E7F),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                defaulttextformfield(
                                  controller: namecon,
                                  radius: 30,
                                  bordercolor: Color(0xFF6BC9FF),
                                  keyboardtype: TextInputType.name,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'name must not be empty';
                                    }
                                  },
                                  label: '',
                                  prefix: IconBroken.User,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  'Email Address',
                                  style: TextStyle(
                                    color: Color(0xFF004E7F),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                defaulttextformfield(
                                  controller: emailcon,
                                  radius: 30,
                                  bordercolor: Color(0xFF6BC9FF),
                                  onshange: (p0) {
                                    emailchaged = true;
                                  },
                                  keyboardtype: TextInputType.text,
                                  ontap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        title: Text(
                                          'You have to enter your password to change your email',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        content: Form(
                                          key: formkey1,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              defaulttextformfield(
                                                controller: emailcon,
                                                radius: 30,
                                                onshange: (p0) {
                                                  emailchaged = true;
                                                },
                                                keyboardtype:
                                                    TextInputType.text,
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return 'Email must not be empty';
                                                  }
                                                },
                                                label: '',
                                                prefix: IconBroken.Message,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              defaulttextformfield(
                                                controller: passwordcon,
                                                radius: 30,
                                                keyboardtype: TextInputType
                                                    .visiblePassword,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'please enter your  password';
                                                  }
                                                },
                                                label: '',
                                                prefix: IconBroken.Password,
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              if (formkey1.currentState!
                                                  .validate()) {
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Text(
                                              'Done',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Email must not be empty';
                                    }
                                  },
                                  label: '',
                                  prefix: IconBroken.Message,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  'Phone',
                                  style: TextStyle(
                                    color: Color(0xFF004E7F),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                defaulttextformfield(
                                  controller: phonecon,
                                  bordercolor: Color(0xFF6BC9FF),
                                  radius: 30,
                                  keyboardtype: TextInputType.phone,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'phone number must not be empty';
                                    }
                                  },
                                  label: '',
                                  prefix: IconBroken.Call,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  'choose your supervisor',
                                  style: TextStyle(
                                    color: Color(0xFF004E7F),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                DropdownButtonFormField(
                                  //        value:usermodel.supervisorName== '' || usermodel.supervisorName== null ? supervisorName : usermodel.supervisorName,
                                  value: supervisorName,
                                  isExpanded: false,
                                  decoration: InputDecoration(
                                    label: Text(''),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF6BC9FF),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF6BC9FF),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                  ),
                                  icon: const Icon(
                                    IconBroken.Arrow___Down_2,
                                    color: cc.defcol,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'please choose  your supervisor ';
                                    }
                                  },
                                  onChanged: (value1) {
                                    supervisorName = value1;
                                  },

                                  items: supervisorModel
                                      .map((id, name) {
                                        return MapEntry(
                                            name,
                                            DropdownMenuItem(
                                              value: name,
                                              onTap: () {
                                                supervisorId = id;
                                              },
                                              child: Text(name),
                                            ));
                                      })
                                      .values
                                      .toList(),
                                ),
                              ],
                            ),
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
