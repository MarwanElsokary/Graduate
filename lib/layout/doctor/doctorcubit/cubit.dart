import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:project/layout/doctor/doctorcubit/states.dart';
import 'package:project/modules/doctor/profile.dart';
import 'package:project/shared/components/components.dart';
import 'package:project/shared/components/constants.dart';
import 'package:project/shared/network/local/cache_helper.dart';

import '../../../models/case_model.dart';
import '../../../models/user_model.dart';
import '../../../modules/loginscreen/loginScreen.dart';

class doctorLayoutcubit extends Cubit<doctorLayoutstates> {
  doctorLayoutcubit() : super(intialstate());

  static doctorLayoutcubit get(context) => BlocProvider.of(context);
  Future<void> doctorsetupInteractedMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(context, initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleMessage(context, message);
    });
  }

  Future<void> _handleMessage(
      BuildContext context, RemoteMessage message) async {
    if (message.data['case_id'] != null) {
      // await doctorGetCase(message.data['case_id']);
      // Navigator.of(context).push(
      // MaterialPageRoute(builder: (_) => doctorPostScreen()),
      // );
    }
  }

  int currentIndex = 0;
  List<Widget> doctorbottomScreens = [
    // doctorHomeScreen(),
    // newPostScreen1(),
    doctorProfileScreen(),
  ];

// get function
  void changebottomdoctor(int index) {
    currentIndex = index;
    emit(changeBottomNavstate());
  }

  userModel? doctormodel;

  Future<void> getDoctorData() async {
    emit(doctorGetuserLoadingState());
    doctormodel == null;
    FirebaseFirestore.instance.collection('users').doc(UID).get().then((value) {
      print(value.data());
      doctormodel = userModel.fromjson(value.data()!);
      emit(doctorGetuserSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(doctorGetuserErrorState(error.toString()));
    });
  }

//get image function
  File? doctorSelectedImage;
  var doctorProfileImage;
  var picker = ImagePicker();

  Future<void> getDoctorImage() async {
    doctorSelectedImage = null;
    doctorProfileImage = null;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      doctorSelectedImage = File(pickedFile.path);
      doctorProfileImage = await FlutterImageCompress.compressAndGetFile(
          doctorSelectedImage!.absolute.path,
          doctorSelectedImage!.path + 'compressed.jpg',
          quality: 40);
      emit(doctorProfileImagePickedSucessState());
    } else {
      print('No Image Selected.');
      emit(doctorProfileImagePickedErrorState());
    }
  }

// upload image function
  String? imageurl;
  void uploadDoctorProfileImage() {
    imageurl = null;
    emit(doctorUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(doctorProfileImage!.path).pathSegments.last}')
        .putFile(doctorProfileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        imageurl = value;
        emit(doctorUploadProfileImageSucessState());
      }).catchError((error) {
        emit(doctorUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(doctorUploadProfileImageErrorState());
    });
  }

// update function
  Future<void> updateDoctorData({
    required String name,
    required String phone,
    required String email,
    String? password,
    String? image,
  }) async {
    userModel model = userModel(
      email: email,
      name: name,
      phone: phone,
      studentId: doctormodel?.studentId,
      image: imageurl ?? doctormodel?.image,
      role: doctormodel?.role,
      uId: doctormodel?.uId,
    );

    if (password!.length > 0) {
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
              .collection('cases')
              .where('uId', isEqualTo: UID)
              .get()
              .then((value) {
            print(value.docs.length);
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('cases')
                  .doc(element.id)
                  .update({
                'image': '${imageurl ?? doctormodel?.image}',
                'name': name
              }).then((value) {
                print('case updated successfully');
              }).catchError((error) {
                print('Error updating case: $error');
              });
            });
          });
          await FirebaseFirestore.instance
              .collection('requests')
              .where('doctorId', isEqualTo: UID)
              .get()
              .then((value) {
            print(value.docs.length);

            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('requests')
                  .doc(element.id)
                  .update({
                'doctorImage': '${imageurl ?? doctormodel?.image}',
                'doctorName': name
              }).then((value) {
                print('requests updated successfully');
              }).catchError((error) {
                print('Error updating requests: $error');
              });
            });
          });
          getDoctorData();
          emit(doctorUpdatesucessState());
        }).catchError((e) {
          if (e.code == 'wrong-password')
            showtoast(
                text: 'the password you entered is invalid ',
                state: toaststates.ERROR);
          emit(doctorUpdateErrorState());
        });
      }).catchError((onError) {
        if (onError.code == 'wrong-password')
          showtoast(
              text: 'the password you entered is invalid ',
              state: toaststates.ERROR);
        print(onError.toString());
        emit(doctorUpdateErrorState());
      });
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UID)
          .update(model.tomap())
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('cases')
            .where('uId', isEqualTo: UID)
            .get()
            .then((value) {
          print(value.docs.length);
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection('cases')
                .doc(element.id)
                .update({
              'image': '${imageurl ?? doctormodel?.image}',
              'name': name
            }).then((value) {
              print('case updated successfully');
            }).catchError((error) {
              print('Error updating case: $error');
            });
          });
        });
        await FirebaseFirestore.instance
            .collection('requests')
            .where('doctorId', isEqualTo: UID)
            .get()
            .then((value) {
          print(value.docs.length);
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection('requests')
                .doc(element.id)
                .update({
              'doctorImage': '${imageurl ?? doctormodel?.image}',
              'doctorName': name
            }).then((value) {
              print('requests updated successfully');
            }).catchError((error) {
              print('Error updating requests: $error');
            });
          });
        });
        getDoctorData();
        emit(doctorUpdatesucessState());
      }).catchError((e) {
        emit(doctorUpdateErrorState());
      });
    }
  }

  // suffix icon
  IconData suffix = IconBroken.Show;
  bool hidepass = true;

  void changepassvisibility() {
    hidepass = !hidepass;
    suffix = hidepass ? IconBroken.Show : IconBroken.Hide;
    emit(chagePassvisibilitystate());
  }

  //change password function
  var auth = FirebaseAuth.instance;
  var currentDoctoruser = FirebaseAuth.instance.currentUser;

  void changePassword({
    email,
    oldPassword,
    newPassword,
  }) async {
    emit(doctorChangePasswordLoadingState());
    var cred = EmailAuthProvider.credential(
        email: currentDoctoruser!.email!, password: oldPassword);
    await currentDoctoruser?.reauthenticateWithCredential(cred).then((value) {
      currentDoctoruser?.updatePassword(newPassword);
      emit(doctorChangePasswordSucessState());
    }).catchError((error) {
      emit(doctorChangePasswordErrorState());
      print(error.toString());
    });
  }

  List<XFile> selectedImages = [];
  final ImagePicker picker2 = ImagePicker();
  Future<void> selectImages() async {
    try {
      final List<XFile>? pickedFile = await picker2.pickMultiImage();
      if (pickedFile!.isNotEmpty || pickedFile != null) {
        selectedImages.addAll(pickedFile);
        print(selectedImages.length);
        // analyzeImage(selectedImages);
        emit(casePostImagePickedSuccessState());
      }
    } catch (e) {
      print('something Wrong' + e.toString());
      emit(casePostImagePickedErrorState());
    }
  }

  List<String> imagesUrl = [];
  Future<void> uploadFunction(List<XFile> images) async {
    for (int i = 0; i < images.length; i++) {
      var imageUrl = await uploadFile(images[i]);
      imagesUrl.add(imageUrl.toString());
    }
  }

  Future<String> uploadFile(XFile image) async {
    final compresedimage = await FlutterImageCompress.compressAndGetFile(
        image.path, image.path + 'compressed.jpg',
        quality: 40);

    Reference reference =
        FirebaseStorage.instance.ref().child('cases/${image.name}');
    UploadTask uploadTask = reference.putFile(File(compresedimage!.path));
    await uploadTask.whenComplete(() {});
    return await reference.getDownloadURL();
  }

  List<PickedFile> takedImages = [];
  final ImagePicker picker3 = ImagePicker();

  Future<void> takeImages() async {
    try {
      final PickedFile? img =
          (await picker3.pickImage(source: ImageSource.camera)) as PickedFile?;
      if (img != null) {
        takedImages.add(img);
        // analyzeImage(takedImages);
        emit(casePostImageTakedSuccessState());
      }
    } catch (e) {
      print('something Wrong' + e.toString());
      emit(casePostImageTakedErrorState());
    }
  }

  static const _labelsFileName = 'assets/labels.txt';
  static const _modelFileName = 'DentalModel.tflite';
  // late Classifier _classifier;
  Future<void> loadClassifier() async {
    debugPrint(
      'Start loading of Classifier with '
      'labels at $_labelsFileName, '
      'model at $_modelFileName',
    );

    //   final classifier = await Classifier.loadWith(
    //     labelsFileName: _labelsFileName,
    //     modelFileName: _modelFileName,
    //   );
    //   _classifier = classifier!;
    // }

    var labels = <String, String>{};
    Future<void> analyzeImage(List images) async {
      emit(loadingLabels());
      for (final image in images) {
        final bytes = await image.readAsBytes();
        final imageInput = img.decodeImage(bytes)!;
        // final resultCategory = _classifier.predict(imageInput);
        // final claificationLabel = resultCategory.label;
        // labels[image.path] = claificationLabel;
      }
      emit(sucessloadingLabels());
    }

    Future<void> uploadFunction1(List<PickedFile> images) async {
      for (int i = 0; i < images.length; i++) {
        // var imageUrl = await uploadFile1(images[i]);
        // imagesUrl.add(imageUrl.toString());
      }
    }

    Future<String> uploadFile1(PickedFile image) async {
      final compresedimage = await FlutterImageCompress.compressAndGetFile(
          image.path, image.path + 'compressed.jpg',
          quality: 40);
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('cases/${Uri.file(image.path).pathSegments.last}');
      UploadTask uploadTask = reference.putFile(File(compresedimage!.path));
      await uploadTask.whenComplete(() {});
      return await reference.getDownloadURL();
    }

    late String globalcaseid;
    Future<void> uploadCaseImage({
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
    }) async {
      emit(doctorNewPostLoadingState());
      imagesUrl = [];
      await uploadFunction(selectedImages);
      await uploadFunction1(takedImages);
      print(imagesUrl.length);
      // createCase(
      //   dateTime: dateTime,
      //   patientName: patientName,
      //   patientAge: patientAge,
      //   gender: gender,
      //   patientAddress: patientAddress,
      //   patientPhone: patientPhone,
      //   currentMedications: currentMedications,
      //   isHypertension: isHypertension,
      //   isDiabetes: isDiabetes,
      //   isCardiac: isCardiac,
      //   isAllergies: isAllergies,
      //   allergies: allergies,
      //   others: others,
      //   maxillaryCategory: maxillaryCategory,
      //   maxillarySubCategory: maxillarySubCategory,
      //   maxillaryModification: maxillaryModification,
      //   mandibularCategory: mandibularCategory,
      //   mandibularSubCategory: mandibularSubCategory,
      //   mandibularModification: mandibularModification,
      //   level: level,
      //   images: imagesUrl,
      //   caseId: '',
      //   caseState: 'WAITING',
      // );
    }

    void createCase({
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
        uId: doctormodel?.uId,
        name: doctormodel?.name,
        image: doctormodel?.image,
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
        caseState: caseState,
        studentRequests: [],
      );
      FirebaseFirestore.instance
          .collection('cases')
          .add(model.tomap())
          .then((value) {
        FirebaseFirestore.instance
            .collection('cases')
            .doc(value.id)
            .update({'caseId': '${value.id}'}).then((value) {
          print('add post id ');
          emit(doctorUpdateCasesSucessState());
        }).catchError((error) {
          emit(doctorUpdateCasesErrorState(error));
        });
        emit(doctorNewPostSucessState());
      }).catchError((error) {
        emit(doctorNewPostErrorState(error));
      });
    }

    //Diabetes check box
    bool isDiabetes = false;
    bool changeDiabetes() {
      isDiabetes = !isDiabetes;
      emit(changeDiabetesSuccess());
      return isDiabetes;
    }

    //cardiac check box
    bool isCardiac = false;
    bool changeCardiac() {
      isCardiac = !isCardiac;
      emit(changeCardiacSuccess());
      return isCardiac;
    }

    //hypertension check box
    bool isHypertension = false;
    bool changeHypertension() {
      isHypertension = !isHypertension;
      emit(changeHypertensionSuccess());
      return isHypertension;
    }

    //allergies check box
    bool isAllergies = false;
    bool changeAllergies() {
      isAllergies = !isAllergies;
      emit(changeAllergiesSuccess());
      return isAllergies;
    }

    List<caseModel> doctorCases = [];

    Future<void> docotrGetCases() async {
      FirebaseFirestore.instance
          .collection('cases')
          .where('caseState', isEqualTo: 'WAITING')
          .snapshots()
          .listen((event) {
        doctorCases = [];
        event.docs.forEach((element) {
          doctorCases.add(caseModel.fromjson(element.data()));
        });
        emit(doctorGetCasesSucessState());
      });
    }

    caseModel? doctorClickcase;
    Future<void> doctorGetCase(String uidpost) async {
      emit(doctorGetuserLoadingState());
      await FirebaseFirestore.instance
          .collection('cases')
          .doc(uidpost)
          .get()
          .then((value) {
        print(value.data());
        doctorClickcase = caseModel.fromjson(value.data()!);
        emit(doctorGetClickedCaseSucessState());
      }).catchError((error) {
        print(error.toString());
        emit(doctorGetClickedCaseErrorState(error.toString()));
      });
    }

    void removePostImage(path) {
      print(path);
      for (var i = 0; i < takedImages.length; i++) {
        if (takedImages[i].path == path) {
          print(takedImages[i].path);
          takedImages.removeAt(i);
          labels.remove(path);
          emit(caseRemoveImageSuccessState());
        }
      }
      for (var i = 0; i < selectedImages.length; i++) {
        if (selectedImages[i].path == path) {
          print(selectedImages[i].path);
          selectedImages.removeAt(i);
          labels.remove(path);
          emit(caseRemoveImageSuccessState());
        }
      }
    }

    List<caseModel> casesperdoctor = [];
    void getCasesOfDoctor() {
      FirebaseFirestore.instance
          .collection('cases')
          .where('uId', isEqualTo: UID)
          .where('caseState', isEqualTo: 'WAITING')
          .snapshots()
          .listen((event) {
        casesperdoctor = [];
        event.docs.forEach((element) {
          casesperdoctor.add(caseModel.fromjson(element.data()));
        });
        emit(doctorGetCasesPerDoctorSucessState());
      });
    }

    bool isCompleteMAX = false;
    bool showCompleteSubCategoryMAX(value) {
      isCompleteMAX = value;
      emit(showCompleteSubcategoryMAX());
      return isCompleteMAX;
    }

    bool isPartialMAX = false;
    bool showPartialSubCategoryMAX(value) {
      isPartialMAX = value;
      emit(showPartialSubcategoryMAX());
      return isPartialMAX;
    }

    bool isCompleteMAN = false;
    bool showCompleteSubCategoryMAN(value) {
      isCompleteMAN = value;
      emit(showCompleteSubcategoryMAN());
      return isCompleteMAN;
    }

    bool isPartialMAN = false;
    bool showPartialSubCategoryMAN(value) {
      isPartialMAN = value;
      emit(showPartialSubcategoryMAN());
      return isPartialMAN;
    }

    bool isMaxillofacial = false;
    bool IsMaxillofacial(value) {
      isMaxillofacial = value;
      emit(isMaxilloFacial());
      return isMaxillofacial;
    }

    bool isFullmouth = false;
    bool IsFullmouth(value) {
      isFullmouth = value;
      emit(isfullmouth());
      return isFullmouth;
    }

    bool superChangeDiabetes(bool isDiabetes) {
      isDiabetes = !isDiabetes;
      emit(changeDiabetesSuccess());
      return isDiabetes;
    }

    //cardiac check box

    bool superChangeCardiac(bool isCardiac) {
      isCardiac = !isCardiac;
      emit(changeCardiacSuccess());
      return isCardiac;
    }

    //hypertension check box

    bool superChangeHypertension(bool isHypertension) {
      isHypertension = !isHypertension;
      emit(changeHypertensionSuccess());
      return isHypertension;
    }

    //allergies check box
    bool superChangeAllergies(bool isAllergies) {
      isAllergies = !isAllergies;
      emit(changeAllergiesSuccess());
      return isAllergies;
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
        caseState: caseState,
      );
      FirebaseFirestore.instance
          .collection('cases')
          .doc(caseId)
          .update(model.tomap())
          .then((value) {
        emit(doctorUpdateCasesSucessState());
      }).catchError((error) {
        emit(doctorUpdateCasesErrorState(error));
      });
    }

    void removeImage(url) {
      for (var i = 0; i < doctorClickcase!.images.length; i++) {
        if (doctorClickcase!.images[i] == url) {
          doctorClickcase!.images.removeAt(i);
          emit(caseRemoveImageSuccessState());
        }
      }
    }

    Future<void> logoutdoctor(context) async {
      await FirebaseAuth.instance.signOut();

      // Remove user ID and role data from cache
      await cacheHelper.removedata(key: 'uId');
      await cacheHelper.removedata(key: 'role');

      // Clear the cache
      await FirebaseMessaging.instance.unsubscribeFromTopic(UID);
      // Navigate to login screen
      navigate(context, loginScreen());
      emit(doctorlogoutSucessState());
    }

    List<caseModel> search = [];
    List<caseModel> search1 = [];
    List<caseModel> search2 = [];
    List<caseModel> search3 = [];
    List<caseModel> search4 = [];
    void doctorSearch(String query) {
      if (query.isNotEmpty) {
        search = [];
        search1 = [];
        search2 = [];
        search3 = [];
        search4 = [];
        search1 = doctorCases
            .where((item) => item.mandibularCategory!
                .toLowerCase()!
                .contains(query.toLowerCase()))
            .toList();
        search2 = doctorCases
            .where((item) => item.mandibularSubCategory!
                .toLowerCase()!
                .contains(query.toLowerCase()))
            .toList();
        search3 = doctorCases
            .where((item) => item.maxillaryCategory!
                .toLowerCase()!
                .contains(query.toLowerCase()))
            .toList();
        search4 = doctorCases
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
        emit(doctorSearchSucessState());
      } else {
        search = [];
        search1 = [];
        search2 = [];
        search3 = [];
        search4 = [];
        print('no available data');
        emit(doctorSearchSucessState());
      }
    }

    void deleteCase(caseid) {
      FirebaseFirestore.instance
          .collection('cases')
          .doc(caseid)
          .delete()
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('requests')
            .where('caseId', isEqualTo: caseid)
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
        emit(doctorDeleteCasesSucessState());
      }).catchError((error) {
        emit(doctorDeleteCasesErrorState(error.toString()));
      });
    }
  }
}
