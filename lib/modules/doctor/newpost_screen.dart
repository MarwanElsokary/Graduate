// /*import 'dart:ffi';
//
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:icon_broken/icon_broken.dart';
// import 'package:project/shared/styles/colors.dart';
//
// import '../../layout/doctor/doctorcubit/cubit.dart';
// import '../../layout/doctor/doctorcubit/states.dart';
// import '../../shared/components/components.dart';
//
// class newPostScreen extends StatelessWidget {
//   var textController = TextEditingController();
//   String? categorydropdownvalue = null;
//   var items = [
//     'complete denture',
//     'partial denture',
//     ' overdenture',
//     'single denture',
//     'maxillofacial case',
//     'full mouth rehabilitation',
//   ];
//   String? subcategorydropdownvalue = null;
//   var items2 = [
//     'Flat Ridge',
//     'Well Developed Ridge',
//     'kennedy |',
//     'kennedy ||',
//     'kennedy |||',
//     'kennedy |V',
//     'none'
//   ];
//   String? leveldropdownvalue = null;
//   var items3 = [
//     'Level 4',
//     'Level 5',
//     'postgraduate ',
//   ];
//
//   List _items = [
//     'https://d3i71xaburhd42.cloudfront.net/bd1dda091dc895f3f2dfee27bedb5beed39bfc53/250px/5-Figure4-1.png',
//     'https://d3i71xaburhd42.cloudfront.net/bd1dda091dc895f3f2dfee27bedb5beed39bfc53/250px/6-Figure5-1.png',
//     'https://d3i71xaburhd42.cloudfront.net/bd1dda091dc895f3f2dfee27bedb5beed39bfc53/250px/6-Figure6-1.png',
//     'https://d3i71xaburhd42.cloudfront.net/bd1dda091dc895f3f2dfee27bedb5beed39bfc53/250px/6-Figure7-1.png',
//     'https://d3i71xaburhd42.cloudfront.net/bd1dda091dc895f3f2dfee27bedb5beed39bfc53/250px/6-Figure8-1.png',
//   ];
//
//   bool isDiabetes=false;
//   bool isHypertension=false;
//   bool isCardiac=false;
//   bool isAllergies=false;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<doctorLayoutcubit, doctorLayoutstates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//           appBar:AppBar(
//               title: Text('New Case',),
//               actions: [
//                 defaultTextButton(
//                 onpress: () {  }, text: ' post',size: 15,
//                 ),
//                 ]
//           ),
//           body: Card(
//             clipBehavior: Clip.antiAliasWithSaveLayer,
//             elevation: 5.0,
//             margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 25.0,
//                         backgroundImage: NetworkImage(
//                             'https://media.istockphoto.com/id/1298261537/vector/blank-man-profile-head-icon-placeholder.jpg?s=612x612&w=0&k=20&c=CeT1RVWZzQDay4t54ookMaFsdi7ZHVFg2Y5v7hxigCA='                        ),
//                       ),
//                       SizedBox(
//                         width: 15.0,
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'ahmed mahmoud',
//                               style: TextStyle(
//                                 height: 1.4,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 5.0,
//                             ),
//                             Text(
//                               'what patient case do you have ..',
//                               style:
//                               Theme.of(context).textTheme.caption?.copyWith(
//                                 height: 1.4,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 8.0,
//                     ),
//                     child: Container(
//                       width: double.infinity,
//                       height: 1.0,
//                       color: cc.defcol,
//                     ),
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           TextFormField(
//                              // controller: textController,
//                               keyboardType: TextInputType.name,
//                               decoration: InputDecoration(
//                                 hintText: 'patient name',
//                                 border: InputBorder.none,
//                               )),
//                           TextFormField(
//                              // controller: textController,
//                             keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                 hintText: 'patient age',
//                                 border: InputBorder.none,
//                               )),
//                           TextFormField(
//                             // controller: textController,
//                               keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                 hintText: 'gender',
//                                 border: InputBorder.none,
//                               )),
//                           TextFormField(
//                             // controller: textController,
//                               keyboardType: TextInputType.streetAddress,
//
//                               decoration: InputDecoration(
//                                 hintText: 'patient address',
//                                 border: InputBorder.none,
//                               )),
//                           TextFormField(
//                             // controller: textController,
//                               keyboardType: TextInputType.phone,
//
//                               decoration: InputDecoration(
//                                 hintText: 'patient phone',
//
//                                 border: InputBorder.none,
//                               )),
//                           TextFormField(
//                             // controller: textController,
//                               keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                 hintText: 'Current medicaton',
//                                 border: InputBorder.none,
//                               )),
//
//
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text('Medical History',style: TextStyle(
//                               fontSize: 15,
//                             )),
//                           ),
//                           Row(
//                             children: [
//
//                               Checkbox(value: isDiabetes,
//                                 activeColor:  defaultcol,
//                                   tristate:false ,
//                                   onChanged: (value){
//                                     isDiabetes=!isDiabetes!;
//                                   }),
//                               Text('Diabetes'),
//                               SizedBox(width: 30,),
//                               Checkbox(value: isCardiac,
//                                    activeColor:  defaultcol,
//                                   tristate:false ,
//                                   onChanged: (value){
//                                     isCardiac=!isCardiac!;
//                                   }),
//                               Text('Cardiac problems'),
//                             ],
//                           ),
//                           Row(
//                             children: [
//
//                               Checkbox(value: isAllergies,
//                                   activeColor:  defaultcol,
//                                   tristate:false ,
//                                   onChanged: (value){
//                                     isAllergies=!isAllergies!;
//                                   }),
//                               Text('Allergies'),
//                               SizedBox(width: 30,),
//                               Checkbox(value: isHypertension,
//                                   activeColor:  defaultcol,
//                                   tristate:false ,
//                                   onChanged: (value){
//                                     isHypertension=!isHypertension!;
//                                   }),
//                               Text('Hypertension'),
//                             ],
//                           ),
//                        ConditionalBuilder(condition: isAllergies, builder: (context) =>  TextFormField(
//                          // controller: textController,
//                            keyboardType: TextInputType.text,
//                            decoration: InputDecoration(
//                              hintText: 'Allergies ',
//                              border: InputBorder.none,
//                            )), fallback: (context) =>SizedBox() ),
//
//                           TextFormField(
//                             // controller: textController,
//                               keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                 hintText: 'others...',
//                                 border: InputBorder.none,
//                               )),
//                           DropdownButtonFormField(
//                             value: categorydropdownvalue,
//                             decoration: InputDecoration(
//                               label: Text('choose category'),
//                               border: InputBorder.none,
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                             icon: const Icon(
//                               IconBroken.Arrow___Down_2,
//                               color: cc.defcol,
//                             ),
//                             validator: (value) {
//                               if (value == null) {
//                                 return 'please choose  category';
//                               }
//                             },
//                             onChanged: (String? newValue) {
//                               categorydropdownvalue = newValue!;
//                               print(categorydropdownvalue);
//                             },
//                             items: items.map((String items) {
//                               return DropdownMenuItem(
//                                 value: items,
//                                 child: Text(items),
//                               );
//                             }).toList(),
//                           ),
//                           DropdownButtonFormField(
//                             value: subcategorydropdownvalue,
//                             decoration: InputDecoration(
//                               label: Text('choose  sub category'),
//                               border: InputBorder.none,
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                             icon: const Icon(
//                               IconBroken.Arrow___Down_2,
//                               color: cc.defcol,
//                             ),
//                             validator: (value) {
//                               if (value == null) {
//                                 return 'please choose  subcategory';
//                               }
//                             },
//                             onChanged: (String? newValue) {
//                               subcategorydropdownvalue = newValue!;
//                               print(subcategorydropdownvalue);
//                             },
//                             items: items2.map((String items) {
//                               return DropdownMenuItem(
//                                 value: items,
//                                 child: Text(items),
//                               );
//                             }).toList(),
//                           ),
//                           DropdownButtonFormField(
//                             value: leveldropdownvalue,
//                             decoration: InputDecoration(
//                               label: Text('choose Level'),
//                               border: InputBorder.none,
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                             icon: const Icon(
//                               IconBroken.Arrow___Down_2,
//                               color: cc.defcol,
//                             ),
//                             validator: (value) {
//                               if (value == null) {
//                                 return 'please choose  level ';
//                               }
//                             },
//                             onChanged: (String? newValue) {
//                               leveldropdownvalue = newValue!;
//                               print(leveldropdownvalue);
//                             },
//                             items: items3.map((String items) {
//                               return DropdownMenuItem(
//                                 value: items,
//                                 child: Text(items),
//                               );
//                             }).toList(),
//                           ),
//                           SizedBox(
//                             height: 20.0,
//                           ),
//                           Container(
//                             height: 300,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(
//                                 4.0,
//                               ),
//                             ),
//                             child: GridView.builder(
//                               physics: NeverScrollableScrollPhysics(),
//                               shrinkWrap: true,
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 5,
//                                 mainAxisSpacing: 5,
//                               ),
//                               itemCount: getcount(),
//                               itemBuilder: (context, index) {
//                                 if (index < 3) {
//                                   return Container(
//                                     decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                         fit: BoxFit.cover,
//                                         image: NetworkImage(_items[index]),
//                                       ),
//                                     ),
//                                   );
//                                 }
//                                 if (index == 3) {
//                                   return Stack(
//                                     fit: StackFit.expand,
//                                     children: [
//                                       Image.network(_items[3], fit: BoxFit.cover),
//                                       Positioned.fill(
//                                         child: Container(
//                                           alignment: Alignment.center,
//                                           color: Colors.black54,
//                                           child: Text(
//                                             '+${(_items.length) - 4}',
//                                             style: TextStyle(
//                                                 fontSize: 32,
//                                                 color: Colors.white),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 }
//                               },
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10.0,
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextButton(
//                           onPressed: () {
//                             //    SocialCubit.get(context).getPostImage();
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 IconBroken.Image,
//                               ),
//                               SizedBox(
//                                 width: 5.0,
//                               ),
//                               Text(
//                                 'Add photo',
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: TextButton(
//                           onPressed: () {
//                             //    SocialCubit.get(context).getPostImage();
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 IconBroken.Camera,
//                               ),
//                               SizedBox(
//                                 width: 5.0,
//                               ),
//                               Text(
//                                 'Take photo',
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   dynamic getcount() {
//     if (_items.length > 4) {
//       return 4;
//     } else {
//       return _items.length;
//     }
//   }
// }
// */
// // import 'dart:io';
// //
// // import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:icon_broken/icon_broken.dart';
//  // import 'package:project/shared/styles/colors.dart';
// // import '../../layout/doctor/doctorcubit/cubit.dart';
// // import '../../layout/doctor/doctorcubit/states.dart';
// // import '../../shared/components/components.dart';
// // import '../student/change_password.dart';
// //
// // class newPostScreen extends StatelessWidget {
// //   var textController = TextEditingController();
// //   String? categorydropdownvalue;
// //   var items = [
// //     'complete denture',
// //     'partial denture',
// //     'overdenture',
// //     'single denture',
// //     'maxillofacial case',
// //     'full mouth rehabilitation',
// //   ];
// //   String? subcategorydropdownvalue;
// //   var items2 = [
// //     'Flat Ridge',
// //     'Well Developed Ridge',
// //     'kennedy |',
// //     'kennedy ||',
// //     'kennedy |||',
// //     'kennedy |V',
// //     'none'
// //   ];
// //   String? leveldropdownvalue;
// //   var items3 = [
// //     'Level 4',
// //     'Level 5',
// //     'postgraduate ',
// //   ];
// //   var formkey2 = GlobalKey<FormState>();
// //   bool isDiabetes = false;
// //   bool isHypertension = false;
// //   bool isCardiac = false;
// //   bool isAllergies = false;
// //   var patientNameController = TextEditingController();
// //   var patientAgeController = TextEditingController();
// //   var patientGenderController = TextEditingController();
// //   var patientAdressController = TextEditingController();
// //   var patienPhoneController = TextEditingController();
// //   var otherController = TextEditingController();
// //   var imagesController = TextEditingController();
// //   var currentMedicationsController = TextEditingController();
// //   var allergiesController = TextEditingController();
// //   List  imgs=[];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocConsumer<doctorLayoutcubit, doctorLayoutstates>(
// //       listener: (context, state) {
// //         if (state is doctorNewPostSucessState) {
// //           doctorLayoutcubit.get(context).selectedImages.clear();
// //           doctorLayoutcubit.get(context).takedImages.clear();
// //           patientNameController.clear();
// //           patientAgeController.clear();
// //           patientGenderController.clear();
// //           patientAdressController.clear();
// //           patienPhoneController.clear();
// //           currentMedicationsController.clear();
// //           categorydropdownvalue = null;
// //           isDiabetes = false;
// //           isHypertension = false;
// //           isCardiac = false;
// //           isAllergies = false;
// //           subcategorydropdownvalue = null;
// //           otherController.clear();
// //           allergiesController.clear();
// //           imgs.clear();
// //           leveldropdownvalue = null;
// //           showtoast(
// //               text: 'Case Added Successfully', state: toaststates.SUCCESS);
// //         }
// //       },
// //       builder: (context, state) {
// //         var userModel = doctorLayoutcubit.get(context).doctormodel;
// //         var caseImages = doctorLayoutcubit.get(context).selectedImages;
// //         var takedImages = doctorLayoutcubit.get(context).takedImages;
// //         imgs=[];
// //         imgs.addAll(caseImages);
// //         imgs.addAll(takedImages);
// //         print(imgs.length);
// //         return Scaffold(
// //           appBar: AppBar(
// //               title: Text(
// //                 'New Case',
// //               ),
// //               actions: [
// //                 defaultTextButton(
// //                   onpress: () {
// //                     var now = DateTime.now();
// //                     if (formkey2.currentState!.validate()) {
// //                       if (caseImages.length == 0 && takedImages.length == 0) {
// //                         showtoast(
// //                             text: 'you must add your case photos',
// //                             state: toaststates.ERROR);
// //                       } else {
// //                         doctorLayoutcubit.get(context).uploadCaseImage(
// //                               dateTime: now.toString(),
// //                               patientName: patientNameController.text,
// //                               patientAge: patientAgeController.text,
// //                               gender: patientGenderController.text,
// //                               patientAddress: patientAdressController.text,
// //                               patientPhone: patienPhoneController.text,
// //                               currentMedications:
// //                                   currentMedicationsController.text,
// //                               category: categorydropdownvalue.toString(),
// //                               isAllergies: isAllergies,
// //                               isCardiac: isCardiac,
// //                               isDiabetes: isDiabetes,
// //                               isHypertension: isHypertension,
// //                               subCategory: subcategorydropdownvalue.toString(),
// //                               others: otherController.text,
// //                               allergies: allergiesController.text,
// //                               level: leveldropdownvalue.toString(),
// //                             );
// //                       }
// //                     } else {
// //                       print('no validation');
// //                     }
// //                   },
// //                   text: ' post',
// //                   size: 15,
// //                 ),
// //               ]),
// //           body: Card(
// //             clipBehavior: Clip.antiAliasWithSaveLayer,
// //             elevation: 5.0,
// //             margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
// //             child: Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Column(
// //                 children: [
// //                   if (state is doctorNewPostLoadingState)
// //                     LinearProgressIndicator(),
// //                   if (state is doctorNewPostLoadingState)
// //                     SizedBox(
// //                       height: 10.0,
// //                     ),
// //                   Row(
// //                     children: [
// //                       ConditionalBuilder(
// //                         condition: userModel?.image != null,
// //                         builder: (context) => Stack(
// //                           children: [
// //                             CircleAvatar(
// //                               radius: 25.0,
// //                               backgroundImage: NetworkImage(
// //                                 '${userModel?.image}',
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                         fallback: (context) => Stack(
// //                           children: [
// //                             CircleAvatar(
// //                               radius: 25.0,
// //                               backgroundImage:
// //                                   AssetImage('images/profileimage.jpg'),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       SizedBox(
// //                         width: 15.0,
// //                       ),
// //                       Expanded(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               '${userModel?.name}',
// //                               style: TextStyle(
// //                                 height: 1.4,
// //                                 fontSize: 15,
// //                               ),
// //                             ),
// //                             SizedBox(
// //                               width: 5.0,
// //                             ),
// //                             Text(
// //                               'what patient case do you have ..',
// //                               style:
// //                                   Theme.of(context).textTheme.caption?.copyWith(
// //                                         height: 1.4,
// //                                       ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.symmetric(
// //                       vertical: 8.0,
// //                     ),
// //                     child: Container(
// //                       width: double.infinity,
// //                       height: 1.0,
// //                       color: cc.defcol,
// //                     ),
// //                   ),
// //                   Expanded(
// //                     child: SingleChildScrollView(
// //                       child: Form(
// //                         key: formkey2,
// //                         child: Column(
// //                           children: [
// //                             TextFormField(
// //                                 controller: patientNameController,
// //                                 keyboardType: TextInputType.name,
// //                                 validator: (value) {
// //                                   if (value!.isEmpty) {
// //                                     return 'please enter Patient Name';
// //                                   }
// //                                 },
// //                                 decoration: InputDecoration(
// //                                   hintText: 'patient name',
// //                                   border: InputBorder.none,
// //                                 )),
// //                             TextFormField(
// //                                 controller: patientAgeController,
// //                                 keyboardType: TextInputType.number,
// //                                 validator: (value) {
// //                                   if (value!.isEmpty) {
// //                                     return 'please enter Patient Age';
// //                                   }
// //                                 },
// //                                 decoration: InputDecoration(
// //                                   hintText: 'patient age',
// //                                   border: InputBorder.none,
// //                                 )),
// //                             TextFormField(
// //                                 controller: patientGenderController,
// //                                 keyboardType: TextInputType.text,
// //                                 validator: (value) {
// //                                   if (value!.isEmpty) {
// //                                     return 'please enter Patient Gender';
// //                                   }
// //                                 },
// //                                 decoration: InputDecoration(
// //                                   hintText: 'gender',
// //                                   border: InputBorder.none,
// //                                 )),
// //                             TextFormField(
// //                                 controller: patientAdressController,
// //                                 keyboardType: TextInputType.streetAddress,
// //                                 validator: (value) {
// //                                   if (value!.isEmpty) {
// //                                     return 'please enter Patient Address';
// //                                   }
// //                                 },
// //                                 decoration: InputDecoration(
// //                                   hintText: 'patient address',
// //                                   border: InputBorder.none,
// //                                 )),
// //                             TextFormField(
// //                                 controller: patienPhoneController,
// //                                 keyboardType: TextInputType.phone,
// //                                 validator: (value) {
// //                                   if (value!.isEmpty) {
// //                                     return 'please enter Patient phone number';
// //                                   }
// //                                 },
// //                                 decoration: InputDecoration(
// //                                   hintText: 'patient phone',
// //                                   border: InputBorder.none,
// //                                 )),
// //                             TextFormField(
// //                                 controller: currentMedicationsController,
// //                                 keyboardType: TextInputType.text,
// //                                 validator: (value) {
// //                                   if (value!.isEmpty) {
// //                                     return 'please enter Patient medication no medication?? write none';
// //                                   }
// //                                 },
// //                                 decoration: InputDecoration(
// //                                   hintText: 'Current medicaton',
// //                                   border: InputBorder.none,
// //                                 )),
// //                             Align(
// //                               alignment: Alignment.centerLeft,
// //                               child: Text('Medical History',
// //                                   style: TextStyle(
// //                                     fontSize: 15,
// //                                   )),
// //                             ),
// //                             Row(
// //                               children: [
// //                                 Checkbox(
// //                                   tristate: false,
// //                                   value: isDiabetes,
// //                                   activeColor: defaultcol,
// //                                   onChanged: (value) {
// //                                     isDiabetes = doctorLayoutcubit
// //                                         .get(context)
// //                                         .changeDiabetes();
// //                                   },
// //                                 ),
// //                                 Text('Diabetes'),
// //                                 SizedBox(
// //                                   width: 30,
// //                                 ),
// //                                 Checkbox(
// //                                   tristate: false,
// //                                   value: isCardiac,
// //                                   activeColor: defaultcol,
// //                                   onChanged: (value) {
// //                                     isCardiac = doctorLayoutcubit
// //                                         .get(context)
// //                                         .changeCardiac();
// //                                   },
// //                                 ),
// //                                 Text('Cardiac problems'),
// //                               ],
// //                             ),
// //                             Row(
// //                               children: [
// //                                 Checkbox(
// //                                   tristate: false,
// //                                   value: isAllergies,
// //                                   activeColor: defaultcol,
// //                                   onChanged: (value) {
// //                                     isAllergies = doctorLayoutcubit
// //                                         .get(context)
// //                                         .changeAllergies();
// //                                   },
// //                                 ),
// //                                 Text('Allergies'),
// //                                 SizedBox(
// //                                   width: 30,
// //                                 ),
// //                                 Checkbox(
// //                                   value: isHypertension,
// //                                   activeColor: defaultcol,
// //                                   tristate: false,
// //                                   onChanged: (value) {
// //                                     isHypertension = doctorLayoutcubit
// //                                         .get(context)
// //                                         .changeHypertension();
// //                                   },
// //                                 ),
// //                                 Text('Hypertension'),
// //                               ],
// //                             ),
// //                             ConditionalBuilder(
// //                                 condition: isAllergies,
// //                                 builder: (context) => TextFormField(
// //                                     controller: allergiesController,
// //                                     keyboardType: TextInputType.text,
// //                                     validator: (value) {
// //                                       if (value!.isEmpty) {
// //                                         return 'please enter patient Allergies';
// //                                       }
// //                                     },
// //                                     decoration: InputDecoration(
// //                                       hintText: 'Allergies ',
// //                                       border: InputBorder.none,
// //                                     )),
// //                                 fallback: (context) => SizedBox()),
// //                             TextFormField(
// //                                 controller: otherController,
// //                                 keyboardType: TextInputType.text,
// //                                 decoration: InputDecoration(
// //                                   hintText: 'others...',
// //                                   border: InputBorder.none,
// //                                 )),
// //                             DropdownButtonFormField(
// //                               value: categorydropdownvalue,
// //                               decoration: InputDecoration(
// //                                 label: Text('choose category'),
// //                                 border: InputBorder.none,
// //                                 focusedBorder: OutlineInputBorder(
// //                                   borderSide: BorderSide.none,
// //                                 ),
// //                               ),
// //                               icon: const Icon(
// //                                 IconBroken.Arrow___Down_2,
// //                                 color: cc.defcol,
// //                               ),
// //                               validator: (value) {
// //                                 if (value == null) {
// //                                   return 'please choose  category';
// //                                 }
// //                               },
// //                               onChanged: (String? newValue) {
// //                                 categorydropdownvalue = newValue!;
// //                                 print(categorydropdownvalue);
// //                               },
// //                               items: items.map((String items) {
// //                                 return DropdownMenuItem(
// //                                   value: items,
// //                                   child: Text(items),
// //                                 );
// //                               }).toList(),
// //                             ),
// //                             DropdownButtonFormField(
// //                               value: subcategorydropdownvalue,
// //                               decoration: InputDecoration(
// //                                 label: Text('choose  sub category'),
// //                                 border: InputBorder.none,
// //                                 focusedBorder: OutlineInputBorder(
// //                                   borderSide: BorderSide.none,
// //                                 ),
// //                               ),
// //                               icon: const Icon(
// //                                 IconBroken.Arrow___Down_2,
// //                                 color: cc.defcol,
// //                               ),
// //                               validator: (value) {
// //                                 if (value == null) {
// //                                   return 'please choose  subcategory';
// //                                 }
// //                               },
// //                               onChanged: (String? newValue) {
// //                                 subcategorydropdownvalue = newValue!;
// //                                 print(subcategorydropdownvalue);
// //                               },
// //                               items: items2.map((String items) {
// //                                 return DropdownMenuItem(
// //                                   value: items,
// //                                   child: Text(items),
// //                                 );
// //                               }).toList(),
// //                             ),
// //                             DropdownButtonFormField(
// //                               value: leveldropdownvalue,
// //                               decoration: InputDecoration(
// //                                 label: Text('choose Level'),
// //                                 border: InputBorder.none,
// //                                 focusedBorder: OutlineInputBorder(
// //                                   borderSide: BorderSide.none,
// //                                 ),
// //                               ),
// //                               icon: const Icon(
// //                                 IconBroken.Arrow___Down_2,
// //                                 color: cc.defcol,
// //                               ),
// //                               validator: (value) {
// //                                 if (value == null) {
// //                                   return 'please choose  level ';
// //                                 }
// //                               },
// //                               onChanged: (String? newValue) {
// //                                 leveldropdownvalue = newValue!;
// //                                 print(leveldropdownvalue);
// //                               },
// //                               items: items3.map((String items) {
// //                                 return DropdownMenuItem(
// //                                   value: items,
// //                                   child: Text(items),
// //                                 );
// //                               }).toList(),
// //                             ),
// //                             SizedBox(
// //                               height: 20.0,
// //                             ),
// //                             if (imgs.isNotEmpty)
// //                                Container(
// //                                   height: 300,
// //                                   width: double.infinity,
// //                                   decoration: BoxDecoration(
// //                                     borderRadius: BorderRadius.circular(
// //                                       4.0,
// //                                     ),
// //                                   ),
// //                                   child: GridView.builder(
// //                                     physics: BouncingScrollPhysics(),
// //                                     shrinkWrap: true,
// //                                     gridDelegate:
// //                                     SliverGridDelegateWithFixedCrossAxisCount(
// //                                       crossAxisCount: 2,
// //                                       crossAxisSpacing: 5,
// //                                       mainAxisSpacing: 5,
// //                                     ),
// //                                     itemCount: imgs.length,
// //                                     itemBuilder: (context, index) {
// //
// //                                       return Stack(
// //                                         alignment: AlignmentDirectional.topEnd,
// //                                         children: [
// //                                           Image.file(
// //                                             File(imgs[index]!.path),
// //                                             fit: BoxFit.cover,
// //                                             width: double.infinity,
// //                                           ),
// //                                           IconButton(
// //                                             icon: CircleAvatar(
// //                                               radius: 15.0,
// //
// //                                               child: Icon(
// //                                                 Icons.close,
// //                                                 size: 16.0,
// //                                               ),
// //                                               backgroundColor: Colors.white,
// //                                             ),
// //                                             onPressed: ()
// //                                             {
// //                                                 doctorLayoutcubit.get(context).removePostImage(imgs[index]!.path);
// //                                             },
// //                                           ),
// //                                         ],
// //
// //                                       );
// //                                     },
// //                                   ),
// //                                 ),
// //                             SizedBox(
// //                               height: 10.0,
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: TextButton(
// //                           onPressed: () {
// //                             doctorLayoutcubit.get(context).selectImages();
// //                           },
// //                           child: Row(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children: [
// //                               Icon(
// //                                 IconBroken.Image,
// //                               ),
// //                               SizedBox(
// //                                 width: 5.0,
// //                               ),
// //                               Text(
// //                                 'Add photo',
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                       Expanded(
// //                         child: TextButton(
// //                           onPressed: () {
// //                             doctorLayoutcubit.get(context).takeImages();
// //                           },
// //                           child: Row(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children: [
// //                               Icon(
// //                                 IconBroken.Camera,
// //                               ),
// //                               SizedBox(
// //                                 width: 5.0,
// //                               ),
// //                               Text(
// //                                 'Take photo',
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
// import 'dart:io';
//
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
//  import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:icon_broken/icon_broken.dart';
// import 'package:intl/intl.dart';
// import 'package:project/shared/styles/colors.dart';
// import '../../layout/doctor/doctorcubit/cubit.dart';
// import '../../layout/doctor/doctorcubit/states.dart';
// import '../../shared/components/components.dart';
//
// class newPostScreen extends StatelessWidget {
//   var textController = TextEditingController();
//   String? maxillaryCategorydropdownvalue;
//   var itemsMax = [
//     'Maxillary Complete Denture',
//     'Maxillary Partial Denture',
//     'Maxillary Overdenture',
//     'Maxillary Single Denture',
//     'Maxillofacial Case',
//     'Full Mouth Rehabilitation',
//   ];
//   String? maxillarySubcategorydropdownvalue;
//   var itemsCompleteMax = [
//     'Flat Ridge',
//     'Well Developed Ridge',
//   ];
//   var itemsPartialMax = [
//     'kennedy |',
//     'kennedy ||',
//     'kennedy |||',
//     'kennedy |V',
//   ];
//   String? maxillaryModificationdropdownvalue;
//   var itemsModMax = ['1', '2', '3', '4', '5', '6', '7', '8', 'Un Modified'];
//   String? mandibularCategorydropdownvalue;
//   var itemsman = [
//     'Mandibular Complete Denture',
//     'Mandibular Partial Denture',
//     'Mandibular Overdenture',
//     'Mandibular Single Denture',
//     'Maxillofacial Case',
//     'Full Mouth Rehabilitation',
//   ];
//   String? mandibularSubcategorydropdownvalue;
//   var itemsCompleteman = [
//     'Flat Ridge',
//     'Well Developed Ridge',
//   ];
//   var itemsPartialman = [
//     'kennedy |',
//     'kennedy ||',
//     'kennedy |||',
//     'kennedy |V',
//   ];
//   String? mandibularModificationdropdownvalue;
//   var itemsModman = [
//     '1',
//     '2',
//     '3',
//     '4',
//     '5',
//     '6',
//     '7',
//     '8',
//     'Un Modified',
//   ];
//   String? leveldropdownvalue;
//   var items3 = [
//     'Level 4',
//     'Level 5',
//     'postgraduate ',
//   ];
//   var formkey2 = GlobalKey<FormState>();
//   bool isDiabetes = false;
//   bool isHypertension = false;
//   bool isCardiac = false;
//   bool isAllergies = false;
//   var patientNameController = TextEditingController();
//   var patientAgeController = TextEditingController();
//   var patientGenderController = TextEditingController();
//   var patientAdressController = TextEditingController();
//   var patienPhoneController = TextEditingController();
//   var otherController = TextEditingController();
//   var imagesController = TextEditingController();
//   var currentMedicationsController = TextEditingController();
//   var allergiesController = TextEditingController();
//   List imgs = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<doctorLayoutcubit, doctorLayoutstates>(
//       listener: (context, state) {
//         if (state is doctorNewPostSucessState) {
//           doctorLayoutcubit.get(context).selectedImages.clear();
//           doctorLayoutcubit.get(context).takedImages.clear();
//           patientNameController.clear();
//           patientAgeController.clear();
//           patientGenderController.clear();
//           patientAdressController.clear();
//           patienPhoneController.clear();
//           currentMedicationsController.clear();
//           isDiabetes = false;
//           isHypertension = false;
//           isCardiac = false;
//           isAllergies = false;
//           maxillaryCategorydropdownvalue = null;
//           maxillarySubcategorydropdownvalue = null;
//           mandibularCategorydropdownvalue = null;
//           mandibularSubcategorydropdownvalue = null;
//           mandibularModificationdropdownvalue = null;
//           maxillaryModificationdropdownvalue = null;
//           otherController.clear();
//           allergiesController.clear();
//           imgs.clear();
//           leveldropdownvalue = null;
//           // doctorLayoutcubit.get(context).showCompleteSubCategoryMAX(false);
//           // doctorLayoutcubit.get(context).showPartialSubCategoryMAX(false);
//           // doctorLayoutcubit.get(context).showCompleteSubCategoryMAN(false);
//           // doctorLayoutcubit.get(context).showPartialSubCategoryMAN(false);
//           showtoast(
//               text: 'Case Added Successfully', state: toaststates.SUCCESS);
//         }
//       },
//       builder: (context, state) {
//         var userModel = doctorLayoutcubit.get(context).doctormodel;
//         var caseImages = doctorLayoutcubit.get(context).selectedImages;
//         var takedImages = doctorLayoutcubit.get(context).takedImages;
//         // var ii=doctorLayoutcubit.get(context).labels;
//         // for (var key in ii.keys) print(key); // prints Key_1 then Key_2
//         // for (var value in ii.values) print(value); // prints Value_1 then Value_2
//         // for (var entry in ii.entries) {
//         //   print(entry.key);
//         //   print(entry.value);
//         }
//         // var entryList = ii.entries.toList();
//         //  imgs = [];
//         // imgs.addAll(caseImages);
//         // imgs.addAll(takedImages);
//         // print(imgs.length);
//         // return Scaffold(
//           appBar: AppBar(
//               title: Text(
//                 'New Case',
//               ),
//               actions: [
//                 defaultTextButton(
//                   onpress: () {
//                      var now = DateTime.now();
//                     var formatter = DateFormat('dd-MM-yyyy HH:mm ');
//                     String formattedDate = formatter.format(now);
//
//                     if (formkey2.currentState!.validate()) {
//                       if (caseImages.length == 0 && takedImages.length == 0) {
//                         showtoast(
//                             text: 'you must add your case photos',
//                             state: toaststates.ERROR);
//                       } else {
//                         doctorLayoutcubit.get(context).uploadCaseImage(
//                               dateTime: formattedDate.toString(),
//                               patientName: patientNameController.text,
//                               patientAge: patientAgeController.text,
//                               gender: patientGenderController.text,
//                               patientAddress: patientAdressController.text,
//                               patientPhone: patienPhoneController.text,
//                               currentMedications:
//                                   currentMedicationsController.text,
//                               isAllergies: isAllergies,
//                               isCardiac: isCardiac,
//                               isDiabetes: isDiabetes,
//                               isHypertension: isHypertension,
//                               others: otherController.text,
//                               allergies: allergiesController.text,
//                               level: leveldropdownvalue.toString(),
//                               mandibularCategory:
//                                   mandibularCategorydropdownvalue.toString(),
//                               mandibularModification:
//                                   mandibularModificationdropdownvalue
//                                               .toString() ==
//                                           'null'
//                                       ? ' '
//                                       : mandibularModificationdropdownvalue
//                                           .toString(),
//                               mandibularSubCategory:
//                                   mandibularSubcategorydropdownvalue
//                                               .toString() ==
//                                           'null'
//                                       ? ' '
//                                       : mandibularSubcategorydropdownvalue
//                                           .toString(),
//                               maxillaryCategory:
//                                   maxillaryCategorydropdownvalue.toString(),
//                               maxillaryModification:
//                                   maxillaryModificationdropdownvalue
//                                               .toString() ==
//                                           'null'
//                                       ? ' '
//                                       : maxillaryModificationdropdownvalue
//                                           .toString(),
//                               maxillarySubCategory:
//                                   maxillarySubcategorydropdownvalue
//                                               .toString() ==
//                                           'null'
//                                       ? ' '
//                                       : maxillarySubcategorydropdownvalue
//                                           .toString(),
//                             );
//                       }
//                     } else {
//                       print('no validation');
//                     }
//                   },
//                   text: ' post',
//                   size: 15,
//                 ),
//               ]),
//           body: Card(
//             clipBehavior: Clip.antiAliasWithSaveLayer,
//             elevation: 5.0,
//             margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   if (state is doctorNewPostLoadingState)
//                     LinearProgressIndicator(),
//                   if (state is doctorNewPostLoadingState)
//                     SizedBox(
//                       height: 10.0,
//                     ),
//                   Row(
//                     children: [
//                       ConditionalBuilder(
//                         condition: userModel?.image != null,
//                         builder: (context) => Stack(
//                           children: [
//                             CircleAvatar(
//                               radius: 25.0,
//                               backgroundImage: NetworkImage(
//                                 '${userModel?.image}',
//                               ),
//                             ),
//                           ],
//                         ),
//                         fallback: (context) => Stack(
//                           children: [
//                             CircleAvatar(
//                               radius: 25.0,
//                               backgroundImage:
//                                   AssetImage('images/profileimage.jpg'),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         width: 15.0,
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               '${userModel?.name}',
//                               style: TextStyle(
//                                 height: 1.4,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 5.0,
//                             ),
//                             Text(
//                               'what patient case do you have ..',
//                               style:
//                                   Theme.of(context).textTheme.bodyMedium?.copyWith(
//                                         height: 1.4,
//                                       ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 8.0,
//                     ),
//                     child: Container(
//                       width: double.infinity,
//                       height: 1.0,
//                       color: cc.defcol,
//                     ),
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Form(
//                         key: formkey2,
//                         child: Column(
//                           children: [
//                             TextFormField(
//                                 controller: patientNameController,
//                                 keyboardType: TextInputType.name,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'Please Enter Patient Name';
//                                   }
//                                 },
//                                 decoration: InputDecoration(
//                                   hintText: 'Patient Name',
//                                   border: InputBorder.none,
//                                 )),
//                             TextFormField(
//                                 controller: patientAgeController,
//                                 keyboardType: TextInputType.number,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'Please Enter Patient Age';
//                                   }
//                                 },
//                                 decoration: InputDecoration(
//                                   hintText: 'Patient Age',
//                                   border: InputBorder.none,
//                                 )),
//                             TextFormField(
//                                 controller: patientGenderController,
//                                 keyboardType: TextInputType.text,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'Please Enter Patient Gender';
//                                   }
//                                 },
//                                 decoration: InputDecoration(
//                                   hintText: 'Patient Gender',
//                                   border: InputBorder.none,
//                                 )),
//                             TextFormField(
//                                 controller: patientAdressController,
//                                 keyboardType: TextInputType.streetAddress,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'Please Enter Patient Address';
//                                   }
//                                 },
//                                 decoration: InputDecoration(
//                                   hintText: 'Patient Address',
//                                   border: InputBorder.none,
//                                 )),
//                             TextFormField(
//                                 controller: patienPhoneController,
//                                 maxLength: 11,
//                                 keyboardType: TextInputType.phone,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'Please Enter Patient Phone Number';
//                                   }
//                                   if (value.length<11) {
//                                     return 'please enter valid phone number';
//                                   }
//                                 },
//                                 decoration: InputDecoration(
//                                   hintText: 'Patient Phone',
//                                   border: InputBorder.none,
//                                 )),
//                             TextFormField(
//                                 controller: currentMedicationsController,
//                                 keyboardType: TextInputType.text,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'Please Enter Patient Medication No Medication?? write none';
//                                   }
//                                 },
//                                 decoration: InputDecoration(
//                                   hintText: 'Current Medicaton',
//                                   border: InputBorder.none,
//                                 )),
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text('Medical History',
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     color: cc.defcol,
//                                   )),
//                             ),
//                             Row(
//                               children: [
//                                 Checkbox(
//                                   tristate: false,
//                                   value: isDiabetes,
//                                   activeColor: defaultcol,
//                                   onChanged: (value) {
//                                     // isDiabetes = doctorLayoutcubit
//                                     //     .get(context)
//                                     //     .changeDiabetes();
//                                   },
//                                 ),
//                                 Text('Diabetes'),
//                                 SizedBox(
//                                   width: 30,
//                                 ),
//                                 Checkbox(
//                                   tristate: false,
//                                   value: isCardiac,
//                                   activeColor: defaultcol,
//                                   onChanged: (value) {
//                                     isCardiac = doctorLayoutcubit
//                                         .get(context)
//                                         .changeCardiac();
//                                   },
//                                 ),
//                                 Text('Cardiac Problems'),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Checkbox(
//                                   tristate: false,
//                                   value: isAllergies,
//                                   activeColor: defaultcol,
//                                   onChanged: (value) {
//                                     isAllergies = doctorLayoutcubit
//                                         .get(context)
//                                         .changeAllergies();
//                                   },
//                                 ),
//                                 Text('Allergies'),
//                                 SizedBox(
//                                   width: 30,
//                                 ),
//                                 Checkbox(
//                                   value: isHypertension,
//                                   activeColor: defaultcol,
//                                   tristate: false,
//                                   onChanged: (value) {
//                                     isHypertension = doctorLayoutcubit
//                                         .get(context)
//                                         .changeHypertension();
//                                   },
//                                 ),
//                                 Text('Hypertension'),
//                               ],
//                             ),
//                             ConditionalBuilder(
//                                 condition: isAllergies,
//                                 builder: (context) => TextFormField(
//                                     controller: allergiesController,
//                                     keyboardType: TextInputType.text,
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return 'Please Enter Patient Allergies';
//                                       }
//                                     },
//                                     decoration: InputDecoration(
//                                       hintText: 'Allergies ',
//                                       border: InputBorder.none,
//                                     )),
//                                 fallback: (context) => SizedBox()),
//                             TextFormField(
//                                 controller: otherController,
//                                 keyboardType: TextInputType.text,
//                                 decoration: InputDecoration(
//                                   hintText: 'Others...',
//                                   border: InputBorder.none,
//                                 )),
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text('Maxillary',
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     color: cc.defcol,
//                                   )),
//                             ),
//                             SizedBox(
//                               height: 20.0,
//                             ),
//                             DropdownButtonFormField(
//                               value: maxillaryCategorydropdownvalue,
//                               decoration: InputDecoration(
//                                 label: Text('Choose Category'),
//                                 border: InputBorder.none,
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                               icon: const Icon(
//                                 IconBroken.Arrow___Down_2,
//                                 color: cc.defcol,
//                               ),
//                               validator: (value) {
//                                 if (value == null) {
//                                   return 'Please Choose Category';
//                                 }
//                               },
//                               onChanged: (String? newValue) {
//                                 maxillaryCategorydropdownvalue = newValue!;
//                                 print(maxillaryCategorydropdownvalue);
//                                 if (newValue == 'Maxillary Complete Denture') {
//                                   doctorLayoutcubit
//                                       .get(context)
//                                       .showPartialSubCategoryMAX(false);
//                                   doctorLayoutcubit
//                                       .get(context)
//                                       .showCompleteSubCategoryMAX(true);
//                                   maxillaryModificationdropdownvalue = null;
//                                   maxillarySubcategorydropdownvalue = null;
//                                 } else if (newValue ==
//                                     'Maxillary Partial Denture') {
//                                   doctorLayoutcubit
//                                       .get(context)
//                                       .showCompleteSubCategoryMAX(false);
//                                   doctorLayoutcubit
//                                       .get(context)
//                                       .showPartialSubCategoryMAX(true);
//                                   maxillarySubcategorydropdownvalue = null;
//                                   maxillaryModificationdropdownvalue =
//                                       'Un Modified';
//                                 } else {
//                                   doctorLayoutcubit
//                                       .get(context)
//                                       .showCompleteSubCategoryMAX(false);
//                                   doctorLayoutcubit
//                                       .get(context)
//                                       .showPartialSubCategoryMAX(false);
//                                   maxillaryModificationdropdownvalue = null;
//                                   maxillarySubcategorydropdownvalue = null;
//                                 }
//                               },
//                               items: itemsMax.map((String items) {
//                                 return DropdownMenuItem(
//                                   value: items,
//                                   child: Text(items),
//                                 );
//                               }).toList(),
//                             ),
//                             ConditionalBuilder(
//                               fallback: (context) => SizedBox(),
//                               condition:
//                                   doctorLayoutcubit.get(context).isPartialMAX,
//                               builder: (context) => DropdownButtonFormField(
//                                 value: maxillarySubcategorydropdownvalue,
//                                 decoration: InputDecoration(
//                                   label: Text('Choose  Sub Category'),
//                                   border: InputBorder.none,
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide.none,
//                                   ),
//                                 ),
//                                 icon: const Icon(
//                                   IconBroken.Arrow___Down_2,
//                                   color: cc.defcol,
//                                 ),
//                                 validator: (value) {
//                                   if (value == null) {
//                                     return 'Please Choose Subcategory';
//                                   }
//                                 },
//                                 onChanged: (String? newValue) {
//                                   maxillarySubcategorydropdownvalue = newValue!;
//                                   print(maxillarySubcategorydropdownvalue);
//                                 },
//                                 items: itemsPartialMax.map((String items) {
//                                   return DropdownMenuItem(
//                                     value: items,
//                                     child: Text(items),
//                                   );
//                                 }).toList(),
//                               ),
//                             ),
//                             ConditionalBuilder(
//                               fallback: (context) => SizedBox(),
//                               condition:
//                                   doctorLayoutcubit.get(context).isPartialMAX,
//                               builder: (context) => DropdownButtonFormField(
//                                 value: maxillaryModificationdropdownvalue,
//                                 decoration: InputDecoration(
//                                   label: Text('Choose  Modification'),
//                                   border: InputBorder.none,
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide.none,
//                                   ),
//                                 ),
//                                 icon: const Icon(
//                                   IconBroken.Arrow___Down_2,
//                                   color: cc.defcol,
//                                 ),
//                                 validator: (value) {
//                                   if (value == null) {
//                                     return 'Please Choose Modification';
//                                   }
//                                 },
//                                 onChanged: (String? newValue) {
//                                   maxillaryModificationdropdownvalue =
//                                       newValue!;
//                                   print(maxillaryModificationdropdownvalue);
//                                 },
//                                 items: itemsModMax.map((String items) {
//                                   return DropdownMenuItem(
//                                     value: items,
//                                     child: Text(items),
//                                   );
//                                 }).toList(),
//                               ),
//                             ),
//                             ConditionalBuilder(
//                               fallback: (context) => SizedBox(),
//                               condition:
//                                   doctorLayoutcubit.get(context).isCompleteMAX,
//                               builder: (context) => DropdownButtonFormField(
//                                 value: maxillarySubcategorydropdownvalue,
//                                 decoration: InputDecoration(
//                                   label: Text('Choose Sub Category'),
//                                   border: InputBorder.none,
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide.none,
//                                   ),
//                                 ),
//                                 icon: const Icon(
//                                   IconBroken.Arrow___Down_2,
//                                   color: cc.defcol,
//                                 ),
//                                 validator: (value) {
//                                   if (value == null) {
//                                     return 'Please Choose Subcategory';
//                                   }
//                                 },
//                                 onChanged: (String? newValue) {
//                                   maxillarySubcategorydropdownvalue = newValue!;
//                                   print(maxillarySubcategorydropdownvalue);
//                                 },
//                                 items: itemsCompleteMax.map((String items) {
//                                   return DropdownMenuItem(
//                                     value: items,
//                                     child: Text(items),
//                                   );
//                                 }).toList(),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text('Mandibular',
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     color: cc.defcol,
//                                   )),
//                             ),
//                             SizedBox(
//                               height: 20.0,
//                             ),
//                             DropdownButtonFormField(
//                               value: mandibularCategorydropdownvalue,
//                               decoration: InputDecoration(
//                                 label: Text('Choose Category'),
//                                 border: InputBorder.none,
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                               icon: const Icon(
//                                 IconBroken.Arrow___Down_2,
//                                 color: cc.defcol,
//                               ),
//                               validator: (value) {
//                                 if (value == null) {
//                                   return 'Please Choose Category';
//                                 }
//                               },
//                               onChanged: (String? newValue) {
//                                 mandibularCategorydropdownvalue = newValue!;
//                                 print(mandibularCategorydropdownvalue);
//                                 if (newValue == 'Mandibular Complete Denture') {
//                                   doctorLayoutcubit
//                                       .get(context)
//                                       .showPartialSubCategoryMAN(false);
//                                   doctorLayoutcubit
//                                       .get(context)
//                                       .showCompleteSubCategoryMAN(true);
//                                   mandibularModificationdropdownvalue = null;
//                                   mandibularSubcategorydropdownvalue = null;
//                                  } else if (newValue ==
//                                     'Mandibular Partial Denture') {
//                                   doctorLayoutcubit
//                                       .get(context)
//                                       .showCompleteSubCategoryMAN(false);
//                                   doctorLayoutcubit
//                                       .get(context)
//                                       .showPartialSubCategoryMAN(true);
//                                   mandibularModificationdropdownvalue = null;
//                                   mandibularSubcategorydropdownvalue = null;
//                                   mandibularModificationdropdownvalue =
//                                       'Un Modified';
//                                 } else {
//                                   doctorLayoutcubit
//                                       .get(context)
//                                       .showCompleteSubCategoryMAN(false);
//                                   doctorLayoutcubit
//                                       .get(context)
//                                       .showPartialSubCategoryMAN(false);
//                                   mandibularModificationdropdownvalue = null;
//                                   mandibularSubcategorydropdownvalue = null;
//                                  }
//                               },
//                               items: itemsman.map((String items) {
//                                 return DropdownMenuItem(
//                                   value: items,
//                                   child: Text(items),
//                                 );
//                               }).toList(),
//                             ),
//                             ConditionalBuilder(
//                               fallback: (context) => SizedBox(),
//                               condition:
//                                   doctorLayoutcubit.get(context).isPartialMAN,
//                               builder: (context) => DropdownButtonFormField(
//                                 value: mandibularSubcategorydropdownvalue,
//                                 decoration: InputDecoration(
//                                   label: Text('Choose Sub Category'),
//                                   border: InputBorder.none,
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide.none,
//                                   ),
//                                 ),
//                                 icon: const Icon(
//                                   IconBroken.Arrow___Down_2,
//                                   color: cc.defcol,
//                                 ),
//                                 validator: (value) {
//                                   if (value == null) {
//                                     return 'Please Choose Subcategory';
//                                   }
//                                 },
//                                 onChanged: (String? newValue) {
//                                   mandibularSubcategorydropdownvalue =
//                                       newValue!;
//                                   print(mandibularSubcategorydropdownvalue);
//                                 },
//                                 items: itemsPartialman.map((String items) {
//                                   return DropdownMenuItem(
//                                     value: items,
//                                     child: Text(items),
//                                   );
//                                 }).toList(),
//                               ),
//                             ),
//                             ConditionalBuilder(
//                               fallback: (context) => SizedBox(),
//                               condition:
//                                   doctorLayoutcubit.get(context).isPartialMAN,
//                               builder: (context) => DropdownButtonFormField(
//                                 value: mandibularModificationdropdownvalue,
//                                 decoration: InputDecoration(
//                                   label: Text('Choose  Modification'),
//                                   border: InputBorder.none,
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide.none,
//                                   ),
//                                 ),
//                                 icon: const Icon(
//                                   IconBroken.Arrow___Down_2,
//                                   color: cc.defcol,
//                                 ),
//                                 validator: (value) {
//                                   if (value == null) {
//                                     return 'Please Choose Modification';
//                                   }
//                                 },
//                                 onChanged: (String? newValue) {
//                                   mandibularModificationdropdownvalue =
//                                       newValue!;
//                                   print(mandibularModificationdropdownvalue);
//                                 },
//                                 items: itemsModman.map((String items) {
//                                   return DropdownMenuItem(
//                                     value: items,
//                                     child: Text(items),
//                                   );
//                                 }).toList(),
//                               ),
//                             ),
//                             ConditionalBuilder(
//                               fallback: (context) => SizedBox(),
//                               condition:
//                                   doctorLayoutcubit.get(context).isCompleteMAN,
//                               builder: (context) => DropdownButtonFormField(
//                                 value: mandibularSubcategorydropdownvalue,
//                                 decoration: InputDecoration(
//                                   label: Text('Choose  Sub Category'),
//                                   border: InputBorder.none,
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide.none,
//                                   ),
//                                 ),
//                                 icon: const Icon(
//                                   IconBroken.Arrow___Down_2,
//                                   color: cc.defcol,
//                                 ),
//                                 validator: (value) {
//                                   if (value == null) {
//                                     return 'Please Choose Subcategory';
//                                   }
//                                 },
//                                 onChanged: (String? newValue) {
//                                   mandibularSubcategorydropdownvalue =
//                                       newValue!;
//                                   print(mandibularSubcategorydropdownvalue);
//                                 },
//                                 items: itemsCompleteman.map((String items) {
//                                   return DropdownMenuItem(
//                                     value: items,
//                                     child: Text(items),
//                                   );
//                                 }).toList(),
//                               ),
//                             ),
//                             DropdownButtonFormField(
//                               value: leveldropdownvalue,
//                               decoration: InputDecoration(
//                                 label: Text('Choose Level'),
//                                 border: InputBorder.none,
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                               icon: const Icon(
//                                 IconBroken.Arrow___Down_2,
//                                 color: cc.defcol,
//                               ),
//                               validator: (value) {
//                                 if (value == null) {
//                                   return 'Please Choose  Level ';
//                                 }
//                               },
//                               onChanged: (String? newValue) {
//                                 leveldropdownvalue = newValue!;
//                                 print(leveldropdownvalue);
//                               },
//                               items: items3.map((String items) {
//                                 return DropdownMenuItem(
//                                   value: items,
//                                   child: Text(items),
//                                 );
//                               }).toList(),
//                             ),
//                             SizedBox(
//                               height: 20.0,
//                             ),
//                             if (entryList.isNotEmpty)
//                               Container(
//                                 height: 300,
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(
//                                     4.0,
//                                   ),
//                                 ),
//                                 child: GridView.builder(
//                                   physics: BouncingScrollPhysics(),
//                                   shrinkWrap: true,
//                                   gridDelegate:
//                                       SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 2,
//                                     crossAxisSpacing: 5,
//                                     mainAxisSpacing: 5,
//                                   ),
//                                   itemCount: entryList.length,
//                                   itemBuilder: (context, index) {
//                                     return Column(
//                                       children: [
//
//                                                                                       Image.file(
//                                               File(entryList[index].key),
//                                               fit: BoxFit.cover,
//                                               width: double.infinity,
//                                             ),
//                                             Text(entryList[index].value),
//                                             IconButton(
//                                               icon: CircleAvatar(
//                                                 radius: 15.0,
//                                                 child: Icon(
//                                                   Icons.close,
//                                                   size: 16.0,
//                                                 ),
//                                                 backgroundColor: Colors.white,
//                                               ),
//                                               onPressed: () {
//                                                 doctorLayoutcubit
//                                                     .get(context)
//                                                     .removePostImage(
//                                                         imgs[index]!.path);
//                                               },
//                                             ),
//
//                                       ],
//                                     );
//                                   },
//                                 ),
//                               ),
//                             SizedBox(
//                               height: 10.0,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextButton(
//                           onPressed: () {
//                             doctorLayoutcubit.get(context).selectImages();
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 IconBroken.Image,
//                               ),
//                               SizedBox(
//                                 width: 5.0,
//                               ),
//                               Text(
//                                 'Add Photo',
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: TextButton(
//                           onPressed: () {
//                             doctorLayoutcubit.get(context).takeImages();
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 IconBroken.Camera,
//                               ),
//                               SizedBox(
//                                 width: 5.0,
//                               ),
//                               Text(
//                                 'Take Photo',
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
