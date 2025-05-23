import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import '../../layout/doctor/doctorcubit/cubit.dart';
import '../../layout/doctor/doctorcubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class doctorEditCaseScreen extends StatelessWidget {
  String? maxillaryCategorydropdownvalue;
  var itemsMax = [
    'Maxillary Complete Denture',
    'Maxillary Single Denture',
    'Maxillary Caries ',
    'Maxillary Partial Denture',
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
    'Cavity ',
    'Tooth',
  ];
  String? maxillaryModificationdropdownvalue;
  var itemsModMax = ['1', '2', '3', '4', '5', '6', '7', '8', 'Un Modified'];
  String? mandibularCategorydropdownvalue;
  var itemsman = [
    'Mandibular Complete Denture',
    'Mandibular Single Denture',
    'Mandibular Caries',
    'Mandibular Partial Denture',
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
    'Caries ',
    'Cavity ',
    'Tooth',
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
  late bool isDiabetes;
  late bool isHypertension;
  late bool isCardiac;
  late bool isAllergies;
  var patientNameController = TextEditingController();
  var patientAgeController = TextEditingController();
  var patientGenderController = TextEditingController();
  var patientAdressController = TextEditingController();
  var patienPhoneController = TextEditingController();
  var otherController = TextEditingController();
  var imagesController = TextEditingController();
  var currentMedicationsController = TextEditingController();
  var allergiesController = TextEditingController();
  String? pre;

  @override
  Widget build(BuildContext context) {
    var model1 = doctorLayoutcubit.get(context).doctorClickcase;
    isAllergies = model1!.isAllergies!;
    isCardiac = model1.isCardiac!;
    isDiabetes = model1.isDiabetes!;
    isHypertension = model1.isHypertension!;
    currentMedicationsController.text = model1.currentMedications!;
    mandibularCategorydropdownvalue = model1.mandibularCategory!;
    mandibularModificationdropdownvalue = model1.mandibularModification!;
    mandibularSubcategorydropdownvalue = model1.mandibularSubCategory!;
    maxillaryCategorydropdownvalue = model1.maxillaryCategory!;
    maxillaryModificationdropdownvalue = model1.maxillaryModification!;
    maxillarySubcategorydropdownvalue = model1.maxillarySubCategory!;
    if (maxillaryCategorydropdownvalue == 'Maxillofacial Case' ||
        maxillaryCategorydropdownvalue == 'Full Mouth Rehabilitation') {
      pre = maxillaryCategorydropdownvalue;
    }
    return BlocConsumer<doctorLayoutcubit, doctorLayoutstates>(
      listener: (context, state) {
        if (state is doctorUpdateCasesSucessState) {
          showtoast(
              text: ' Case Updated successfully', state: toaststates.SUCCESS);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var model = doctorLayoutcubit.get(context).doctorClickcase;
        patientNameController.text = model!.patientName!;
        patientAgeController.text = model.patientAge!;
        patientGenderController.text = model.gender!;
        patientAdressController.text = model.patientAddress!;
        patienPhoneController.text = model.patientPhone!;
        otherController.text = model.others!;
        allergiesController.text = model.allergies!;
        leveldropdownvalue = model.level!;
        //  var caseImages = doctorLayoutcubit.get(context).selectedImages;
        return Scaffold(
          backgroundColor: Color(0xFFB8F5FF),
          appBar: AppBar(
            title: Text(
              'Update Case',
            ),
            leading: IconButton(
              onPressed: () {
                maxillaryCategorydropdownvalue = null;
                maxillarySubcategorydropdownvalue = null;
                mandibularCategorydropdownvalue = null;
                mandibularSubcategorydropdownvalue = null;
                mandibularModificationdropdownvalue = null;
                maxillaryModificationdropdownvalue = null;
                doctorLayoutcubit
                    .get(context)
                    .showCompleteSubCategoryMAX(false);
                doctorLayoutcubit.get(context).showPartialSubCategoryMAX(false);
                doctorLayoutcubit
                    .get(context)
                    .showCompleteSubCategoryMAN(false);
                doctorLayoutcubit.get(context).showPartialSubCategoryMAN(false);
                doctorLayoutcubit.get(context).IsFullmouth(false);
                doctorLayoutcubit.get(context).IsMaxillofacial(false);
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left_2),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  if (formkey3.currentState!.validate()) {
                    doctorLayoutcubit.get(context).updateCase(
                          dateTime: model.dateTime!,
                          patientName: patientNameController.text,
                          patientAge: patientAgeController.text,
                          gender: patientGenderController.text,
                          patientAddress: patientAdressController.text,
                          patientPhone: patienPhoneController.text,
                          currentMedications: currentMedicationsController.text,
                          isAllergies: isAllergies,
                          isCardiac: isCardiac,
                          isDiabetes: isDiabetes,
                          isHypertension: isHypertension,
                          others: otherController.text,
                          allergies: allergiesController.text,
                          level: leveldropdownvalue.toString(),
                          caseState: model.caseState!,
                          name: model.name!,
                          uId: model.uId!,
                          caseId: model.caseId!,
                          image: model.image != null ? model.image! : null,
                          images: model.images,
                          mandibularCategory:
                              mandibularCategorydropdownvalue.toString(),
                          mandibularModification:
                              mandibularModificationdropdownvalue.toString() ==
                                      'null'
                                  ? ' '
                                  : mandibularModificationdropdownvalue
                                      .toString(),
                          mandibularSubCategory:
                              mandibularSubcategorydropdownvalue.toString() ==
                                      'null'
                                  ? ' '
                                  : mandibularSubcategorydropdownvalue
                                      .toString(),
                          maxillaryCategory:
                              maxillaryCategorydropdownvalue.toString(),
                          maxillaryModification:
                              maxillaryModificationdropdownvalue.toString() ==
                                      'null'
                                  ? ' '
                                  : maxillaryModificationdropdownvalue
                                      .toString(),
                          maxillarySubCategory:
                              maxillarySubcategorydropdownvalue.toString() ==
                                      'null'
                                  ? ' '
                                  : maxillarySubcategorydropdownvalue
                                      .toString(),
                        );
                  } else {
                    print('no validation');
                  }
                  ;
                },
                icon: Icon(Icons.check),
              )
            ],
          ),
          body: Container(
            color: Color(0xFFB8F5FF),
            child: Card(
              color: Color.fromRGBO(255, 255, 255, 0.62),
              elevation: 0,
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
                          condition: model.image != null,
                          builder: (context) => Stack(
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage(
                                  '${model.image}',
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
                                'DR. ${model.name}',
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
                                '${model.dateTime}',
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
                        color: Color(0xFF003E65),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: formkey3,
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
                                          return 'please enter patient Allergies';
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
                                    hintText: 'others...',
                                    border: InputBorder.none,
                                  )),
                              ConditionalBuilder(
                                builder: (context) => SizedBox(),
                                condition: doctorLayoutcubit
                                        .get(context)
                                        .isMaxillofacial ||
                                    doctorLayoutcubit
                                        .get(context)
                                        .isFullmouth ||
                                    maxillaryCategorydropdownvalue ==
                                        'Maxillofacial Case' ||
                                    maxillaryCategorydropdownvalue ==
                                        'Full Mouth Rehabilitation',
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
                                      print('object');
                                      mandibularCategorydropdownvalue = null;
                                      pre = null;
                                    }
                                  } else if (newValue ==
                                      'Maxillary Single Denture') {
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
                                      print('object');
                                      mandibularCategorydropdownvalue = null;
                                      pre = null;
                                    }
                                  } else if (newValue == 'Maxillofacial Case') {
                                    pre = 'Maxillofacial Case';
                                    print('preis' + pre!);
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
                                    print('preis' + pre!);
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
                                    child: Text(items,style: TextStyle(
                                      color: cc.defcol,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,)),
                                  );
                                }).toList(),
                              ),
                              ConditionalBuilder(
                                fallback: (context) => SizedBox(),
                                condition: doctorLayoutcubit
                                        .get(context)
                                        .isPartialMAX ||
                                    itemsPartialMax.contains(
                                        maxillarySubcategorydropdownvalue),
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
                                      child: Text(items,style: TextStyle(
                                        color: cc.defcol,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,)),
                                    );
                                  }).toList(),
                                ),
                              ),
                              ConditionalBuilder(
                                fallback: (context) => SizedBox(),
                                condition: doctorLayoutcubit
                                        .get(context)
                                        .isCompleteMAX ||
                                    itemsCompleteMax.contains(
                                        maxillarySubcategorydropdownvalue),
                                builder: (context) => DropdownButtonFormField(
                                  value: maxillarySubcategorydropdownvalue,
                                  decoration: InputDecoration(
                                    label: Text('Choose Sub Category'),
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
                                      child: Text(items,style: TextStyle(
                                        color: cc.defcol,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,)),
                                    );
                                  }).toList(),
                                ),
                              ),
                              ConditionalBuilder(
                                builder: (context) => SizedBox(),
                                condition: doctorLayoutcubit
                                        .get(context)
                                        .isMaxillofacial ||
                                    doctorLayoutcubit
                                        .get(context)
                                        .isFullmouth ||
                                    maxillaryCategorydropdownvalue ==
                                        'Maxillofacial Case' ||
                                    maxillaryCategorydropdownvalue ==
                                        'Full Mouth Rehabilitation',
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
                                    doctorLayoutcubit
                                        .get(context)
                                        .isFullmouth ||
                                    maxillaryCategorydropdownvalue ==
                                        'Maxillofacial Case' ||
                                    maxillaryCategorydropdownvalue ==
                                        'Full Mouth Rehabilitation',
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
                                        'Mandibular Single Denture') {
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
                                      child: Text(
                                        items,
                                        style: TextStyle(
                                          color: cc.defcol,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              ConditionalBuilder(
                                fallback: (context) => SizedBox(),
                                condition: doctorLayoutcubit
                                        .get(context)
                                        .isPartialMAN ||
                                    itemsPartialman.contains(
                                        mandibularSubcategorydropdownvalue),
                                builder: (context) => DropdownButtonFormField(
                                  value: mandibularSubcategorydropdownvalue,
                                  decoration: InputDecoration(
                                    label: Text('Choose Sub Category'),
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
                                      child: Text(
                                        items,
                                        style: TextStyle(
                                          color: cc.defcol,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              ConditionalBuilder(
                                fallback: (context) => SizedBox(),
                                condition: doctorLayoutcubit
                                        .get(context)
                                        .isCompleteMAN ||
                                    itemsCompleteman.contains(
                                        mandibularSubcategorydropdownvalue),
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
                                      child: Text(items,style: TextStyle(
                                        color: cc.defcol,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,)),
                                    );
                                  }).toList(),
                                ),
                              ),
                              DropdownButtonFormField(
                                value: leveldropdownvalue,
                                decoration: InputDecoration(
                                  label: Text('Choose Level',style: TextStyle(
                                    color: Color(0xFF06A4FF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),),
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
                                    child: Text(items,style: TextStyle(
                                      color: cc.defcol,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,)),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              if (model.images.length > 0)
                                Container(
                                  height: 300,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      4.0,
                                    ),
                                  ),
                                  child: GridView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                    ),
                                    itemCount: model.images.length,
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        alignment: AlignmentDirectional.topEnd,
                                        children: [
                                          Image.network(
                                            model.images[index],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                          IconButton(
                                            icon: CircleAvatar(
                                              radius: 15.0,
                                              child: Icon(
                                                Icons.close,
                                                size: 16.0,
                                              ),
                                              backgroundColor:
                                                  Color(0xFFB8F5FF),
                                            ),
                                            onPressed: () {
                                              doctorLayoutcubit
                                                  .get(context)
                                                  .removeImage(
                                                      model.images[index]);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              SizedBox(
                                height: 10.0,
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
        );
      },
    );
  }
}
