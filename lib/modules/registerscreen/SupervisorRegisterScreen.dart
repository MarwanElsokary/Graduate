// doctor_register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/modules/loginscreen/loginScreen.dart';
import 'package:project/shared/components/components.dart';
import 'package:project/shared/styles/colors.dart';
import 'registercubit.dart';
import 'registerstates.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class SupervisorRegisterScreen extends StatelessWidget {
  var namecon = TextEditingController();
  var phonecon = TextEditingController();
  var emailcon = TextEditingController();
  var passwordcon = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => registercubit(),
      child: BlocConsumer<registercubit, registerstates>(
        listener: (context, state) {
          if (state is createUserSucessState) {
            showtoast(
              text: 'Registration completed successfully',
              state: toaststates.SUCCESS,
            );
            navigate(context, loginScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/creat_account.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(IconBroken.Arrow___Left_2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF004E7F),
                        fontSize: 28,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            defaulttextformfield(
                              controller: namecon,
                              radius: 30,
                              bordercolor: cc.defcol,
                              maxLength: 30,
                              keyboardtype: TextInputType.name,
                              validator: (value) => value!.isEmpty
                                  ? 'please enter your name'
                                  : null,
                              label: 'Name',
                              prefix: IconBroken.AddUser,
                            ),
                            const SizedBox(height: 25),
                            defaulttextformfield(
                              controller: phonecon,
                              radius: 30,
                              bordercolor: cc.defcol,
                              maxLength: 11,
                              keyboardtype: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'please enter your phone number';
                                if (value.length < 11)
                                  return 'please enter valid phone number';
                                return null;
                              },
                              label: 'Phone Number',
                              prefix: IconBroken.Call,
                            ),
                            const SizedBox(height: 25),
                            defaulttextformfield(
                              controller: emailcon,
                              radius: 30,
                              bordercolor: cc.defcol,
                              keyboardtype: TextInputType.emailAddress,
                              validator: (value) => value!.isEmpty
                                  ? 'please enter your email address'
                                  : null,
                              label: 'Email Address',
                              prefix: IconBroken.Message,
                            ),
                            const SizedBox(height: 25),
                            defaulttextformfield(
                              controller: passwordcon,
                              radius: 30,
                              bordercolor: cc.defcol,
                              keyboardtype: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'please enter your password';
                                if (value.length < 6)
                                  return 'Password must be greater than six characters';
                                return null;
                              },
                              label: 'Password',
                              prefix: IconBroken.Password,
                              suffix: registercubit.get(context).suffix,
                              suffixPressed: () => registercubit
                                  .get(context)
                                  .changepassvisibility(),
                              hidepassword: registercubit.get(context).hidepass,
                            ),
                            const SizedBox(height: 30),
                            ConditionalBuilder(
                              condition: state is! registerLoadingState,
                              builder: (context) => defaultbutton(
                                text: 'Sign Up',
                                radius: 30,
                                onpress: () {
                                  if (formkey.currentState!.validate()) {
                                    registercubit.get(context).userRegister(
                                          name: namecon.text,
                                          email: emailcon.text,
                                          password: passwordcon.text,
                                          phone: phonecon.text,
                                          role: 'Supervisor',
                                          studentId: '',
                                          supervisorId: '',
                                          supervisorName: '',
                                          licenseImage: '',
                                        );
                                  }
                                },
                              ),
                              fallback: (context) =>
                                  const CircularProgressIndicator(),
                            )
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
