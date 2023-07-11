
import 'package:bloc/bloc.dart';
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
 import 'loginstates.dart';


class logincubit extends Cubit<loginstates>{
  logincubit() : super (loginIntialState());

  static logincubit get(context)=> BlocProvider.of(context);
  // var id;
   void userLogin({
    required String email,
    required String password,
  }) {
    emit(loginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {
      await FirebaseMessaging.instance.subscribeToTopic(value.user!.uid);
       emit( loginSucessState(value.user!.uid));
    })
        .catchError((error)
    {
      print(error);
      emit(loginErrorState(error.toString()));
    });
  }
  IconData suffix =  IconBroken.Show;
  bool hidepass =true;
  void changepassvisibility(){
    hidepass=!hidepass;
    suffix=hidepass?IconBroken.Show :IconBroken.Hide;
    emit(chagePassvisibilitystate());

  }
  // Future<void> storeFcmTokenForCurrentUser() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     String? fcmToken = await FirebaseMessaging.instance.getToken();
  //     if (fcmToken != null) {
  //       FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(UID)
  //           .update({'level': level}).then((value){
  //         print('level added');
  //
  //       }).catchError((onError){
  //         print('failed to add level');
  //       });
  //        FirebaseFirestore.instance.doc(UID).child('users/${user.uid}/fcmToken').set(fcmToken);
  //     }
  //   }
  // }

  }

