import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:icon_broken/icon_broken.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/layout/student/studentcubit/states.dart';
import 'package:project/modules/student/edit_profile.dart';
import 'package:project/shared/components/components.dart';
import 'package:project/shared/network/local/cache_helper.dart';

import '../../../models/case_model.dart';
import '../../../models/request.dart';
import '../../../models/user_model.dart';
import '../../../modules/loginscreen/loginScreen.dart';
import '../../../modules/student/categories/categories_screen.dart';
import '../../../modules/student/home_screen.dart';
import '../../../modules/student/profile_screen.dart';
import '../../../modules/student/requests_screen.dart';
import '../../../shared/components/constants.dart';

class studentLayoutcubit extends Cubit<studentLayoutstates> {
  studentLayoutcubit() : super(studentIntialstate());
  static studentLayoutcubit get(context) => BlocProvider.of(context);
  Future<void> studentsetupInteractedMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(context, message);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.notification?.body ==
        'Your supervisor account has been deleted') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => editProfileScreen()),
      );
    }
    if (message.notification?.body == 'your request has been approved') {
      changebottom(2);
    }
    if (message.notification?.body == 'your request has been rejected') {
      changebottom(2);
    }
  }

  int currentIndex = 0;
  List<Widget> studentBottomScreens = [
    studentHomeScreen(),
    categoriesScreen(),
    studentRequestScreen(),
    studentProfileScreen(),
  ];

  // get function
  void changebottom(int index) {
    currentIndex = index;
    emit(studentChangeBottomNavstate());
  }

  //get image function
  userModel? studentmodel;
  Future<void> getStudentData() async {
    emit(studentGetuserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(UID)
        .snapshots()
        .listen((event) {
      if (event.data() != null)
        studentmodel = userModel.fromjson(event.data()!);
      switch (studentmodel!.studentId![0]) {
        case "4":
          LEVEL = 'Level 4';
          break;
        case "5":
          LEVEL = 'Level 5';
          break;
        default:
          LEVEL = 'postgraduate ';
          break;
      }
      emit(studentGetuserSucessState());
    });
  }

  File? studentSelectedImage;
  var studentProfileImage;
  var picker = ImagePicker();
  Future<void> getStudentImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    studentSelectedImage = null;
    studentProfileImage = null;
    if (pickedFile != null) {
      studentSelectedImage = File(pickedFile.path);
      studentProfileImage = await FlutterImageCompress.compressAndGetFile(
          studentSelectedImage!.absolute.path,
          studentSelectedImage!.path + 'compressed.jpg',
          quality: 40);
      emit(studentProfileImagePickedSucessState());
    } else {
      print('No Image Selected.');
      emit(studentProfileImagePickedErrorState());
    }
  }

// upload image function
  String? imageurl;
  void uploadStudentProfileImage() {
    imageurl = null;
    emit(studentUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(studentProfileImage!.path).pathSegments.last}')
        .putFile(studentProfileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        imageurl = value;
        emit(studentUploadProfileImageSucessState());
      }).catchError((error) {
        emit(studentUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(studentUploadProfileImageErrorState());
    });
  }

  // update function
  Future<void> updateStudentData({
    required String name,
    required String phone,
    required String email,
    required String supervisorname,
    required String supervisorid,
    String? password,
    String? image,
  }) async {
    userModel model = userModel(
      email: email,
      name: name,
      phone: phone,
      supervisorName: supervisorname,
      supervisorId: supervisorid,
      studentId: studentmodel?.studentId,
      image: imageurl ?? studentmodel?.image,
      role: studentmodel?.role,
      uId: studentmodel?.uId,
      level: LEVEL,
    );
    print(password);
    if (password!.length > 0!) {
      var user = FirebaseAuth.instance.currentUser;
      var cred = EmailAuthProvider.credential(
          email: user!.email!, password: password.toString());
      await user?.reauthenticateWithCredential(cred).then((value) async {
        user?.updateEmail(email);
        print(FirebaseAuth.instance.currentUser?.email);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(UID)
            .update(model.tomap())
            .then((value) async {
          await FirebaseFirestore.instance
              .collection('requests')
              .where('studentId', isEqualTo: UID)
              .get()
              .then((value) {
            print(value.docs.length);
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('requests')
                  .doc(element.id)
                  .update({
                'studentImage': '${imageurl ?? studentmodel?.image}',
                'studentName': name
              }).then((value) {
                print('requests updated successfully');
              }).catchError((error) {
                print('Error updating requests: $error');
              });
            });
          });
          getStudentData();
          emit(studentUpdateScuessState());
        }).catchError((e) {
          if (e.code == 'wrong-password')
            showtoast(
                text: 'the password you entered is invalid ',
                state: toaststates.ERROR);
          emit(studentUpdateErrorState());
        });
      }).catchError((onError) {
        if (onError.code == 'wrong-password')
          showtoast(
              text: 'the password you entered is invalid ',
              state: toaststates.ERROR);
        print(onError.toString());
        emit(studentUpdateErrorState());
      });
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UID)
          .update(model.tomap())
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('requests')
            .where('studentId', isEqualTo: UID)
            .get()
            .then((value) {
          print(value.docs.length);
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection('requests')
                .doc(element.id)
                .update({
              'studentImage': '${imageurl ?? studentmodel?.image}',
              'studentName': name
            }).then((value) {
              print('requests updated successfully');
            }).catchError((error) {
              print('Error updating requests: $error');
            });
          });
        });
        getStudentData();
        emit(studentUpdateScuessState());
      }).catchError((e) {
        emit(studentUpdateErrorState());
      });
    }
  }

  // suffix icon
  IconData suffix = IconBroken.Show;
  bool hidepass = true;

  void changepassvisibility() {
    hidepass = !hidepass;
    suffix = hidepass ? IconBroken.Show : IconBroken.Hide;
    emit(studentChagePassvisibilitystate());
  }

  //change password function
  var auth = FirebaseAuth.instance;
  var currentStudentuser = FirebaseAuth.instance.currentUser;

  void changePassword({email, oldPassword, newPassword}) async {
    emit(studentChangePasswordLoadingState());
    var cred = EmailAuthProvider.credential(
        email: currentStudentuser!.email!, password: oldPassword);
    await currentStudentuser?.reauthenticateWithCredential(cred).then((value) {
      currentStudentuser?.updatePassword(newPassword);
      emit(studentChangePasswordSucessState());
    }).catchError((error) {
      emit(studentChangePasswordErrorState());
    });
  }

  Map<String, String> supervisors = {};

  void getSupervisorsData() {
    FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'Supervisor')
        .snapshots()
        .listen((event) {
      supervisors = {};
      event.docs.forEach((element) {
        supervisors
            .addEntries({"${element['uId']}": "${element['name']}"}.entries);
      });
      print(supervisors);
      emit(studentGetSupervisorsDataSucessState());
    });
  }

  List<caseModel> studentCases = [];
  Future<void> studentGetCases() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(UID)
        .get()
        .then((value) {
      print(value.data());
      studentmodel = userModel.fromjson(value.data()!);
      switch (studentmodel!.studentId![0]) {
        case "4":
          LEVEL = 'Level 4';
          break;
        case "5":
          LEVEL = 'Level 5';
          break;
        default:
          LEVEL = 'postgraduate ';
          break;
      }
      FirebaseFirestore.instance
          .collection('cases')
          .where('caseState', isEqualTo: 'WAITING')
          .where('level', isEqualTo: LEVEL)
          .snapshots()
          .listen((event) {
        studentCases = [];
        event.docs.forEach((element) {
          studentCases.add(caseModel.fromjson(element.data()));
        });
        emit(studentGetCasesSucessState());
      });
      emit(studentGetuserSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(studentGetuserErrorState(error.toString()));
    });
  }

  caseModel? studentClickcase;
  Future<void> studentGetCase(String uidpost) async {
    emit(studentGetuserLoadingState());
    await FirebaseFirestore.instance
        .collection('cases')
        .doc(uidpost)
        .snapshots()
        .listen((event) {
      print(event.data());
      studentClickcase = caseModel.fromjson(event.data()!);
      emit(studentGetClickedCaseSucessState());
    });
  }

  //get cases of each category
  List<caseModel> completeCases = [];
  List<caseModel> completeCasesMax = [];
  List<caseModel> completeCasesMan = [];
  Future<void> getCompleteCases() async {
    await FirebaseFirestore.instance
        .collection('cases')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .where('maxillaryCategory', isEqualTo: 'Maxillary Complete Denture')
        .snapshots()
        .listen((event) async {
      completeCasesMax = [];
      await Future.forEach(event.docs, (element) {
        completeCasesMax.add(caseModel.fromjson(element.data()));
      });
    });
    await FirebaseFirestore.instance
        .collection('cases')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .where('mandibularCategory', isEqualTo: 'Mandibular Complete Denture')
        .snapshots()
        .listen((event) async {
      completeCasesMan = [];
      await Future.forEach(event.docs, (element) {
        completeCasesMan.add(caseModel.fromjson(element.data()));
      });
      completeCases = [];
      completeCases.addAll(completeCasesMan);
      completeCases.addAll(completeCasesMax);
      final ids = completeCases.map((e) => e.caseId).toSet();
      completeCases.retainWhere((x) => ids.remove(x.caseId));
      print(completeCases.length);
      emit(studentGetCompleteCasesSucessState());
    });
  }

  List<caseModel> completeFlatCases = [];
  List<caseModel> completeFlatCasesMax = [];
  List<caseModel> completeFlatCasesMan = [];
  Future<void> getCompleteFlatCases() async {
    await FirebaseFirestore.instance
        .collection('cases')
        .where('maxillarySubCategory', isEqualTo: 'Flat Ridge')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      completeFlatCasesMax = [];
      await Future.forEach(event.docs, (element) {
        completeFlatCasesMax.add(caseModel.fromjson(element.data()));
      });
    });
    await FirebaseFirestore.instance
        .collection('cases')
        .where('mandibularSubCategory', isEqualTo: 'Flat Ridge')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      completeFlatCasesMan = [];
      await Future.forEach(event.docs, (element) {
        completeFlatCasesMan.add(caseModel.fromjson(element.data()));
      });
      completeFlatCases = [];
      completeFlatCases.addAll(completeFlatCasesMan);
      completeFlatCases.addAll(completeFlatCasesMax);
      //to filter  duplicates
      final ids = completeFlatCases.map((e) => e.caseId).toSet();
      completeFlatCases.retainWhere((x) => ids.remove(x.caseId));
      print(completeFlatCases.length);
      emit(studentGetCompleteFlatCasesSucessState());
    });
  }

  List<caseModel> completeWellCases = [];
  List<caseModel> completeWellCasesMax = [];
  List<caseModel> completeWellCasesMan = [];

  Future<void> getCompleteWellCases() async {
    await FirebaseFirestore.instance
        .collection('cases')
        .where('maxillarySubCategory', isEqualTo: 'Well Developed Ridge')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      completeWellCasesMax = [];
      await Future.forEach(event.docs, (element) {
        completeWellCasesMax.add(caseModel.fromjson(element.data()));
      });
    });
    await FirebaseFirestore.instance
        .collection('cases')
        .where('mandibularSubCategory', isEqualTo: 'Well Developed Ridge')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      completeWellCasesMan = [];
      await Future.forEach(event.docs, (element) {
        completeWellCasesMan.add(caseModel.fromjson(element.data()));
      });
      completeWellCases = [];
      completeWellCases.addAll(completeWellCasesMan);
      completeWellCases.addAll(completeWellCasesMax);
      //to filter  duplicates
      final ids = completeWellCases.map((e) => e.caseId).toSet();
      completeWellCases.retainWhere((x) => ids.remove(x.caseId));
      print(completeWellCases.length);
      emit(studentGetCompleteWellCasesSucessState());
    });
  }

  List<caseModel> partialCases = [];
  List<caseModel> partialCasesMan = [];
  List<caseModel> partialCasesMax = [];
  Future<void> getPartialCases() async {
    await FirebaseFirestore.instance
        .collection('cases')
        .where('maxillaryCategory', isEqualTo: 'Maxillary Partial Denture')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      partialCasesMax = [];
      await Future.forEach(event.docs, (element) {
        partialCasesMax.add(caseModel.fromjson(element.data()));
      });
    });
    await FirebaseFirestore.instance
        .collection('cases')
        .where('mandibularCategory', isEqualTo: 'Mandibular Partial Denture')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      partialCasesMan = [];
      await Future.forEach(event.docs, (element) {
        partialCasesMan.add(caseModel.fromjson(element.data()));
      });

      partialCases = [];
      partialCases.addAll(partialCasesMan);
      partialCases.addAll(partialCasesMax);
      //to filter  duplicates
      final ids = partialCases.map((e) => e.caseId).toSet();
      partialCases.retainWhere((x) => ids.remove(x.caseId));
      print(partialCases.length);

      emit(studentGetPartialCasesSucessState());
    });
  }

  List<caseModel> partialCases1 = [];
  List<caseModel> partialCases1man = [];
  List<caseModel> partialCases1max = [];
  Future<void> getPartial1Cases() async {
    await FirebaseFirestore.instance
        .collection('cases')
        .where('maxillarySubCategory', isEqualTo: 'kennedy |')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      partialCases1max = [];
      await Future.forEach(event.docs, (element) {
        partialCases1max.add(caseModel.fromjson(element.data()));
      });
    });
    await FirebaseFirestore.instance
        .collection('cases')
        .where('mandibularSubCategory', isEqualTo: 'kennedy |')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      partialCases1man = [];
      await Future.forEach(event.docs, (element) {
        partialCases1man.add(caseModel.fromjson(element.data()));
      });
      partialCases1 = [];
      partialCases1.addAll(partialCases1man);
      partialCases1.addAll(partialCases1max);
      //to filter  duplicates
      final ids = partialCases1.map((e) => e.caseId).toSet();
      partialCases1.retainWhere((x) => ids.remove(x.caseId));
      print(partialCases1.length);
      emit(studentGetPartial1CasesSucessState());
    });
  }

  List<caseModel> partialCases2 = [];
  List<caseModel> partialCases2man = [];
  List<caseModel> partialCases2max = [];
  Future<void> getPartial2Cases() async {
    await FirebaseFirestore.instance
        .collection('cases')
        .where('maxillarySubCategory', isEqualTo: 'kennedy ||')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      partialCases2max = [];
      await Future.forEach(event.docs, (element) {
        partialCases2max.add(caseModel.fromjson(element.data()));
      });
    });
    await FirebaseFirestore.instance
        .collection('cases')
        .where('mandibularSubCategory', isEqualTo: 'kennedy ||')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      partialCases2man = [];
      await Future.forEach(event.docs, (element) {
        partialCases2man.add(caseModel.fromjson(element.data()));
      });
      partialCases2 = [];
      partialCases2.addAll(partialCases2man);
      partialCases2.addAll(partialCases2max);
      //to filter  duplicates
      final ids = partialCases2.map((e) => e.caseId).toSet();
      partialCases2.retainWhere((x) => ids.remove(x.caseId));
      print(partialCases2.length);
      emit(studentGetPartial2CasesSucessState());
    });
  }

  List<caseModel> partialCases3 = [];
  List<caseModel> partialCases3man = [];
  List<caseModel> partialCases3max = [];

  Future<void> getPartial3Cases() async {
    await FirebaseFirestore.instance
        .collection('cases')
        .where('maxillarySubCategory', isEqualTo: 'kennedy |||')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      partialCases3max = [];
      await Future.forEach(event.docs, (element) {
        partialCases3max.add(caseModel.fromjson(element.data()));
      });
    });
    await FirebaseFirestore.instance
        .collection('cases')
        .where('mandibularSubCategory', isEqualTo: 'kennedy |||')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      partialCases3man = [];
      await Future.forEach(event.docs, (element) {
        partialCases3man.add(caseModel.fromjson(element.data()));
      });
      partialCases3 = [];
      partialCases3.addAll(partialCases3man);
      partialCases3.addAll(partialCases3max);
      //to filter  duplicates
      final ids = partialCases3.map((e) => e.caseId).toSet();
      partialCases3.retainWhere((x) => ids.remove(x.caseId));
      print(partialCases3.length);
      emit(studentGetPartial3CasesSucessState());
    });
  }

  List<caseModel> partialCases4 = [];
  List<caseModel> partialCases4man = [];
  List<caseModel> partialCases4max = [];

  Future<void> getPartial4Cases() async {
    await FirebaseFirestore.instance
        .collection('cases')
        .where('maxillarySubCategory', isEqualTo: 'kennedy |V')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      partialCases4max = [];
      await Future.forEach(event.docs, (element) {
        partialCases4max.add(caseModel.fromjson(element.data()));
      });
    });
    await FirebaseFirestore.instance
        .collection('cases')
        .where('mandibularSubCategory', isEqualTo: 'kennedy |V')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      partialCases4man = [];
      await Future.forEach(event.docs, (element) {
        partialCases4man.add(caseModel.fromjson(element.data()));
      });
      partialCases4 = [];
      partialCases4.addAll(partialCases4man);
      partialCases4.addAll(partialCases4max);
      //to filter  duplicates
      final ids = partialCases4.map((e) => e.caseId).toSet();
      partialCases4.retainWhere((x) => ids.remove(x.caseId));
      print(partialCases4.length);
      emit(studentGetPartial4CasesSucessState());
    });
  }

  List<caseModel> singleCases = [];
  List<caseModel> singleCasesman = [];
  List<caseModel> singleCasesmax = [];
  Future<void> getSingleCases() async {
    await FirebaseFirestore.instance
        .collection('cases')
        .where('maxillaryCategory', isEqualTo: 'Maxillary Single Denture')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      singleCasesmax = [];
      await Future.forEach(event.docs, (element) {
        singleCasesmax.add(caseModel.fromjson(element.data()));
      });
    });
    await FirebaseFirestore.instance
        .collection('cases')
        .where('mandibularCategory', isEqualTo: 'Mandibular Single Denture')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      singleCasesman = [];
      await Future.forEach(event.docs, (element) {
        singleCasesman.add(caseModel.fromjson(element.data()));
      });
      singleCases = [];
      singleCases.addAll(singleCasesman);
      singleCases.addAll(singleCasesmax);
      //to filter  duplicates
      final ids = singleCases.map((e) => e.caseId).toSet();
      singleCases.retainWhere((x) => ids.remove(x.caseId));
      print(singleCases.length);
      emit(studentGetSingleCasesSucessState());
    });
  }

  List<caseModel> overcases = [];
  List<caseModel> overcasesman = [];
  List<caseModel> overcasesmax = [];

  Future<void> getOverCases() async {
    await FirebaseFirestore.instance
        .collection('cases')
        .where('maxillaryCategory', isEqualTo: 'Maxillary Overdenture')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      overcasesmax = [];
      await Future.forEach(event.docs, (element) {
        overcasesmax.add(caseModel.fromjson(element.data()));
      });
    });
    await FirebaseFirestore.instance
        .collection('cases')
        .where('mandibularCategory', isEqualTo: 'Mandibular Overdenture')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      overcasesman = [];
      await Future.forEach(event.docs, (element) {
        overcasesman.add(caseModel.fromjson(element.data()));
      });
      overcases = [];
      overcases.addAll(overcasesman);
      overcases.addAll(overcasesmax);
      //to filter  duplicates
      final ids = overcases.map((e) => e.caseId).toSet();
      overcases.retainWhere((x) => ids.remove(x.caseId));
      print(overcases.length);
      emit(studentGetOverCasesSucessState());
    });
  }

  List<caseModel> fullMouthCases = [];
  List<caseModel> fullMouthCasesman = [];
  List<caseModel> fullMouthCasesmax = [];
  Future<void> getFullMouthCases() async {
    await FirebaseFirestore.instance
        .collection('cases')
        .where('maxillaryCategory', isEqualTo: 'Full Mouth Rehabilitation')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      print(event.docs.length);
      fullMouthCasesmax = [];
      await Future.forEach(event.docs, (element) {
        fullMouthCasesmax.add(caseModel.fromjson(element.data()));
      });
    });
    await FirebaseFirestore.instance
        .collection('cases')
        .where('mandibularCategory', isEqualTo: 'Full Mouth Rehabilitation')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      print(event.docs.length);

      fullMouthCasesman = [];
      await Future.forEach(event.docs, (element) {
        fullMouthCasesman.add(caseModel.fromjson(element.data()));
      });
      fullMouthCases = [];
      fullMouthCases.addAll(fullMouthCasesman);
      fullMouthCases.addAll(fullMouthCasesmax);
      //to filter  duplicates
      final ids = fullMouthCases.map((e) => e.caseId).toSet();
      fullMouthCases.retainWhere((x) => ids.remove(x.caseId));
      print(fullMouthCases.length);
      emit(studentGetfullMouthCasesSucessState());
    });
  }

  List<caseModel> maxilloCases = [];
  List<caseModel> maxilloCasesmax = [];
  List<caseModel> maxilloCasesman = [];

  Future<void> getMaxilloCases() async {
    await FirebaseFirestore.instance
        .collection('cases')
        .where('maxillaryCategory', isEqualTo: 'Maxillofacial Case')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      maxilloCasesmax = [];
      await Future.forEach(event.docs, (element) {
        maxilloCasesmax.add(caseModel.fromjson(element.data()));
      });
    });
    await FirebaseFirestore.instance
        .collection('cases')
        .where('mandibularCategory', isEqualTo: 'Maxillofacial Case')
        .where('caseState', isEqualTo: 'WAITING')
        .where('level', isEqualTo: LEVEL)
        .snapshots()
        .listen((event) async {
      maxilloCasesman = [];
      await Future.forEach(event.docs, (element) {
        maxilloCasesman.add(caseModel.fromjson(element.data()));
      });
      maxilloCases = [];
      maxilloCases.addAll(maxilloCasesmax);
      maxilloCases.addAll(maxilloCasesman);
      //to filter  duplicates
      final ids = maxilloCases.map((e) => e.caseId).toSet();
      maxilloCases.retainWhere((x) => ids.remove(x.caseId));
      print(maxilloCases.length);
      emit(studentGetMaxilloCasesSucessState());
    });
  }

  Future<void> createRequest({
    required String status,
    required String requestid,
    required String supervisorid,
    required String studentid,
    required String caseid,
    required String dateTime,
    required String patientName,
    required String patientAge,
    required String doctorname,
    required String doctorid,
    String? doctorimage,
    required String studentname,
    String? studentimage,
    required String gender,
    required String patientAddress,
    required String patientPhone,
    required String currentMedications,
    bool? isDiabetes,
    bool? isHypertension,
    bool? isCardiac,
    bool? isAllergies,
    String? allergies,
    required String? others,
    required String level,
    required List<String> images,
    required String maxillaryCategory,
    required String maxillarySubCategory,
    required String maxillaryModification,
    required String mandibularCategory,
    required String mandibularSubCategory,
    required String mandibularModification,
  }) async {
    requestModel model = requestModel(
      maxillaryCategory: maxillaryCategory,
      maxillarySubCategory: maxillarySubCategory,
      maxillaryModification: maxillaryModification,
      mandibularCategory: mandibularCategory,
      mandibularSubCategory: mandibularSubCategory,
      mandibularModification: mandibularModification,
      caseid: caseid,
      requeststatus: status,
      studentid: studentid,
      requestid: requestid,
      supervisorid: supervisorid,
      doctorid: doctorid,
      doctorimage: doctorimage,
      studentimage: studentimage,
      doctorname: doctorname,
      studentname: studentname,
      dateTime: dateTime,
      patientName: patientName,
      patientAge: patientAge,
      gender: gender,
      patientAddress: patientAddress,
      patientPhone: patientPhone,
      currentMedications: currentMedications,
      isDiabetes: isDiabetes,
      isHypertension: isHypertension,
      isCardiac: isCardiac,
      isAllergies: isAllergies,
      allergies: allergies,
      images: images,
      others: others,
      level: level,
    );
    List UIDS = [];
    for (var element in studentCases) {
      if (element.caseId == caseid) {
        if (element.studentRequests != null)
          UIDS!.addAll(element.studentRequests!);
      }
    }
    UIDS.add(UID);
    print(UIDS);
    FirebaseFirestore.instance
        .collection('requests')
        .add(model.tomap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('requests')
          .doc(value.id)
          .update({'requestId': '${value.id}'}).then((value) {
        FirebaseFirestore.instance
            .collection('cases')
            .doc(caseid)
            .update({'studentRequests': UIDS});
      }).catchError((error) {
        print(error.toString());
        emit(studentCreateRequestErrorState(error.toString()));
      });
      showtoast(
          text: ' contact information  Requested successfully',
          state: toaststates.SUCCESS);
      sendnotification(id: supervisorid, name: studentname);
      emit(studentCreateRequestSucessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(studentCreateRequestErrorState(onError.toString()));
    });
  }

  void sendnotification({String? id, String? name}) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charest=UTF-8',
        'Authorization':
            'key=AAAAjD0HKkI:APA91bGAqH0GdLQ1MAIS7oMamohZe-Bfd_Rm7WEhSlPkC1XRBeXHKV4ze1FSPxexmurSEkZvSLDEysS7Ljz4Z-iJPrfZOdlM4h07jV39BbXhjmGTxF8_hyzC-iOKpDlyP-A2TsUNJEbS'
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'title': 'Patient Finder',
            'body': 'you have a request from ${name}',
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          },
          'to': '/topics/${id}'
        },
      ),
    );
  }

  List<requestModel> requestedCasesStudent = [];
  Future<void> getRequestedCases() async {
    FirebaseFirestore.instance
        .collection('requests')
        .where('studentId', isEqualTo: UID)
        .where('requestStatus', isNotEqualTo: 'pending')
        .snapshots()
        .listen((event) {
      requestedCasesStudent = [];

      event.docs.forEach((element) {
        requestedCasesStudent.add(requestModel.fromjson(element.data()));
        getstudentRequestedCases(element['supervisorId']);
      });

      emit(studentGetRequestsSucessState());
    });
  }

  List<userModel> RequestedCasesSupervisor = [];
  void getstudentRequestedCases(String supervisorid) {
    emit(studentGetSupervisorRequestedCasesLoadingState());
    RequestedCasesSupervisor = [];
    FirebaseFirestore.instance
        .collection('users')
        .where('uId', isEqualTo: supervisorid)
        .snapshots()
        .listen((event) {
      print(event.docs.length);
      event.docs.forEach((element) {
        RequestedCasesSupervisor.add(userModel.fromjson(element.data()));
      });
      emit(studentGetSupervisorRequestedCasesSucessState());
    });
  }

  Future<void> logoutStudent(context) async {
    await FirebaseAuth.instance.signOut();

    await cacheHelper.removedata(key: 'uId');
    await cacheHelper.removedata(key: 'role');
    await FirebaseMessaging.instance.unsubscribeFromTopic(UID);
    navigate(context, loginScreen());
    emit(studentlogoutSucessState());
  }

  List<caseModel> search = [];
  List<caseModel> search1 = [];
  List<caseModel> search2 = [];
  List<caseModel> search3 = [];
  List<caseModel> search4 = [];
  void Search(String query) {
    if (query.isNotEmpty) {
      search = [];
      search1 = [];
      search2 = [];
      search3 = [];
      search4 = [];
      search1 = studentCases
          .where((item) => item.mandibularCategory!
              .toLowerCase()!
              .contains(query.toLowerCase()))
          .toList();
      search2 = studentCases
          .where((item) => item.mandibularSubCategory!
              .toLowerCase()!
              .contains(query.toLowerCase()))
          .toList();
      search3 = studentCases
          .where((item) => item.maxillaryCategory!
              .toLowerCase()!
              .contains(query.toLowerCase()))
          .toList();
      search4 = studentCases
          .where((item) => item.maxillarySubCategory!
              .toLowerCase()!
              .contains(query.toLowerCase()))
          .toList();
      search.addAll(search1);
      search.addAll(search2);
      search.addAll(search3);
      search.addAll(search4);
      final ids = search.map((e) => e.caseId).toSet();
      search.retainWhere((x) => ids.remove(x.caseId));
      emit(studentSearchSucessState());
    } else {
      search = [];
      search1 = [];
      search2 = [];
      search3 = [];
      search4 = [];
      print('no available data');
      emit(studentSearchSucessState());
    }
  }

  List<caseModel> casereqstate = [];

  Future<void> deleteRequest(caseid) async {
    await FirebaseFirestore.instance
        .collection('cases')
        .where('caseId', isEqualTo: caseid)
        .get()
        .then((value) async {
      value.docs.forEach((element) {
        List? ids = element.data()['studentRequests'];
        ids?.remove(UID);
        print(ids);
        FirebaseFirestore.instance
            .collection('cases')
            .doc(caseid)
            .update({'studentRequests': ids});
      });
      await FirebaseFirestore.instance
          .collection('requests')
          .where('caseId', isEqualTo: caseid)
          .where('studentId', isEqualTo: UID)
          .get()
          .then((value) async {
        value.docs.forEach((element) {
          FirebaseFirestore.instance
              .collection('requests')
              .doc(element.id)
              .delete()
              .then((value) async {})
              .catchError((error) {
            print('Error deleting requests: $error');
          });
        });
      }).catchError((onError) {
        print('Error deleting requests: $onError');
      });
      showtoast(
          text: 'Request Deleted Sucessfully', state: toaststates.SUCCESS);
      emit(studentDeleteRequestSucessState());
    }).catchError((error) {
      print('Error deleting studentUID: $error');
      emit(studentDeleteRequestErrorState());
    });
  }
}
