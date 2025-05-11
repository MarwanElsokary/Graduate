import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/shared/styles/colors.dart';
import '../../shared/components/components.dart';
import '../loginscreen/loginScreen.dart';
import 'registercubit.dart';
import 'registerstates.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class registerScreen extends StatelessWidget {
  var Idcon = TextEditingController();
  var namecon = TextEditingController();
  var phonecon = TextEditingController();
  var emailcon = TextEditingController();
  var passwordcon = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool ispass = true;
  var supervisorName;
  var supervisorId;
  final ImagePicker picker = ImagePicker();
  File? licenseImage;

  Future<void> pickLicenseImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      licenseImage = File(pickedFile.path);
      // لتحديث الواجهة
      (context as Element).markNeedsBuild();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => registercubit()..getSupervisorsData(),
      child: BlocConsumer<registercubit, registerstates>(
        listener: (context, state) {
          if (state is createUserSucessState) {
            showtoast(
                text: 'Registration completed successfully',
                state: toaststates.SUCCESS);
            navigate(context, loginScreen());
          }
        },
        builder: (context, state) {
          var supervisorModel = registercubit.get(context).supervisors;
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/creat_account.png'),
                  // مسار الصورة من مجلد assets
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 40),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                IconBroken.Arrow___Left_2,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF004E7F),
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
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
                                      defaulttextformfield(
                                        controller: Idcon,
                                        radius: 30,
                                        bordercolor: Color(0xFF6BC9FF),
                                        maxLength: 8,
                                        keyboardtype: TextInputType.number,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'please enter your id';
                                          }
                                        },
                                        label: 'Student Id',
                                        prefix: Icons.numbers_outlined,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      defaulttextformfield(
                                        controller: namecon,
                                        radius: 30,
                                        bordercolor: Color(0xFF6BC9FF),
                                        maxLength: 30,
                                        keyboardtype: TextInputType.name,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'please enter your name';
                                          }
                                        },
                                        label: 'name',
                                        prefix: IconBroken.AddUser,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      defaulttextformfield(
                                        controller: phonecon,
                                        radius: 30,
                                        bordercolor: Color(0xFF6BC9FF),
                                        maxLength: 11,
                                        keyboardtype: TextInputType.phone,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'please enter your phone number';
                                          }
                                          if (value.length < 11) {
                                            return 'please enter valid phone number';
                                          }
                                        },
                                        label: 'phone number',
                                        prefix: IconBroken.Call,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      defaulttextformfield(
                                        controller: emailcon,
                                        radius: 30,
                                        bordercolor: Color(0xFF6BC9FF),
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
                                        bordercolor: Color(0xFF6BC9FF),
                                        keyboardtype:
                                            TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'please enter your  password';
                                          }
                                          if (value.length < 6) {
                                            return 'Password must be greater than six characters';
                                          }
                                        },
                                        label: 'Password',
                                        prefix: IconBroken.Password,
                                        suffix:
                                            registercubit.get(context).suffix,
                                        suffixPressed: () => registercubit
                                            .get(context)
                                            .changepassvisibility(),
                                        hidepassword:
                                            registercubit.get(context).hidepass,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blueAccent
                                                  .withOpacity(0.2),
                                              blurRadius: 10,
                                              offset: Offset(0, 5),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: DropdownButtonFormField(
                                          value: supervisorName,
                                          isExpanded: true,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            label:
                                                Text('Choose your supervisor'),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF6BC9FF),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFF6BC9FF),
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFF6BC9FF),
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                            ),
                                          ),
                                          icon: const Icon(
                                            IconBroken.Arrow___Down_2,
                                            color: cc.defcol,
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please choose your supervisor';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            supervisorName = value;
                                          },
                                          items: supervisorModel.entries
                                              .map((entry) => DropdownMenuItem(
                                                    value: entry.value,
                                                    onTap: () {
                                                      supervisorId = entry.key;
                                                    },
                                                    child: Text(entry.value),
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF004C78),
                                              blurRadius: 10,
                                              offset: Offset(0, 5),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: ConditionalBuilder(
                                          condition:
                                              state is! registerLoadingState,
                                          builder: (context) => defaultbutton(
                                            onpress: () {
                                              if (formkey.currentState!
                                                  .validate()) {
                                                registercubit
                                                    .get(context)
                                                    .userRegister(
                                                      name: namecon.text,
                                                      email: emailcon.text,
                                                      password:
                                                          passwordcon.text,
                                                      phone: phonecon.text,
                                                      studentId: Idcon.text,
                                                      supervisorName:
                                                          supervisorName,
                                                      supervisorId:
                                                          supervisorId,
                                                      role: 'student',
                                                      licenseImage: '',
                                                    );
                                              }
                                            },
                                            text: 'sign up',
                                            upercase: true,
                                            radius: 30,
                                          ),
                                          fallback: (context) => Center(
                                            child: CircularProgressIndicator(),
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

  Future<String> uploadLicenseImageToFirebase() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('doctor_licenses')
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
    await ref.putFile(licenseImage!);
    return await ref.getDownloadURL();
  }
}
