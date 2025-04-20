import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:icon_broken/icon_broken.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/layout/supervisor/supervisorcubit/states.dart';
import 'package:project/models/request.dart';
import 'package:project/models/user_model.dart';
import 'package:project/modules/loginscreen/loginScreen.dart';
import 'package:project/modules/supervisor/Home_screen.dart';
import 'package:project/modules/supervisor/requests_screen.dart';
import 'package:project/shared/components/components.dart';
import 'package:project/shared/network/local/cache_helper.dart';

import '../../../models/case_model.dart';
import '../../../modules/supervisor/doctors_list.dart';
import '../../../modules/supervisor/profile.dart';
import '../../../shared/components/constants.dart';

class supervisorLayoutcubit extends Cubit<supervisorLayoutstates> {
  supervisorLayoutcubit() : super(intialstate());

  static supervisorLayoutcubit get(context) => BlocProvider.of(context);
  Future<void> supersetupInteractedMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(context, initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleMessage(context, message);
    });
  }

  void _handleMessage(BuildContext context, RemoteMessage message) {
    changebottomsupervisor(2);
  }

  int currentIndex = 0;
  List<Widget> superbottomScreens = [
    supervisorHomeScreen(),
    doctorsScreen(),
    requestScreen(),
    supervisorProfileScreen(),
  ];
  // get function
  void changebottomsupervisor(int index) {
    currentIndex = index;
    emit(changeBottomNavstate());
  }

  List<userModel> supervisorStudents = [];

  userModel? supervisormodel;
  Future<void> getSupervisorData() async {
    emit(supervisorGetuserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(UID).get().then((value) {
      print(value.data());
      supervisormodel = userModel.fromjson(value.data()!);
      emit(supervisorGetuserSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(supervisorGetuserErrorState(error.toString()));
    });
  }

  Future<void> getSupervisorStudents() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'student')
        .where('supervisorId', isEqualTo: UID)
        .snapshots()
        .listen((event) async {
      supervisorStudents = [];
      await Future.forEach(event.docs, (element) {
        supervisorStudents.add(userModel.fromjson(element.data()));
      });
      emit(supervisorAllSupervisorStudentsSucessState());
    });
  }

  List<userModel> doctors = [];
  Future<void> getAllDoctors() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'Doctor')
        .snapshots()
        .listen((event) {
      doctors = [];

      event.docs.forEach((element) {
        doctors.add(userModel.fromjson(element.data()));
      });

      emit(supervisorGetAllDoctorsSucessState());
    });
  }

  File? supervisorSelectedImage;
  var supervisorProfileImage;
  var picker = ImagePicker();
  Future<void> getSupervisorImage() async {
    supervisorSelectedImage = null;
    supervisorProfileImage = null;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      supervisorSelectedImage = File(pickedFile.path);
      supervisorProfileImage = await FlutterImageCompress.compressAndGetFile(
          supervisorSelectedImage!.absolute.path,
          supervisorSelectedImage!.path + 'compressed.jpg',
          quality: 40);

      emit(supervisorProfileImagePickedSucessState());
    } else {
      print('No Image Selected.');
      emit(supervisorProfileImagePickedErrorState());
    }
  }

  // update function
  String? imageurl;
  void uploadSupervisorProfileImage() async {
    imageurl = null;
    emit(supervisorUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'users/${Uri.file(supervisorProfileImage!.path).pathSegments.last}')
        .putFile(supervisorProfileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        imageurl = value;
        emit(supervisorUploadProfileImageSucessState());
      }).catchError((error) {
        emit(supervisorUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(supervisorUploadProfileImageErrorState());
    });
  }

  Future<void> updateSupervisorData({
    required String name,
    required String phone,
    required String email,
    String? password,
  }) async {
    userModel model = userModel(
      email: email,
      name: name,
      phone: phone,
      studentId: supervisormodel?.studentId,
      image: imageurl ?? supervisormodel?.image,
      role: supervisormodel?.role,
      uId: supervisormodel?.uId,
    );
    if (password!.length > 0!) {
      print('pass');
      var user = FirebaseAuth.instance.currentUser;
      var cred = EmailAuthProvider.credential(
          email: user!.email!, password: password.toString());
      await user?.reauthenticateWithCredential(cred).then((value) async {
        user?.updateEmail(email);

        print(FirebaseAuth.instance.currentUser?.email);
        FirebaseFirestore.instance
            .collection('users')
            .doc(UID)
            .update(model.tomap())
            .then((value) async {
          await getSupervisorStudents();
          supervisorStudents.forEach((element) async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(element.uId)
                .update({'supervisorName': name}).then((value) {
              print('update student also ');
              emit(superUpdateCaseSucessState());
            }).catchError((error) {});
          });
          getSupervisorData();
          emit(supervisorUpdatesucessState());
        }).catchError((onError) {
          if (onError.code == 'wrong-password')
            showtoast(
                text: 'the password you entered is invalid ',
                state: toaststates.ERROR);
          print(onError.toString());
          emit(supervisorUpdateErrorState());
        });
      }).catchError((onError) {
        if (onError.code == 'wrong-password')
          showtoast(
              text: 'the password you entered is invalid ',
              state: toaststates.ERROR);
        print(onError.toString());
        emit(supervisorUpdateErrorState());
      });
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UID)
          .update(model.tomap())
          .then((value) async {
        await getSupervisorStudents();
        supervisorStudents.forEach((element) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(element.uId)
              .update({'supervisorName': name}).then((value) {
            print('update student also ');
            emit(superUpdateCaseSucessState());
          }).catchError((error) {});
        });
        getSupervisorData();
        emit(supervisorUpdatesucessState());
      }).catchError((error) {
        emit(supervisorUpdateErrorState());
      });
    }
  }

  Future<void> deleteSupervisorData({required String password}) async {
    var user = await FirebaseAuth.instance.currentUser;
    AuthCredential credentials = EmailAuthProvider.credential(
        email: user!.email as String, password: password);
    await user!.reauthenticateWithCredential(credentials).then(
      (value) async {
        await value.user?.delete().then((value) async {
          //delete requests to user
          await FirebaseFirestore.instance
              .collection('requests')
              .where('supervisorId', isEqualTo: UID)
              .get()
              .then((value) async {
            print(value.docs.length);
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('requests')
                  .doc(element.id)
                  .delete()
                  .then((value) {
                print('requests deleted successfully');
              }).catchError((error) {
                print('Error deleting requests: $error');
              });
            });
          });
          //delete username&id from students
          await FirebaseFirestore.instance
              .collection('users')
              .where('supervisorId', isEqualTo: UID)
              .get()
              .then((value) async {
            await Future.wait(value.docs
                .map((element) => senddeletenotification(element.id)));
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(element.id)
                  .update({'supervisorId': null, 'supervisorName': null}).then(
                      (value) {
                print('supervisor removed from student sucessfully');
              }).catchError((error) {
                print('Error updating requests: $error');
              });
            });
          });
          //delete user from users table
          await FirebaseFirestore.instance
              .collection('users')
              .doc(UID)
              .delete();
          emit(supervisorDeleteSucessState());
        }).catchError((error) {
          if (error.code == 'wrong-password')
            showtoast(
                text: 'the password you entered is invalid ',
                state: toaststates.ERROR);
          print(error.toString());
          emit(supervisorDeleteErrorState(error.toString()));
        });
      },
    ).catchError((error) {
      if (error.code == 'wrong-password')
        showtoast(
            text: 'the password you entered is invalid ',
            state: toaststates.ERROR);
      print(error.toString());
      emit(supervisorDeleteErrorState(error.toString()));
    });
  }

  Future<void> senddeletenotification(String? id) async {
    print('object2');
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
            'body': 'Your supervisor account has been deleted',
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

  IconData suffix = IconBroken.Show;
  bool hidepass = true;
  void changepassvisibility() {
    hidepass = !hidepass;
    suffix = hidepass ? IconBroken.Show : IconBroken.Hide;
    emit(chagePassvisibilitystate());
  }

//change password function
  var auth = FirebaseAuth.instance;
  var currentSupervisoruser = FirebaseAuth.instance.currentUser;
  void changePassword({email, oldPassword, newPassword}) async {
    emit(supervisorChangePasswordLoadingState());
    var cred = EmailAuthProvider.credential(
        email: currentSupervisoruser!.email!, password: oldPassword);
    await currentSupervisoruser
        ?.reauthenticateWithCredential(cred)
        .then((value) {
      currentSupervisoruser?.updatePassword(newPassword);
      emit(supervisorChangePasswordSucessState());
    }).catchError((error) {
      emit(supervisorChangePasswordErrorState());
    });
  }

  List<caseModel> supervisorCases = [];

  Future<void> supervisorGetCases() async {
    FirebaseFirestore.instance
        .collection('cases')
        .where('caseState', isEqualTo: 'WAITING')
        .snapshots()
        .listen((event) {
      supervisorCases = [];
      event.docs.forEach((element) {
        supervisorCases.add(caseModel.fromjson(element.data()));
      });
      emit(supervisorGetCasesSucessState());
    });
  }

  caseModel? supervisorClickcase;
  Future<void> supervisorGetCase(String uidpost) async {
    emit(supervisorGetuserLoadingState());
    await FirebaseFirestore.instance
        .collection('cases')
        .doc(uidpost)
        .get()
        .then((value) {
      print(value.data());
      supervisorClickcase = caseModel.fromjson(value.data()!);
      emit(supervisorGetClickedCaseSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(supervisorGetClickedCaseErrorState(error.toString()));
    });
  }

  List<caseModel> casesperdoctor = [];
  void supervisorGetCasesPerDoctor(String doctoruid) {
    FirebaseFirestore.instance
        .collection('cases')
        .where('uId', isEqualTo: doctoruid)
        .where('caseState', isEqualTo: 'WAITING')
        .snapshots()
        .listen((event) {
      casesperdoctor = [];
      event.docs.forEach((element) {
        casesperdoctor.add(caseModel.fromjson(element.data()));
      });
      emit(supervisorGetCasesPerDoctorSucessState());
    });
  }

  List<requestModel> requestedCases = [];
  Future<void> getRequestedCases() async {
    FirebaseFirestore.instance
        .collection('requests')
        .where('supervisorId', isEqualTo: UID)
        .where('requestStatus', isEqualTo: 'pending')
        .snapshots()
        .listen((event) {
      requestedCases = [];
      event.docs.forEach((element) async {
        requestedCases.add(requestModel.fromjson(element.data()));
      });
      emit(supervisorGetRequestsSucessState());
    });
  }

  List<requestModel> requestsPerStudent = [];
  Future<void> getRequestsPerStudent(String studentid) async {
    await FirebaseFirestore.instance
        .collection('requests')
        .where('studentId', isEqualTo: studentid)
        .where('requestStatus', isEqualTo: 'pending')
        .snapshots()
        .listen((event) async {
      requestsPerStudent = [];
      event.docs.forEach((element) {
        requestsPerStudent.add(requestModel.fromjson(element.data()));
      });
      emit(supervisorGetRequestsPerStudentSucessState());
    });
  }

  void updateRequest({
    required String requeststatus,
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
  }) {
    requestModel model = requestModel(
      maxillaryCategory: maxillaryCategory,
      maxillarySubCategory: maxillarySubCategory,
      maxillaryModification: maxillaryModification,
      mandibularCategory: mandibularCategory,
      mandibularSubCategory: mandibularSubCategory,
      mandibularModification: mandibularModification,
      caseid: caseid,
      requeststatus: requeststatus,
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

    FirebaseFirestore.instance
        .collection('requests')
        .doc(requestid)
        .update(model.tomap())
        .then((value) async {
      if (requeststatus == 'accept') sendnotificationAccept(id: studentid);
      if (requeststatus == 'ignore') sendnotificationReject(id: studentid);
      emit(supervisorUpdateRequestedCasesDataSucessState());
    }).catchError((onError) {
      emit(supervisorUpdateRequestedCasesDataErrorState(onError));
    });
  }

  //Diabetes check box
  bool superChangeDiabetes(bool isDiabetes) {
    isDiabetes = !isDiabetes;
    emit(superChangeDiabetesSuccess());
    return isDiabetes;
  }

  //cardiac check box

  bool superChangeCardiac(bool isCardiac) {
    isCardiac = !isCardiac;
    emit(superChangeCardiacSuccess());
    return isCardiac;
  }

  //hypertension check box

  bool superChangeHypertension(bool isHypertension) {
    isHypertension = !isHypertension;
    emit(superChangeHypertensionSuccess());
    return isHypertension;
  }

  //allergies check box
  bool superChangeAllergies(bool isAllergies) {
    isAllergies = !isAllergies;
    emit(superChangeAllergiesSuccess());
    return isAllergies;
  }

  bool isCompleteMAX = false;
  bool showCompleteSubCategoryMAX(value) {
    isCompleteMAX = value;
    emit(supershowCompleteSubcategoryMAX());
    return isCompleteMAX;
  }

  bool isPartialMAX = false;
  bool showPartialSubCategoryMAX(value) {
    isPartialMAX = value;
    emit(supershowPartialSubcategoryMAX());
    return isPartialMAX;
  }

  bool isCompleteMAN = false;
  bool showCompleteSubCategoryMAN(value) {
    isCompleteMAN = value;
    emit(supershowCompleteSubcategoryMAN());
    return isCompleteMAN;
  }

  bool isPartialMAN = false;
  bool showPartialSubCategoryMAN(value) {
    isPartialMAN = value;
    emit(supershowPartialSubcategoryMAN());
    return isPartialMAN;
  }

  bool isMaxillofacial = false;
  bool IsMaxillofacial(value) {
    isMaxillofacial = value;
    emit(superisMaxilloFacial());
    return isMaxillofacial;
  }

  bool isFullmouth = false;
  bool IsFullmouth(value) {
    isFullmouth = value;
    emit(superisfullmouth());
    return isFullmouth;
  }

  void updateCase({
    required String name,
    required String uId,
    required String? image,
    required String dateTime,
    required String patientName,
    required String patientAge,
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
    required String maxillaryCategory,
    required String maxillarySubCategory,
    required String maxillaryModification,
    required String mandibularCategory,
    required String mandibularSubCategory,
    required String mandibularModification,
    required String level,
    required List<String> images,
    required String caseId,
    required String caseState,
  }) {
    caseModel model = caseModel(
      uId: uId,
      name: name,
      image: image,
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
      others: others,
      maxillaryCategory: maxillaryCategory,
      maxillarySubCategory: maxillarySubCategory,
      maxillaryModification: maxillaryModification,
      mandibularCategory: mandibularCategory,
      mandibularSubCategory: mandibularSubCategory,
      mandibularModification: mandibularModification,
      level: level,
      images: images,
      caseId: caseId,
      caseState: caseState, studentRequests: [],
    );
    FirebaseFirestore.instance
        .collection('cases')
        .doc(caseId)
        .update(model.tomap())
        .then((value) {
      sendnotificationUpdate(id: uId, caseid: caseId);
      emit(superUpdateCaseSucessState());
    }).catchError((error) {
      emit(superUpdateCaseErrorState(error));
    });
  }

  void sendnotificationReject({String? id}) async {
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
            'body': 'your request has been rejected',
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

  void sendnotificationAccept({String? id}) async {
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
            'body': 'your request has been approved',
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

  void removeImage(url) {
    print(url);
    for (var i = 0; i < supervisorClickcase!.images.length; i++) {
      if (supervisorClickcase!.images[i] == url) {
        supervisorClickcase!.images.removeAt(i);
        emit(RemoveImageSuccessState());
      }
    }
  }

  void sendnotificationUpdate({String? id, caseid}) async {
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
            'body': 'your case has been updated',
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'case_id': caseid,
          },
          'to': '/topics/${id}'
        },
      ),
    );
  }

  Future<void> logoutSupervisor(context) async {
    await FirebaseAuth.instance.signOut();

    await cacheHelper.removedata(key: 'uId');
    await cacheHelper.removedata(key: 'role');
    await FirebaseMessaging.instance.unsubscribeFromTopic(UID);
    navigate(context, loginScreen());
    emit(supervisorlogoutSucessState());
  }

  List<caseModel> search = [];
  List<caseModel> search1 = [];
  List<caseModel> search2 = [];
  List<caseModel> search3 = [];
  List<caseModel> search4 = [];
  void superSearch(String query) {
    if (query.isNotEmpty) {
      search = [];
      search1 = [];
      search2 = [];
      search3 = [];
      search4 = [];
      search1 = supervisorCases
          .where((item) => item.mandibularCategory!
              .toLowerCase()!
              .contains(query.toLowerCase()))
          .toList();
      search2 = supervisorCases
          .where((item) => item.mandibularSubCategory!
              .toLowerCase()!
              .contains(query.toLowerCase()))
          .toList();
      search3 = supervisorCases
          .where((item) => item.maxillaryCategory!
              .toLowerCase()!
              .contains(query.toLowerCase()))
          .toList();
      search4 = supervisorCases
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
      emit(superSearchSucessState());
    } else {
      search = [];
      search1 = [];
      search2 = [];
      search3 = [];
      search4 = [];
      print('no available data');
      emit(superSearchSucessState());
    }
  }
}
