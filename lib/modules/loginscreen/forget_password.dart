import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/modules/loginscreen/loginScreen.dart';
import 'package:project/shared/components/components.dart';
import '../../shared/styles/colors.dart';
import 'logincubit.dart';
import 'loginstates.dart';

class forgetPasswordScreen extends StatelessWidget {
  var emailcon = TextEditingController();
  var passwordcon = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool ispass = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => logincubit(),
      child: BlocConsumer<logincubit, loginstates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/login_background'),
                  // مسار الصورة من مجلد assets
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: AppBar(
                      backgroundColor: Colors.transparent, // شفافة
                      elevation: 0, // إزالة الظل
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          IconBroken.Arrow___Left_2,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        "Forget password",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF004E7F),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Center(
                            child: Image.asset(
                          'images/forget_password',
                          width: 245,
                          height: 245,
                        )),
                        SizedBox(
                          height: 10,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Form(
                              key: formkey,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Forget your password ?',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF003E65),
                                        fontSize: 24,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '''Please  write your email to recieve
 a confirm code to set a new password''',
                                      style: TextStyle(
                                        color: Color(0xFF003E65),
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Email Address',
                                          style: TextStyle(
                                            color: Color(0xFF004E7F),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    defaulttextformfield(
                                      controller: emailcon,
                                      radius: 30,
                                      bordercolor: Color(0xFF6BC9FF),
                                      keyboardtype: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'please enter your email address';
                                        }
                                      },
                                      label: '',
                                      prefix: IconBroken.Message,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ConditionalBuilder(
                                      condition: state is! loginLoadingState,
                                      builder: (context) => defaultbutton(
                                        onpress: () async {
                                          if (formkey.currentState!
                                              .validate()) {
                                            await FirebaseAuth.instance
                                                .sendPasswordResetEmail(
                                                    email: emailcon.text)
                                                .then((value) {
                                              showtoast(
                                                  text: 'check your email',
                                                  state: toaststates.SUCCESS);
                                              navigate(context, loginScreen());
                                            }).catchError((onError) {
                                              print(onError.toString());
                                              showtoast(
                                                  text:
                                                      'can\'t rest your password make sure that you entered your email right',
                                                  state: toaststates.ERROR);
                                            });
                                          }
                                        },
                                        text: 'Confirm mail',
                                        upercase: true,
                                        radius: 30,
                                      ),
                                      fallback: (context) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
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
