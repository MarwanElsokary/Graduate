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
            appBar: AppBar(
              backgroundColor:  cc.defcol,
              leading: IconButton(
                onPressed: ()
                {
                  Navigator.pop(context);
                },
                icon: Icon(
                  IconBroken.Arrow___Left_2,color: Colors.white,
                ),
              ),
              titleSpacing: 5.0,
            ),
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
                            'Forget Password ',
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Form(
                              key: formkey,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                             //       crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height:30,
                                    ),
                                    Text(
                                      'Mail Address Here',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultcol,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'enter the email address associated with your account',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,

                                      ),textAlign:  TextAlign.center,
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
                                      height: 10,
                                    ),
                                    ConditionalBuilder(
                                      condition:
                                          state is! loginLoadingState,
                                      builder: (context) => defaultbutton(
                                        onpress: () async {
                                          if (formkey.currentState!
                                              .validate()) {
                                        await  FirebaseAuth.instance.sendPasswordResetEmail(email: emailcon.text).then((value){
                                            showtoast(text: 'check your email', state: toaststates.SUCCESS);
                                            navigate(context, loginScreen());
                                          }).catchError((onError){
                                            print(onError.toString());
                                            showtoast(text: 'can\'t rest your password make sure that you entered your email right', state: toaststates.ERROR);
                                          });
                                          }
                                        },
                                        text: 'recover password  ',
                                        upercase: true,
                                        radius: 30,
                                      ),
                                      fallback: (context) => Center(
                                        child: CircularProgressIndicator(),
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
