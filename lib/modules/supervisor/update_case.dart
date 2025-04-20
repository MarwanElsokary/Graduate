import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/shared/styles/colors.dart';
import '../../layout/supervisor/supervisorcubit/cubit.dart';
import '../../layout/supervisor/supervisorcubit/states.dart';
import '../../shared/components/components.dart';

class editCaseScreen extends StatelessWidget {
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
    var model1 = supervisorLayoutcubit.get(context).supervisorClickcase;
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
    return BlocConsumer<supervisorLayoutcubit, supervisorLayoutstates>(
      listener: (context, state) {
        if (state is superUpdateCaseSucessState) {
          showtoast(
              text: ' Case Updated successfully', state: toaststates.SUCCESS);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var model = supervisorLayoutcubit.get(context).supervisorClickcase;
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
              backgroundColor: Color(0xFFB8F5FF),
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
                  supervisorLayoutcubit
                      .get(context)
                      .showCompleteSubCategoryMAX(false);
                  supervisorLayoutcubit
                      .get(context)
                      .showPartialSubCategoryMAX(false);
                  supervisorLayoutcubit
                      .get(context)
                      .showCompleteSubCategoryMAN(false);
                  supervisorLayoutcubit
                      .get(context)
                      .showPartialSubCategoryMAN(false);
                  supervisorLayoutcubit.get(context).IsFullmouth(false);
                  supervisorLayoutcubit.get(context).IsMaxillofacial(false);
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    if (formkey3.currentState!.validate()) {
                      supervisorLayoutcubit.get(context).updateCase(
                            dateTime: model.dateTime!,
                            patientName: patientNameController.text,
                            patientAge: patientAgeController.text,
                            gender: patientGenderController.text,
                            patientAddress: patientAdressController.text,
                            patientPhone: patienPhoneController.text,
                            currentMedications:
                                currentMedicationsController.text,
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
                                mandibularModificationdropdownvalue
                                            .toString() ==
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
              ]),
          body: Card(
            color: Color.fromRGBO(255, 255, 255, 0.82),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              side: BorderSide(
                color: Color.fromRGBO(107, 201, 255, 1),
                width: 2,
              ),
            ),
            elevation: 0.0,
            margin: EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      ConditionalBuilder(
                        condition: model.image != null,
                        builder: (context) => Stack(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(
                                '${model.image}',
                              ),
                            ),
                          ],
                        ),
                        fallback: (context) => Stack(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
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
                            Center(
                              child: Text(
                                '${model.name}',
                                style: TextStyle(
                                    height: 1.4,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF004E7F)),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Center(
                              child: Text(
                                '${model.dateTime}',
                                style: TextStyle(
                                    height: 1.4,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF004E7F)),
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
                      color: cc.defcol,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formkey3,
                        child: Column(
                          children: [
                            defaulttextformfield(
                              radius: 30,
                              controller: patientNameController,
                              keyboardtype: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter Patient Name';
                                }
                              },
                              label: '',
                              bordercolor: Color(0xFF06A4FF),
                              labelcolor: Color(0xFF004E7F),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            defaulttextformfield(
                              radius: 30,
                              controller: patientAgeController,
                              keyboardtype: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter Patient Age';
                                }
                              },
                              label: '',
                              bordercolor: Color(0xFF06A4FF),
                              labelcolor: Color(0xFF004E7F),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            defaulttextformfield(
                                radius: 30,
                                controller: patientGenderController,
                                keyboardtype: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter Patient Gender';
                                  }
                                },
                                label: '',
                                bordercolor: Color(0xFF06A4FF),
                                labelcolor: Color(0xFF004E7F)),
                            SizedBox(
                              height: 8,
                            ),
                            defaulttextformfield(
                              radius: 30,
                              controller: patientAdressController,
                              keyboardtype: TextInputType.streetAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter Patient Address';
                                }
                              },
                              label: '',
                              bordercolor: Color(0xFF06A4FF),
                              labelcolor: Color(0xFF004E7F),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            defaulttextformfield(
                              radius: 30,
                              controller: patienPhoneController,
                              keyboardtype: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter Patient phone number';
                                }
                              },
                              label: '',
                              bordercolor: Color(0xFF06A4FF),
                              labelcolor: Color(0xFF004E7F),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            defaulttextformfield(
                              radius: 30,
                              controller: currentMedicationsController,
                              keyboardtype: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter Patient medication no medication?? write none';
                                }
                              },
                              label: '',
                              bordercolor: Color(0xFF06A4FF),
                              labelcolor: Color(0xFF004E7F),
                            ),
                            SizedBox(
                              height: 8,
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
                                    isDiabetes = supervisorLayoutcubit
                                        .get(context)
                                        .superChangeDiabetes(isDiabetes);
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
                                    print(isCardiac);
                                    print(value);
                                    isCardiac = supervisorLayoutcubit
                                        .get(context)
                                        .superChangeCardiac(isCardiac);
                                    print(isCardiac);
                                  },
                                ),
                                Text(
                                  'Cardiac problems',
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
                                    isAllergies = supervisorLayoutcubit
                                        .get(context)
                                        .superChangeAllergies(isAllergies);
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
                                    isHypertension = supervisorLayoutcubit
                                        .get(context)
                                        .superChangeHypertension(
                                            isHypertension);
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
                              condition: supervisorLayoutcubit
                                      .get(context)
                                      .isMaxillofacial ||
                                  supervisorLayoutcubit
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
                                      fontSize: 15,
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
                                if (newValue == 'Maxillary Complete Denture') {
                                  supervisorLayoutcubit
                                      .get(context)
                                      .showCompleteSubCategoryMAX(true);
                                  supervisorLayoutcubit
                                      .get(context)
                                      .IsFullmouth(false);
                                  supervisorLayoutcubit
                                      .get(context)
                                      .IsMaxillofacial(false);
                                  supervisorLayoutcubit
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
                                    'Maxillary Partial Denture') {
                                  supervisorLayoutcubit
                                      .get(context)
                                      .showPartialSubCategoryMAX(true);
                                  supervisorLayoutcubit
                                      .get(context)
                                      .IsFullmouth(false);
                                  supervisorLayoutcubit
                                      .get(context)
                                      .IsMaxillofacial(false);
                                  supervisorLayoutcubit
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
                                  supervisorLayoutcubit
                                      .get(context)
                                      .IsMaxillofacial(true);
                                  supervisorLayoutcubit
                                      .get(context)
                                      .IsFullmouth(false);
                                  supervisorLayoutcubit
                                      .get(context)
                                      .showCompleteSubCategoryMAX(false);
                                  supervisorLayoutcubit
                                      .get(context)
                                      .showPartialSubCategoryMAX(false);
                                  supervisorLayoutcubit
                                      .get(context)
                                      .showCompleteSubCategoryMAN(false);
                                  supervisorLayoutcubit
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
                                  supervisorLayoutcubit
                                      .get(context)
                                      .IsFullmouth(true);
                                  supervisorLayoutcubit
                                      .get(context)
                                      .IsMaxillofacial(false);
                                  supervisorLayoutcubit
                                      .get(context)
                                      .showCompleteSubCategoryMAX(false);
                                  supervisorLayoutcubit
                                      .get(context)
                                      .showPartialSubCategoryMAX(false);
                                  supervisorLayoutcubit
                                      .get(context)
                                      .showCompleteSubCategoryMAN(false);
                                  supervisorLayoutcubit
                                      .get(context)
                                      .showPartialSubCategoryMAN(false);
                                  maxillarySubcategorydropdownvalue = null;
                                  maxillaryModificationdropdownvalue = null;
                                  mandibularSubcategorydropdownvalue = null;
                                  mandibularModificationdropdownvalue = null;
                                } else {
                                  supervisorLayoutcubit
                                      .get(context)
                                      .IsFullmouth(false);
                                  supervisorLayoutcubit
                                      .get(context)
                                      .IsMaxillofacial(false);
                                  supervisorLayoutcubit
                                      .get(context)
                                      .showCompleteSubCategoryMAX(false);
                                  supervisorLayoutcubit
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
                              condition: supervisorLayoutcubit
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
                                  maxillarySubcategorydropdownvalue = newValue!;
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
                              condition: supervisorLayoutcubit
                                      .get(context)
                                      .isPartialMAX ||
                                  itemsModMax.contains(
                                      maxillaryModificationdropdownvalue),
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
                              condition: supervisorLayoutcubit
                                      .get(context)
                                      .isCompleteMAX ||
                                  itemsCompleteMax.contains(
                                      maxillarySubcategorydropdownvalue),
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
                                  maxillarySubcategorydropdownvalue = newValue!;
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
                              condition: supervisorLayoutcubit
                                      .get(context)
                                      .isMaxillofacial ||
                                  supervisorLayoutcubit
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
                              condition: supervisorLayoutcubit
                                      .get(context)
                                      .isMaxillofacial ||
                                  supervisorLayoutcubit
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
                                    supervisorLayoutcubit
                                        .get(context)
                                        .IsMaxillofacial(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .IsFullmouth(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .showPartialSubCategoryMAN(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .showCompleteSubCategoryMAN(true);
                                    mandibularModificationdropdownvalue = null;
                                    mandibularSubcategorydropdownvalue = null;
                                  } else if (newValue ==
                                      'Mandibular Partial Denture') {
                                    supervisorLayoutcubit
                                        .get(context)
                                        .IsMaxillofacial(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .IsFullmouth(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .showCompleteSubCategoryMAN(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .showPartialSubCategoryMAN(true);
                                    mandibularSubcategorydropdownvalue = null;
                                    mandibularModificationdropdownvalue =
                                        'Un Modified';
                                  } else if (newValue == 'Maxillofacial Case') {
                                    pre = 'Maxillofacial Case';
                                    maxillaryCategorydropdownvalue =
                                        'Maxillofacial Case';
                                    supervisorLayoutcubit
                                        .get(context)
                                        .IsMaxillofacial(true);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .IsFullmouth(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .showCompleteSubCategoryMAN(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .showPartialSubCategoryMAN(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .showCompleteSubCategoryMAX(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .showPartialSubCategoryMAX(false);
                                    mandibularSubcategorydropdownvalue = null;
                                    mandibularModificationdropdownvalue = null;
                                    maxillaryModificationdropdownvalue = null;
                                    maxillarySubcategorydropdownvalue = null;
                                  } else if (newValue ==
                                      'Full Mouth Rehabilitation') {
                                    pre = 'Full Mouth Rehabilitation';
                                    maxillaryCategorydropdownvalue =
                                        'Full Mouth Rehabilitation';
                                    supervisorLayoutcubit
                                        .get(context)
                                        .IsFullmouth(true);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .IsMaxillofacial(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .showCompleteSubCategoryMAN(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .showPartialSubCategoryMAN(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .showCompleteSubCategoryMAX(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .showPartialSubCategoryMAX(false);
                                    mandibularSubcategorydropdownvalue = null;
                                    mandibularModificationdropdownvalue = null;
                                    maxillaryModificationdropdownvalue = null;
                                    maxillarySubcategorydropdownvalue = null;
                                  } else {
                                    supervisorLayoutcubit
                                        .get(context)
                                        .showCompleteSubCategoryMAN(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .showPartialSubCategoryMAN(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .IsMaxillofacial(false);
                                    supervisorLayoutcubit
                                        .get(context)
                                        .IsFullmouth(false);
                                    mandibularModificationdropdownvalue = null;
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
                              condition: supervisorLayoutcubit
                                      .get(context)
                                      .isPartialMAN ||
                                  itemsPartialman.contains(
                                      mandibularSubcategorydropdownvalue),
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
                              condition: supervisorLayoutcubit
                                      .get(context)
                                      .isPartialMAN ||
                                  itemsModman.contains(
                                      mandibularModificationdropdownvalue),
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
                              condition: supervisorLayoutcubit
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
                                            backgroundColor: Colors.white,
                                          ),
                                          onPressed: () {
                                            supervisorLayoutcubit
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
        );
      },
    );
  }
}
