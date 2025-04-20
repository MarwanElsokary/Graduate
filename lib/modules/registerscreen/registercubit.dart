import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/models/user_model.dart';
import 'package:project/shared/components/components.dart';
import 'registerstates.dart';


class registercubit extends Cubit<registerstates> {
  registercubit() : super (registerIntialState());

  static registercubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    String? studentId,
    required String role,
    String? supervisorName,
    String ?supervisorId, required String licenseImage
  }) {
    emit(registerLoadingState());
    FirebaseAuth.instance
      .createUserWithEmailAndPassword(
    email: email,
    password: password,
  ).then((value) {
    createUser(
      name: name,
      email: email,
      phone: phone,
      role: role,
      studentId: studentId,
      uId: value.user!.uid,
      supervisorName: supervisorName as String,
      supervisorId: supervisorId  as String,
    );
  }).catchError((error) {
     emit(registerErrorState(error.toString()) );
    print(error.toString());
     if (error.code == 'email-already-in-use') {
        showtoast(text: 'A user with this email address already exists',
           state: toaststates.ERROR);
     }
     if (error.code == 'invalid-email') {
       showtoast(text: 'The email is invalid',
           state: toaststates.ERROR);
     }
     if (error.code == 'weak-password') {
       showtoast(text: 'Password should be at least 6 characters',
           state: toaststates.ERROR);
     }

  });

  }

  void createUser(
      {
        required String name,
        required String email,
        required String phone,
        required  String role,
        required  String uId,
        required String supervisorName,
        required String supervisorId,
        String? studentId,
        String? image,
      }){   userModel model = userModel(
      studentId: studentId,
      email: email,
      image: image,
      name: name,
      phone: phone,
      role: role,
      uId: uId,
      supervisorName: supervisorName,
      supervisorId: supervisorId
  );
  FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .set(model.tomap())
      .then((value) async {
        //add level of student based on his id
        if(role =='student'){
        var level;
          switch ( studentId![0]) {
            case "4":
              level = 'Level 4';
              break;
            case "5":
              level = 'Level 5';
              break;
            default:
              level = 'Postgraduate ';
              break;
          }
          print(level);
          FirebaseFirestore.instance
              .collection('users')
              .doc(uId)
              .update({'level': level}).then((value){
                print('level added');

          }).catchError((onError){
            print('failed to add level');
          });
        }
    emit(createUserSucessState());
  })
      .catchError((onError){
    emit(createUserErrorState(onError));
  });
  }


  IconData suffix =IconBroken.Show;
  bool hidepass =true;
  void changepassvisibility(){
    hidepass=!hidepass;
    suffix=hidepass?IconBroken.Show :IconBroken.Hide;
    emit(registerChagePassvisibilitystate());

     }


  // Future<void> getSupervisorsData() async{
  //     FirebaseFirestore.instance
  //       .collection('users')
  //       .where('role', isEqualTo: 'Supervisor')
  //       .snapshots()
  //       .listen((event) async {
  //     supervisors={};
  //     await Future.forEach(event.docs, (element) {
  //       supervisors.addEntries({ "${element['uId']}": "${element['name']}"}.entries);
  //         });
  //    emit(GetSupervisorsDataSucessState());
  //    });
  //
  // }
  //show supervisors on system for student to select one
   Map<String,String> supervisors={};
   void getSupervisorsData()  {
    FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'Supervisor')
        .get().then((value) {
      value.docs.forEach((element) {
        supervisors.addEntries({ "${element['uId']}": "${element['name']}"}.entries);
      });
      emit(GetSupervisorsDataSucessState());
    }).catchError((onError){
      print(onError.toString());
    });


  }
}
