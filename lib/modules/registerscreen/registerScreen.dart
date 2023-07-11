import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/shared/styles/colors.dart';
import '../../shared/components/components.dart';
import '../loginscreen/loginScreen.dart';
import 'registercubit.dart';
import 'registerstates.dart';
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
                  color: defaultcol,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: defaultcol,
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
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Register ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
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
                                          defaulttextformfield(
                                            controller: Idcon,
                                            radius: 30,
                                            maxLength: 4,
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
                                            maxLength: 11,
                                            keyboardtype: TextInputType.phone,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'please enter your phone number';
                                              }
                                              if (value.length<11) {
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
                                            keyboardtype:
                                            TextInputType.visiblePassword,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'please enter your  password';
                                              }
                                              if (value.length<6) {
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
                                          DropdownButtonFormField(
                                            value: supervisorName,
                                            isExpanded: false,
                                            decoration: InputDecoration(
                                              label: Text('choose your supervisor'),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                                borderRadius:
                                                BorderRadius.all(Radius.circular(30)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
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
                                           onChanged: (value) {
                                             supervisorName=value;
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
                                          SizedBox(
                                            height: 15,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          ConditionalBuilder(
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
                                                    password: passwordcon.text,
                                                    phone: phonecon.text,
                                                    studentId: Idcon.text,
                                                    supervisorName:supervisorName ,
                                                    supervisorId:supervisorId ,

                                                    role: 'student',
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
