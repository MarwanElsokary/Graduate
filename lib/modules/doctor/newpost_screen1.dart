import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:intl/intl.dart';
import 'package:project/shared/styles/colors.dart';
import '../../layout/doctor/doctorcubit/cubit.dart';
import '../../layout/doctor/doctorcubit/states.dart';
import '../../shared/components/components.dart';

Screen2Data? data;

class newPostScreen1 extends StatelessWidget {
  var formkey2 = GlobalKey<FormState>();
  bool isDiabetes = false;
  bool isHypertension = false;
  bool isCardiac = false;
  bool isAllergies = false;
  var patientNameController = TextEditingController();
  var patientAgeController = TextEditingController();
  var patientGenderController = TextEditingController();
  var patientAdressController = TextEditingController();
  var patienPhoneController = TextEditingController();
  var otherController = TextEditingController();
  var currentMedicationsController = TextEditingController();
  var allergiesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<doctorLayoutcubit, doctorLayoutstates>(
      listener: (context, state) {
        if (state is doctorNewPostSucessState) {
          patientNameController.clear();
          patientAgeController.clear();
          patientGenderController.clear();
          patientAdressController.clear();
          patienPhoneController.clear();
          currentMedicationsController.clear();
          isDiabetes = false;
          isHypertension = false;
          isCardiac = false;
          isAllergies = false;
          otherController.clear();
          allergiesController.clear();
        }
      },
      builder: (context, state) {
        print('build');
        var userModel = doctorLayoutcubit.get(context).doctormodel;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'New Case',
            ),
          ),
          body: Container(
            color: Color(0xFFB8F5FF),
            child: Card(
              color: Color.fromRGBO(255, 255, 255, 0.82),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                side: BorderSide(
                  color: Color.fromRGBO(107, 201, 255, 1),
                  width: 2,
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        ConditionalBuilder(
                          condition: userModel?.image != null,
                          builder: (context) => Stack(
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage(
                                  '${userModel?.image}',
                                ),
                              ),
                            ],
                          ),
                          fallback: (context) => Stack(
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage:
                                    AssetImage('images/profileimage.jpg'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userModel?.name}',
                                style: TextStyle(
                                  color: Color(0xFF004E7F),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'what patient case do you have ..',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF06A4FF),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 1.0,
                        color: Color(0xFF003E65),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: formkey2,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                defaulttextformfield(
                                  controller: patientNameController,
                                  radius: 30,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Patient Name';
                                    }
                                  },
                                  keyboardtype: TextInputType.name,
                                  label: 'Patient Name',
                                  bordercolor: Color(0xFF06A4FF),
                                  labelcolor: Color(0xFF004E7F),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                defaulttextformfield(
                                  controller: patientAgeController,
                                  radius: 30,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Patient Age';
                                    }
                                  },
                                  keyboardtype: TextInputType.number,
                                  label: 'Patient Age',
                                  bordercolor: Color(0xFF06A4FF),
                                  labelcolor: Color(0xFF004E7F),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                defaulttextformfield(
                                  controller: patientGenderController,
                                  radius: 30,
                                  keyboardtype: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Patient Gender';
                                    }
                                  },
                                  label: 'Patient Gender',
                                  bordercolor: Color(0xFF06A4FF),
                                  labelcolor: Color(0xFF004E7F),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                defaulttextformfield(
                                  controller: patientAdressController,
                                  radius: 30,
                                  keyboardtype: TextInputType.streetAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Patient Address';
                                    }
                                  },
                                  label: 'Patient Address',
                                  bordercolor: Color(0xFF06A4FF),
                                  labelcolor: Color(0xFF004E7F),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                defaulttextformfield(
                                  controller: patienPhoneController,
                                  maxLength: 11,
                                  radius: 30,
                                  keyboardtype: TextInputType.phone,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Patient Phone Number';
                                    }
                                    if (value.length < 11) {
                                      return 'please enter valid phone number';
                                    }
                                  },
                                  label: 'phone number',
                                  bordercolor: Color(0xFF06A4FF),
                                  labelcolor: Color(0xFF004E7F),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                defaulttextformfield(
                                  controller: currentMedicationsController,
                                  keyboardtype: TextInputType.text,
                                  radius: 30,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Patient Medication No Medication?? write none';
                                    }
                                  },
                                  label: 'Current Medicaton',
                                  bordercolor: Color(0xFF06A4FF),
                                  labelcolor: Color(0xFF004E7F),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Medical History',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: cc.defcol,
                                      )),
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      tristate: false,
                                      value: isDiabetes,
                                      activeColor: defaultcol,
                                      onChanged: (value) {
                                        isDiabetes = doctorLayoutcubit
                                            .get(context)
                                            .changeDiabetes();
                                      },
                                    ),
                                    Text(
                                      'Diabetes',
                                      style: TextStyle(
                                        color: Color(0xFF004E7F),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Checkbox(
                                      tristate: false,
                                      value: isCardiac,
                                      activeColor: defaultcol,
                                      onChanged: (value) {
                                        isCardiac = doctorLayoutcubit
                                            .get(context)
                                            .changeCardiac();
                                      },
                                    ),
                                    Text(
                                      'Cardiac Problems',
                                      style: TextStyle(
                                        color: Color(0xFF004E7F),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      tristate: false,
                                      value: isAllergies,
                                      activeColor: defaultcol,
                                      onChanged: (value) {
                                        isAllergies = doctorLayoutcubit
                                            .get(context)
                                            .changeAllergies();
                                      },
                                    ),
                                    Text(
                                      'Allergies',
                                      style: TextStyle(
                                        color: Color(0xFF004E7F),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Checkbox(
                                      value: isHypertension,
                                      activeColor: defaultcol,
                                      tristate: false,
                                      onChanged: (value) {
                                        isHypertension = doctorLayoutcubit
                                            .get(context)
                                            .changeHypertension();
                                      },
                                    ),
                                    Text(
                                      'Hypertension',
                                      style: TextStyle(
                                        color: Color(0xFF004E7F),
                                      ),
                                    ),
                                  ],
                                ),
                                ConditionalBuilder(
                                    condition: isAllergies,
                                    builder: (context) => TextFormField(
                                        controller: allergiesController,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please Enter Patient Allergies';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Allergies ',
                                          border: InputBorder.none,
                                        )),
                                    fallback: (context) => SizedBox()),
                                TextFormField(
                                    controller: otherController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Others...',
                                      border: InputBorder.none,
                                    )),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: defaultbutton(
                                    onpress: () async {
                                      if (formkey2.currentState!.validate()) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                newPostScreen2(
                                              patientNameController:
                                                  patientNameController.text,
                                              patientAgeController:
                                                  patientAgeController.text,
                                              patientGenderController:
                                                  patientGenderController.text,
                                              patientAdressController:
                                                  patientAdressController.text,
                                              patienPhoneController:
                                                  patienPhoneController.text,
                                              currentMedicationsController:
                                                  currentMedicationsController
                                                      .text,
                                              isAllergies: isAllergies,
                                              isCardiac: isCardiac,
                                              isDiabetes: isDiabetes,
                                              isHypertension: isHypertension,
                                              otherController:
                                                  otherController.text,
                                              allergiesController:
                                                  allergiesController.text,
                                              maxillarySubcategorydropdownvalue:
                                                  data?.maxillarySubcategorydropdownvalue,
                                              maxillaryModificationdropdownvalue:
                                                  data?.maxillaryModificationdropdownvalue,
                                              maxillaryCategorydropdownvalue: data
                                                  ?.maxillaryCategorydropdownvalue,
                                              mandibularSubcategorydropdownvalue:
                                                  data?.mandibularSubcategorydropdownvalue,
                                              mandibularModificationdropdownvalue:
                                                  data?.mandibularModificationdropdownvalue,
                                              mandibularCategorydropdownvalue: data
                                                  ?.mandibularCategorydropdownvalue,
                                              leveldropdownvalue:
                                                  data?.leveldropdownvalue,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    text: 'Next',
                                    upercase: true,
                                    radius: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class newPostScreen2 extends StatelessWidget {
  newPostScreen2({
    required this.isDiabetes,
    required this.isHypertension,
    required this.isCardiac,
    required this.isAllergies,
    required this.patientNameController,
    required this.patientAgeController,
    required this.patientGenderController,
    required this.patientAdressController,
    required this.patienPhoneController,
    required this.otherController,
    required this.currentMedicationsController,
    required this.allergiesController,
    this.maxillaryCategorydropdownvalue,
    this.maxillarySubcategorydropdownvalue,
    this.mandibularCategorydropdownvalue,
    this.mandibularSubcategorydropdownvalue,
    this.mandibularModificationdropdownvalue,
    this.maxillaryModificationdropdownvalue,
    this.leveldropdownvalue,
  });

  bool isDiabetes;
  bool isHypertension;
  bool isCardiac;
  bool isAllergies;
  var patientNameController;
  var patientAgeController;
  var patientGenderController;
  var patientAdressController;
  var patienPhoneController;
  var otherController;
  var currentMedicationsController;
  var allergiesController;
  String? maxillaryCategorydropdownvalue;
  var itemsMax = [
    'Maxillary Complete Denture',
    'Maxillary Partial Denture',
    'Maxillary Overdenture',
    'Maxillary Single Denture',
    'Maxillofacial Case',
    'Full Mouth Rehabilitation',
    'Normal Maxillary Arch',
  ];
  String? maxillarySubcategorydropdownvalue;
  var itemsCompleteMax = [
    'Flat Ridge',
    'Well Developed Ridge',
  ];
  var itemsPartialMax = [
    'kennedy |',
    'kennedy ||',
    'kennedy |||',
    'kennedy |V',
  ];
  String? maxillaryModificationdropdownvalue;
  var itemsModMax = ['1', '2', '3', '4', '5', '6', '7', '8', 'Un Modified'];
  String? mandibularCategorydropdownvalue;
  var itemsman = [
    'Mandibular Complete Denture',
    'Mandibular Partial Denture',
    'Mandibular Overdenture',
    'Mandibular Single Denture',
    'Maxillofacial Case',
    'Full Mouth Rehabilitation',
    'Normal Mandibular Arch',
  ];
  String? mandibularSubcategorydropdownvalue;
  var itemsCompleteman = [
    'Flat Ridge',
    'Well Developed Ridge',
  ];
  var itemsPartialman = [
    'kennedy |',
    'kennedy ||',
    'kennedy |||',
    'kennedy |V',
  ];
  String? mandibularModificationdropdownvalue;
  var itemsModman = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    'Un Modified',
  ];
  String? leveldropdownvalue;
  var items3 = [
    'Level 4',
    'Level 5',
    'postgraduate ',
  ];
  var formkey3 = GlobalKey<FormState>();
  var imagesController = TextEditingController();

  // List imgs = [];
  String? pre;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<doctorLayoutcubit, doctorLayoutstates>(
      listener: (context, state) {
        if (state is doctorNewPostSucessState) {
          doctorLayoutcubit.get(context).selectedImages.clear();
          doctorLayoutcubit.get(context).takedImages.clear();
          maxillaryCategorydropdownvalue = null;
          maxillarySubcategorydropdownvalue = null;
          mandibularCategorydropdownvalue = null;
          mandibularSubcategorydropdownvalue = null;
          mandibularModificationdropdownvalue = null;
          maxillaryModificationdropdownvalue = null;
          doctorLayoutcubit.get(context).labels.clear();
          leveldropdownvalue = null;
          doctorLayoutcubit.get(context).showCompleteSubCategoryMAX(false);
          doctorLayoutcubit.get(context).showPartialSubCategoryMAX(false);
          doctorLayoutcubit.get(context).showCompleteSubCategoryMAN(false);
          doctorLayoutcubit.get(context).showPartialSubCategoryMAN(false);
          doctorLayoutcubit.get(context).IsFullmouth(false);
          doctorLayoutcubit.get(context).IsMaxillofacial(false);
          data = Screen2Data(
            maxillaryCategorydropdownvalue: null,
            maxillarySubcategorydropdownvalue: null,
            mandibularCategorydropdownvalue: null,
            mandibularSubcategorydropdownvalue: null,
            mandibularModificationdropdownvalue: null,
            maxillaryModificationdropdownvalue: null,
            leveldropdownvalue: null,
          );
          showtoast(
              text: 'Case Added Successfully', state: toaststates.SUCCESS);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var userModel = doctorLayoutcubit.get(context).doctormodel;
        var caseImages = doctorLayoutcubit.get(context).selectedImages;
        var takedImages = doctorLayoutcubit.get(context).takedImages;
        print(caseImages.length);
        print(takedImages.length);
        // imgs = [];
        // imgs.addAll(caseImages);
        // imgs.addAll(takedImages);
        var ii = doctorLayoutcubit.get(context).labels;
        var imgs = ii.entries.toList();
        print(imgs.length);
        return Scaffold(
          appBar: AppBar(
              title: Text(
                'New Case',
              ),
              leading: IconButton(
                onPressed: () {
                  // Pass the data back to the previous screen
                  data = Screen2Data(
                    maxillaryCategorydropdownvalue:
                        maxillaryCategorydropdownvalue ?? null,
                    maxillarySubcategorydropdownvalue:
                        maxillarySubcategorydropdownvalue ?? null,
                    mandibularCategorydropdownvalue:
                        mandibularCategorydropdownvalue ?? null,
                    mandibularSubcategorydropdownvalue:
                        mandibularSubcategorydropdownvalue ?? null,
                    mandibularModificationdropdownvalue:
                        mandibularModificationdropdownvalue ?? null,
                    maxillaryModificationdropdownvalue:
                        maxillaryModificationdropdownvalue ?? null,
                    leveldropdownvalue: leveldropdownvalue ?? null,
                  );
                  Navigator.pop(context);
                },
                icon: Icon(
                  IconBroken.Arrow___Left_2,
                ),
              ),
              actions: [
                defaultTextButton(
                  onpress: () {
                    var now = DateTime.now();
                    var formatter = DateFormat('dd-MM-yyyy HH:mm ');
                    String formattedDate = formatter.format(now);

                    if (formkey3.currentState!.validate()) {
                      if (caseImages.length == 0 && takedImages.length == 0) {
                        showtoast(
                            text: 'you must add your case photos',
                            state: toaststates.ERROR);
                      } else {
                        doctorLayoutcubit.get(context).uploadCaseImage(
                              dateTime: formattedDate.toString(),
                              patientName: patientNameController,
                              patientAge: patientAgeController,
                              gender: patientGenderController,
                              patientAddress: patientAdressController,
                              patientPhone: patienPhoneController,
                              currentMedications: currentMedicationsController,
                              isAllergies: isAllergies,
                              isCardiac: isCardiac,
                              isDiabetes: isDiabetes,
                              isHypertension: isHypertension,
                              others: otherController,
                              allergies: allergiesController,
                              level: leveldropdownvalue.toString(),
                              mandibularCategory:
                                  mandibularCategorydropdownvalue.toString(),
                              mandibularModification:
                                  mandibularModificationdropdownvalue
                                              .toString() ==
                                          'null'
                                      ? ' '
                                      : mandibularModificationdropdownvalue
                                          .toString(),
                              mandibularSubCategory:
                                  mandibularSubcategorydropdownvalue
                                              .toString() ==
                                          'null'
                                      ? ' '
                                      : mandibularSubcategorydropdownvalue
                                          .toString(),
                              maxillaryCategory:
                                  maxillaryCategorydropdownvalue.toString(),
                              maxillaryModification:
                                  maxillaryModificationdropdownvalue
                                              .toString() ==
                                          'null'
                                      ? ' '
                                      : maxillaryModificationdropdownvalue
                                          .toString(),
                              maxillarySubCategory:
                                  maxillarySubcategorydropdownvalue
                                              .toString() ==
                                          'null'
                                      ? ' '
                                      : maxillarySubcategorydropdownvalue
                                          .toString(),
                            );
                      }
                    } else {
                      print('no validation');
                    }
                  },
                  text: ' post',
                  size: 15,
                ),
              ]),
          body: Container(
            color: Color(0xFFB8F5FF),
            child: Card(
              color: Color.fromRGBO(255, 255, 255, 0.82),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                side: BorderSide(
                  color: Color.fromRGBO(107, 201, 255, 1),
                  width: 2,
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    if (state is doctorNewPostLoadingState)
                      LinearProgressIndicator(),
                    if (state is doctorNewPostLoadingState)
                      SizedBox(
                        height: 10.0,
                      ),
                    Row(
                      children: [
                        ConditionalBuilder(
                          condition: userModel?.image != null,
                          builder: (context) => Stack(
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage(
                                  '${userModel?.image}',
                                ),
                              ),
                            ],
                          ),
                          fallback: (context) => Stack(
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage:
                                    AssetImage('images/profileimage.jpg'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userModel?.name}',
                                style: TextStyle(
                                  color: Color(0xFF004E7F),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'what patient case do you have ..',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF06A4FF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 1.0,
                        color: Color(0xFFb8f5ff),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: formkey3,
                          child: Column(
                            children: [
                              ConditionalBuilder(
                                builder: (context) => SizedBox(),
                                condition: doctorLayoutcubit
                                        .get(context)
                                        .isMaxillofacial ||
                                    doctorLayoutcubit.get(context).isFullmouth,
                                fallback: (context) => Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Maxillary',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: cc.defcol,
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              DropdownButtonFormField(
                                value: maxillaryCategorydropdownvalue,
                                decoration: InputDecoration(
                                  label: Text(
                                    'Choose Category',
                                    style: TextStyle(
                                      color: Color(0xFF06A4FF),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                icon: const Icon(
                                  IconBroken.Arrow___Down_2,
                                  color: cc.defcol,
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please Choose Category';
                                  }
                                },
                                onChanged: (String? newValue) {
                                  maxillaryCategorydropdownvalue = newValue!;
                                  if (newValue ==
                                      'Maxillary Complete Denture') {
                                    doctorLayoutcubit
                                        .get(context)
                                        .showCompleteSubCategoryMAX(true);
                                    doctorLayoutcubit
                                        .get(context)
                                        .IsFullmouth(false);
                                    doctorLayoutcubit
                                        .get(context)
                                        .IsMaxillofacial(false);
                                    doctorLayoutcubit
                                        .get(context)
                                        .showPartialSubCategoryMAX(false);
                                    maxillaryModificationdropdownvalue = null;
                                    maxillarySubcategorydropdownvalue = null;
                                    if (pre == 'Maxillofacial Case' ||
                                        pre == 'Full Mouth Rehabilitation') {
                                      mandibularCategorydropdownvalue = null;
                                      pre = null;
                                    }
                                  } else if (newValue ==
                                      'Maxillary Partial Denture') {
                                    doctorLayoutcubit
                                        .get(context)
                                        .showPartialSubCategoryMAX(true);
                                    doctorLayoutcubit
                                        .get(context)
                                        .IsFullmouth(false);
                                    doctorLayoutcubit
                                        .get(context)
                                        .IsMaxillofacial(false);
                                    doctorLayoutcubit
                                        .get(context)
                                        .showCompleteSubCategoryMAX(false);
                                    maxillarySubcategorydropdownvalue = null;
                                    maxillaryModificationdropdownvalue =
                                        'Un Modified';
                                    if (pre == 'Maxillofacial Case' ||
                                        pre == 'Full Mouth Rehabilitation') {
                                      mandibularCategorydropdownvalue = null;
                                      pre = null;
                                    }
                                  } else if (newValue == 'Maxillofacial Case') {
                                    pre = 'Maxillofacial Case';
                                    mandibularCategorydropdownvalue =
                                        'Maxillofacial Case';
                                    doctorLayoutcubit
                                        .get(context)
                                        .IsMaxillofacial(true);
                                    doctorLayoutcubit
                                        .get(context)
                                        .IsFullmouth(false);
                                    doctorLayoutcubit
                                        .get(context)
                                        .showCompleteSubCategoryMAX(false);
                                    doctorLayoutcubit
                                        .get(context)
                                        .showPartialSubCategoryMAX(false);
                                    doctorLayoutcubit
                                        .get(context)
                                        .showCompleteSubCategoryMAN(false);
                                    doctorLayoutcubit
                                        .get(context)
                                        .showPartialSubCategoryMAN(false);
                                    maxillarySubcategorydropdownvalue = null;
                                    maxillaryModificationdropdownvalue = null;
                                    mandibularSubcategorydropdownvalue = null;
                                    mandibularModificationdropdownvalue = null;
                                  } else if (newValue ==
                                      'Full Mouth Rehabilitation') {
                                    pre = 'Full Mouth Rehabilitation';
                                    mandibularCategorydropdownvalue =
                                        'Full Mouth Rehabilitation';
                                    doctorLayoutcubit
                                        .get(context)
                                        .IsFullmouth(true);
                                    doctorLayoutcubit
                                        .get(context)
                                        .IsMaxillofacial(false);
                                    doctorLayoutcubit
                                        .get(context)
                                        .showCompleteSubCategoryMAX(false);
                                    doctorLayoutcubit
                                        .get(context)
                                        .showPartialSubCategoryMAX(false);
                                    doctorLayoutcubit
                                        .get(context)
                                        .showCompleteSubCategoryMAN(false);
                                    doctorLayoutcubit
                                        .get(context)
                                        .showPartialSubCategoryMAN(false);
                                    maxillarySubcategorydropdownvalue = null;
                                    maxillaryModificationdropdownvalue = null;
                                    mandibularSubcategorydropdownvalue = null;
                                    mandibularModificationdropdownvalue = null;
                                  } else {
                                    doctorLayoutcubit
                                        .get(context)
                                        .IsFullmouth(false);
                                    doctorLayoutcubit
                                        .get(context)
                                        .IsMaxillofacial(false);
                                    doctorLayoutcubit
                                        .get(context)
                                        .showCompleteSubCategoryMAX(false);
                                    doctorLayoutcubit
                                        .get(context)
                                        .showPartialSubCategoryMAX(false);
                                    maxillaryModificationdropdownvalue = null;
                                    maxillarySubcategorydropdownvalue = null;
                                    if (pre == 'Maxillofacial Case' ||
                                        pre == 'Full Mouth Rehabilitation') {
                                      print('object');
                                      mandibularCategorydropdownvalue = null;
                                      pre = null;
                                    }
                                  }
                                },
                                items: itemsMax.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                              ),
                              ConditionalBuilder(
                                fallback: (context) => SizedBox(),
                                condition:
                                    doctorLayoutcubit.get(context).isPartialMAX,
                                builder: (context) => DropdownButtonFormField(
                                  value: maxillarySubcategorydropdownvalue,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Choose  Sub Category',
                                      style: TextStyle(
                                        color: Color(0xFF06A4FF),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  icon: const Icon(
                                    IconBroken.Arrow___Down_2,
                                    color: cc.defcol,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please Choose Subcategory';
                                    }
                                  },
                                  onChanged: (String? newValue) {
                                    maxillarySubcategorydropdownvalue =
                                        newValue!;
                                    print(maxillarySubcategorydropdownvalue);
                                  },
                                  items: itemsPartialMax.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                ),
                              ),
                              ConditionalBuilder(
                                fallback: (context) => SizedBox(),
                                condition:
                                    doctorLayoutcubit.get(context).isPartialMAX,
                                builder: (context) => DropdownButtonFormField(
                                  value: maxillaryModificationdropdownvalue,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Choose  Modification',
                                      style: TextStyle(
                                        color: Color(0xFF06A4FF),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  icon: const Icon(
                                    IconBroken.Arrow___Down_2,
                                    color: cc.defcol,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please Choose Modification';
                                    }
                                  },
                                  onChanged: (String? newValue) {
                                    maxillaryModificationdropdownvalue =
                                        newValue!;
                                    print(maxillaryModificationdropdownvalue);
                                  },
                                  items: itemsModMax.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                ),
                              ),
                              ConditionalBuilder(
                                fallback: (context) => SizedBox(),
                                condition: doctorLayoutcubit
                                    .get(context)
                                    .isCompleteMAX,
                                builder: (context) => DropdownButtonFormField(
                                  value: maxillarySubcategorydropdownvalue,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Choose Sub Category',
                                      style: TextStyle(
                                        color: Color(0xFF06A4FF),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  icon: const Icon(
                                    IconBroken.Arrow___Down_2,
                                    color: cc.defcol,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please Choose Subcategory';
                                    }
                                  },
                                  onChanged: (String? newValue) {
                                    maxillarySubcategorydropdownvalue =
                                        newValue!;
                                    print(maxillarySubcategorydropdownvalue);
                                  },
                                  items: itemsCompleteMax.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                ),
                              ),
                              ConditionalBuilder(
                                builder: (context) => SizedBox(),
                                condition: doctorLayoutcubit
                                        .get(context)
                                        .isMaxillofacial ||
                                    doctorLayoutcubit.get(context).isFullmouth,
                                fallback: (context) => Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Mandibular',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: cc.defcol,
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              ConditionalBuilder(
                                builder: (context) => SizedBox(),
                                condition: doctorLayoutcubit
                                        .get(context)
                                        .isMaxillofacial ||
                                    doctorLayoutcubit.get(context).isFullmouth,
                                fallback: (context) => DropdownButtonFormField(
                                  value: mandibularCategorydropdownvalue,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Choose Category',
                                      style: TextStyle(
                                        color: Color(0xFF06A4FF),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  icon: const Icon(
                                    IconBroken.Arrow___Down_2,
                                    color: cc.defcol,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please Choose Category';
                                    }
                                  },
                                  onChanged: (String? newValue) {
                                    mandibularCategorydropdownvalue = newValue!;
                                    print(mandibularCategorydropdownvalue);
                                    if (newValue ==
                                        'Mandibular Complete Denture') {
                                      doctorLayoutcubit
                                          .get(context)
                                          .IsMaxillofacial(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .IsFullmouth(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .showPartialSubCategoryMAN(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .showCompleteSubCategoryMAN(true);
                                      mandibularModificationdropdownvalue =
                                          null;
                                      mandibularSubcategorydropdownvalue = null;
                                    } else if (newValue ==
                                        'Mandibular Partial Denture') {
                                      doctorLayoutcubit
                                          .get(context)
                                          .IsMaxillofacial(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .IsFullmouth(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .showCompleteSubCategoryMAN(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .showPartialSubCategoryMAN(true);
                                      mandibularSubcategorydropdownvalue = null;
                                      mandibularModificationdropdownvalue =
                                          'Un Modified';
                                    } else if (newValue ==
                                        'Maxillofacial Case') {
                                      pre = 'Maxillofacial Case';
                                      maxillaryCategorydropdownvalue =
                                          'Maxillofacial Case';
                                      doctorLayoutcubit
                                          .get(context)
                                          .IsMaxillofacial(true);
                                      doctorLayoutcubit
                                          .get(context)
                                          .IsFullmouth(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .showCompleteSubCategoryMAN(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .showPartialSubCategoryMAN(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .showCompleteSubCategoryMAX(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .showPartialSubCategoryMAX(false);
                                      mandibularSubcategorydropdownvalue = null;
                                      mandibularModificationdropdownvalue =
                                          null;
                                      maxillaryModificationdropdownvalue = null;
                                      maxillarySubcategorydropdownvalue = null;
                                    } else if (newValue ==
                                        'Full Mouth Rehabilitation') {
                                      pre = 'Full Mouth Rehabilitation';
                                      maxillaryCategorydropdownvalue =
                                          'Full Mouth Rehabilitation';
                                      doctorLayoutcubit
                                          .get(context)
                                          .IsFullmouth(true);
                                      doctorLayoutcubit
                                          .get(context)
                                          .IsMaxillofacial(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .showCompleteSubCategoryMAN(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .showPartialSubCategoryMAN(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .showCompleteSubCategoryMAX(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .showPartialSubCategoryMAX(false);
                                      mandibularSubcategorydropdownvalue = null;
                                      mandibularModificationdropdownvalue =
                                          null;
                                      maxillaryModificationdropdownvalue = null;
                                      maxillarySubcategorydropdownvalue = null;
                                    } else {
                                      doctorLayoutcubit
                                          .get(context)
                                          .showCompleteSubCategoryMAN(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .showPartialSubCategoryMAN(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .IsMaxillofacial(false);
                                      doctorLayoutcubit
                                          .get(context)
                                          .IsFullmouth(false);
                                      mandibularModificationdropdownvalue =
                                          null;
                                      mandibularSubcategorydropdownvalue = null;
                                    }
                                  },
                                  items: itemsman.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                ),
                              ),
                              ConditionalBuilder(
                                fallback: (context) => SizedBox(),
                                condition:
                                    doctorLayoutcubit.get(context).isPartialMAN,
                                builder: (context) => DropdownButtonFormField(
                                  value: mandibularSubcategorydropdownvalue,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Choose Sub Category',
                                      style: TextStyle(
                                        color: Color(0xFF06A4FF),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  icon: const Icon(
                                    IconBroken.Arrow___Down_2,
                                    color: cc.defcol,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please Choose Subcategory';
                                    }
                                  },
                                  onChanged: (String? newValue) {
                                    mandibularSubcategorydropdownvalue =
                                        newValue!;
                                    print(mandibularSubcategorydropdownvalue);
                                  },
                                  items: itemsPartialman.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                ),
                              ),
                              ConditionalBuilder(
                                fallback: (context) => SizedBox(),
                                condition:
                                    doctorLayoutcubit.get(context).isPartialMAN,
                                builder: (context) => DropdownButtonFormField(
                                  value: mandibularModificationdropdownvalue,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Choose  Modification',
                                      style: TextStyle(
                                        color: Color(0xFF06A4FF),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  icon: const Icon(
                                    IconBroken.Arrow___Down_2,
                                    color: cc.defcol,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please Choose Modification';
                                    }
                                  },
                                  onChanged: (String? newValue) {
                                    mandibularModificationdropdownvalue =
                                        newValue!;
                                    print(mandibularModificationdropdownvalue);
                                  },
                                  items: itemsModman.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                ),
                              ),
                              ConditionalBuilder(
                                fallback: (context) => SizedBox(),
                                condition: doctorLayoutcubit
                                    .get(context)
                                    .isCompleteMAN,
                                builder: (context) => DropdownButtonFormField(
                                  value: mandibularSubcategorydropdownvalue,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Choose  Sub Category',
                                      style: TextStyle(
                                        color: Color(0xFF06A4FF),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  icon: const Icon(
                                    IconBroken.Arrow___Down_2,
                                    color: cc.defcol,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please Choose Subcategory';
                                    }
                                  },
                                  onChanged: (String? newValue) {
                                    mandibularSubcategorydropdownvalue =
                                        newValue!;
                                    print(mandibularSubcategorydropdownvalue);
                                  },
                                  items: itemsCompleteman.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                ),
                              ),
                              DropdownButtonFormField(
                                value: leveldropdownvalue,
                                decoration: InputDecoration(
                                  label: Text(
                                    'Choose Level',
                                    style: TextStyle(
                                      color: Color(0xFF06A4FF),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                icon: const Icon(
                                  IconBroken.Arrow___Down_2,
                                  color: cc.defcol,
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please Choose  Level ';
                                  }
                                },
                                onChanged: (String? newValue) {
                                  leveldropdownvalue = newValue!;
                                  print(leveldropdownvalue);
                                },
                                items: items3.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              if (imgs.isNotEmpty)
                                Container(
                                  //  height: 300,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      4.0,
                                    ),
                                  ),
                                  // child: GridView.builder(
                                  //   physics: BouncingScrollPhysics(),
                                  //   shrinkWrap: true,
                                  //   gridDelegate:
                                  //   SliverGridDelegateWithFixedCrossAxisCount(
                                  //     crossAxisCount: 2,
                                  //     crossAxisSpacing: 5,
                                  //     mainAxisSpacing: 5,
                                  //   ),
                                  //   itemCount: imgs.length,
                                  //   itemBuilder: (context, index) {
                                  //     return
                                  //         Stack(
                                  //           alignment: AlignmentDirectional.topEnd,
                                  //           children: [
                                  //             Image.file(
                                  //               File(imgs[index]!.path),
                                  //               fit: BoxFit.cover,
                                  //               width: double.infinity,
                                  //             ),
                                  //             IconButton(
                                  //               icon: CircleAvatar(
                                  //                 radius: 15.0,
                                  //                 child: Icon(
                                  //                   Icons.close,
                                  //                   size: 16.0,
                                  //                 ),
                                  //                 backgroundColor: Colors.white,
                                  //               ),
                                  //               onPressed: () {
                                  //                 doctorLayoutcubit
                                  //                     .get(context)
                                  //                     .removePostImage(
                                  //                     imgs[index]!.path);
                                  //               },
                                  //             ),
                                  //           ],
                                  //         );
                                  //   },
                                  // ),
                                  child: Container(
                                    color: Colors.blue,
                                    height: 400,
                                    width: 300,
                                    child: GridView.builder(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5,
                                      ),
                                      itemCount: imgs.length,
                                      itemBuilder: (context, index) {
                                        final cubit = doctorLayoutcubit.get(context);
                                        final imageKey = imgs[index].key;
                                        final analyzedImage = cubit.analyzedImages[imageKey];

                                        return Card(
                                          elevation: 3,
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              // الصورة الأصلية
                                              Image.file(
                                                File(imageKey),
                                                fit: BoxFit.cover,
                                              ),

                                              // زر الإزالة
                                              Positioned(
                                                top: 10,
                                                right: 10,
                                                child: IconButton(
                                                  icon: Icon(Icons.close, color: Colors.blue),
                                                  onPressed: () => cubit.removePostImage(imageKey),
                                                ),
                                              ),

                                              // عرض الصورة المحللة (إذا كانت متوفرة)
                                              if (analyzedImage != null)
                                                Positioned.fill(
                                                  child: Container(
                                                    color: Colors.black.withOpacity(0.3),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            'AI Diagnostics',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Container(
                                                            width: 250,
                                                            height: 250,
                                                            decoration: BoxDecoration(
                                                              border: Border.all(color: Colors.amber, width: 2),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors.black.withOpacity(0.5),
                                                                  spreadRadius: 2,
                                                                  blurRadius: 5,
                                                                ),
                                                              ],
                                                            ),
                                                            child:Container(
                                                              width: double.infinity,
                                                              height: double.infinity,
                                                              decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.blue, width: 2),
                                                              ),
                                                              child: analyzedImage != null
                                                                  ? Image.memory(
                                                                analyzedImage!,
                                                                fit: BoxFit.contain,
                                                                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                                                  if (frame == null) {
                                                                    return Center(child: CircularProgressIndicator());
                                                                  }
                                                                  return child;
                                                                },
                                                                errorBuilder: (context, error, stackTrace) {
                                                                  print('❌ Failed to display image: $error');
                                                                  return Center(child: Icon(Icons.error));
                                                                },
                                                              )
                                                                  : Center(child: CircularProgressIndicator()),
                                                            )
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              doctorLayoutcubit.get(context).selectImages();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconBroken.Image,

                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'Add Photo',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              doctorLayoutcubit.get(context).takeImages();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconBroken.Camera,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'Take Photo',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Screen2Data {
  String? maxillaryCategorydropdownvalue = null;
  String? maxillarySubcategorydropdownvalue = null;
  String? mandibularCategorydropdownvalue = null;
  String? mandibularSubcategorydropdownvalue = null;
  String? mandibularModificationdropdownvalue = null;
  String? maxillaryModificationdropdownvalue = null;
  String? leveldropdownvalue = null;

  Screen2Data({
    required this.maxillaryCategorydropdownvalue,
    required this.maxillarySubcategorydropdownvalue,
    required this.mandibularCategorydropdownvalue,
    required this.mandibularSubcategorydropdownvalue,
    required this.mandibularModificationdropdownvalue,
    required this.maxillaryModificationdropdownvalue,
    required this.leveldropdownvalue,
  });
}
