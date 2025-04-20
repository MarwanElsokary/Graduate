import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/layout/doctor/doctorcubit/cubit.dart';
import 'package:project/layout/student/studentcubit/cubit.dart';
import 'package:project/layout/supervisor/supervisorcubit/cubit.dart';

import '../../models/case_model.dart';
import '../../modules/supervisor/update_case.dart';
import '../styles/colors.dart';
import 'constants.dart';

Widget defaultTextButton({
  required Function() onpress,
  required String text,
  double? size,
  TextAlign? textalign,
  FontWeight? fontweight,
}) =>
    TextButton(
        onPressed: onpress,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
              fontSize: size, fontWeight: fontweight, color: Color(0xFF2382FC)),
          textAlign: textalign,
        ));

Widget defaultbutton({
  double width = double.infinity,
  required void Function() onpress,
  required String text,
  bool upercase = true,
  double radius = 30.0,
  TextAlign? textalign,
  double? hight = 55.0,
}) =>
    Container(
      width: width,
      height: hight,
      decoration: BoxDecoration(
        color: Color(0xFF004E7F), // تأكد إن defaultcol هو اللون الأزرق الغامق
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            offset: Offset(0, 4), // ظل للأسفل
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: onpress,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(
          upercase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: textalign,
        ),
      ),
    );

Widget defaulttextformfield({
  required TextEditingController controller,
  required TextInputType keyboardtype,
  void Function(String)? onsubmit,
  void Function(String)? onshange,
  void Function()? ontap,
  required String? Function(String?)? validator,
  bool hidepassword = false,
  required String label,
  Color labelcolor = Colors.black,
  double radius = 0,
  Color bordercolor = Colors.black,
  IconData? prefix,
  IconData? suffix,
  int? maxLength,
  void Function()? onpress,
  void Function()? suffixPressed,
  bool? enabled,
}) =>
    Container(
      decoration: BoxDecoration(
        boxShadow: [],
        borderRadius: BorderRadius.circular(radius),
      ),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        keyboardType: keyboardtype,
        onFieldSubmitted: onsubmit,
        onChanged: onshange,
        onTap: ontap,
        enabled: enabled,
        validator: validator,
        obscureText: hidepassword,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: label,
          counterText: '',
          labelStyle: TextStyle(
            color: labelcolor,
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: bordercolor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          prefixIcon: Icon(
            prefix,
            color: Colors.blue,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(suffix, color: Colors.blue),
                )
              : null,
        ),
      ),
    );

PreferredSizeWidget? defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
  IconData? icon,
}) =>
    AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          IconBroken.Arrow___Left_2,
        ),
      ),
      titleSpacing: 5.0,
      title: Text(
        title!,
      ),
      actions: actions,
    );

Widget rowItmes({
  required String text1,
  required String text2,
  int? maxline,
  TextOverflow overflow = TextOverflow.visible,
}) =>
    RichText(
      maxLines: maxline,
      overflow: overflow,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: text1,
            style: TextStyle(
              color: HexColor('#004E7F'),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
              text: text2,
              style: TextStyle(
                  color: HexColor("#06A4FF"),
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );

void navigateto(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigate(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

void showtoast({
  required String text,
  required toaststates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: toastcolor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum toaststates { SUCCESS, ERROR, WARNNING }

Color? toastcolor(toaststates state) {
  Color? color;
  switch (state) {
    case toaststates.SUCCESS:
      color = Colors.green;
      break;
    case toaststates.ERROR:
      color = Colors.red[900];
      break;
    case toaststates.WARNNING:
      color = Colors.black45;
      break;
  }
  return color;
}

Widget studentDefaultbuildPost(
  caseModel model,
  context,
  Widget w,
  studentLayoutcubit studentLayoutcubit,
) =>
    InkWell(
      onTap: () async {
        await studentLayoutcubit.studentGetCase(model.caseId as String);
        navigateto(context, w);
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ConditionalBuilder(
                    condition: model?.image != null,
                    builder: (context) => Stack(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(
                            '${model?.image}',
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
                        Text(
                          '${model.name}',
                          style: TextStyle(
                              height: 1.4,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF004E7F)),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '${model.dateTime}',
                          style: TextStyle(
                              height: 1.4,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF004E7F)),
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
                  color: Colors.grey[300],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Medical history:',
                style: TextStyle(color: HexColor('#5394AD'), fontSize: 15),
              ),
              ConditionalBuilder(
                  condition: model.isDiabetes as bool,
                  builder: (context) => Text('diabetes'),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.isCardiac as bool,
                  builder: (context) => Text('cardiac problems'),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.isHypertension as bool,
                  builder: (context) => Text('hypertension'),
                  fallback: (context) => SizedBox()),
              SizedBox(
                height: 5,
              ),
              ConditionalBuilder(
                  condition: model.isAllergies as bool,
                  builder: (context) => rowItmes(
                        text1: 'List of allergies:   ',
                        text2: '${model.allergies}',
                        maxline: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  fallback: (context) => SizedBox()),
              SizedBox(
                height: 5,
              ),
              Text(
                'Diagnosis :',
                style: TextStyle(color: HexColor('#5394AD'), fontSize: 15),
              ),
              ConditionalBuilder(
                  condition: model!.maxillaryCategory!.length! > 0,
                  builder: (context) => Text('${model?.maxillaryCategory}'),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.maxillarySubCategory!.length > 0 &&
                      model.maxillarySubCategory != ' ',
                  builder: (context) => Text('${model?.maxillarySubCategory}'),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.maxillaryModification!.length > 0 &&
                      model.maxillaryModification != 'Un Modified' &&
                      model.maxillaryModification != ' ',
                  builder: (context) =>
                      Text('modification :${model?.maxillaryModification}'),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model!.mandibularCategory! ==
                          'Full Mouth Rehabilitation' ||
                      model!.mandibularCategory! == 'Maxillofacial Case',
                  fallback: (context) => Text('${model?.mandibularCategory}'),
                  builder: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.mandibularSubCategory!.length > 0 &&
                      model.mandibularSubCategory != ' ',
                  builder: (context) => Text('${model?.mandibularSubCategory}'),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.mandibularModification!.length > 0 &&
                      model.mandibularModification != 'Un Modified' &&
                      model.mandibularModification != ' ',
                  builder: (context) =>
                      Text('modification :${model?.mandibularModification}'),
                  fallback: (context) => SizedBox()),
              rowItmes(
                text1: 'Current medications: ',
                text2: '${model.currentMedications}',
                maxline: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 7,
              ),
              ConditionalBuilder(
                  condition: model.others!.length > 0,
                  builder: (context) => rowItmes(
                        text1: 'Other notes : ',
                        text2: '${model.others}',
                        maxline: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  fallback: (context) => SizedBox()),
              SizedBox(
                height: 7,
              ),
              if (model.images.length != 0)
                ConditionalBuilder(
                  condition: model.images.length == 1,
                  builder: (context) => Container(
                    //       height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                    ),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: getcount(model.images.length),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(model.images[index]),
                              ),
                            ),
                          );
                        }),
                  ),
                  fallback: (context) => Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                    ),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: getcount(model.images.length),
                        itemBuilder: (context, index) {
                          if (model.images.length > 4) {
                            if (index < 3) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(model.images[index]),
                                  ),
                                ),
                              );
                            }
                            if (index == 3) {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(model.images[3],
                                      fit: BoxFit.contain),
                                  Positioned.fill(
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: Colors.black54,
                                      child: Text(
                                        '+${(model.images.length) - 4}',
                                        style: TextStyle(
                                            fontSize: 32, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          } else if (model.images.length <= 4) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(model.images[index]),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              if (model.caseState == 'WAITING' &&
                  !model.studentRequests!.contains(UID))
                defaultbutton(
                  onpress: () {
                    studentLayoutcubit.getStudentData();
                    var m = studentLayoutcubit.studentmodel;
                    if (m!.supervisorId == null)
                      showtoast(
                          text:
                              'currently you don\'t have a supervisor please select one to request contact information',
                          state: toaststates.ERROR);
                    else {
                      studentLayoutcubit.createRequest(
                        status: 'pending',
                        supervisorid: m!.supervisorId!,
                        studentid: UID,
                        studentname: m!.name!,
                        studentimage:
                            m!.image != null ? m!.image as String : null,
                        requestid: '',
                        doctorid: model!.uId as String,
                        doctorname: model!.name as String,
                        doctorimage: model!.image != null
                            ? model!.image as String
                            : null,
                        caseid: model.caseId as String,
                        patientAge: model!.patientAge as String,
                        patientName: model!.patientName as String,
                        patientPhone: model!.patientPhone as String,
                        gender: model!.gender as String,
                        currentMedications: model!.currentMedications as String,
                        dateTime: model!.dateTime as String,
                        level: model!.level as String,
                        patientAddress: model!.patientAddress as String,
                        others: model!.others as String,
                        images: model!.images,
                        allergies: model!.allergies as String,
                        isHypertension: model!.isHypertension,
                        isAllergies: model!.isAllergies,
                        isCardiac: model!.isCardiac,
                        isDiabetes: model!.isDiabetes,
                        mandibularCategory: model!.mandibularCategory as String,
                        mandibularModification:
                            model!.mandibularModification.toString() == 'null'
                                ? ' '
                                : model!.mandibularModification.toString(),
                        mandibularSubCategory:
                            model!.mandibularSubCategory.toString() == 'null'
                                ? ' '
                                : model!.mandibularSubCategory.toString(),
                        maxillaryCategory: model!.maxillaryCategory.toString(),
                        maxillaryModification:
                            model!.maxillaryModification.toString() == 'null'
                                ? ' '
                                : model!.maxillaryModification.toString(),
                        maxillarySubCategory:
                            model!.maxillarySubCategory.toString() == 'null'
                                ? ' '
                                : model!.maxillarySubCategory.toString(),
                      );
                    }
                  },
                  text: 'Request conatct information',
                  radius: 30,
                ),
              if (model.caseState == 'WAITING' &&
                  model.studentRequests!.contains(UID))
                defaultbutton(
                  onpress: () {
                    studentLayoutcubit.deleteRequest(model.caseId);
                  },
                  text: 'Un Request conatct information',
                  radius: 30,
                ),
            ],
          ),
        ),
      ),
    );

dynamic getcount(int count) {
  if (count > 4) {
    return 4;
  } else {
    return count;
  }
}

Widget doctorBuildPost(
  caseModel model,
  context,
  Widget w,
  doctorLayoutcubit doctorLayoutcubit,
) =>
    InkWell(
      onTap: () {
        // doctorLayoutcubit.doctorGetCase(model.caseId as String);
        navigateto(context, w);
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ConditionalBuilder(
                    condition: model?.image != null,
                    builder: (context) => Stack(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(
                            '${model?.image}',
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
                        Text(
                          ' ${model.name}',
                          style: TextStyle(
                            height: 1.4,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          ' ${model.dateTime}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    height: 1.4,
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
                  color: Colors.grey[300],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Medical history:',
                style: TextStyle(color: HexColor('#5394AD'), fontSize: 15),
              ),
              ConditionalBuilder(
                  condition: model.isDiabetes as bool,
                  builder: (context) => Text('diabetes'),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.isCardiac as bool,
                  builder: (context) => Text('cardiac problems'),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.isHypertension as bool,
                  builder: (context) => Text('hypertension'),
                  fallback: (context) => SizedBox()),
              SizedBox(
                height: 5,
              ),
              ConditionalBuilder(
                  condition: model.isAllergies as bool,
                  builder: (context) => rowItmes(
                        text1: 'List of allergies:   ',
                        text2: '${model.allergies}',
                        maxline: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  fallback: (context) => SizedBox()),
              SizedBox(
                height: 5,
              ),
              Text(
                'Diagnosis :',
                style: TextStyle(color: HexColor('#5394AD'), fontSize: 15),
              ),
              ConditionalBuilder(
                  condition: model!.maxillaryCategory!.length! > 0,
                  builder: (context) => Text('${model?.maxillaryCategory}'),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.maxillarySubCategory!.length > 0 &&
                      model.maxillarySubCategory != ' ',
                  builder: (context) => Text('${model?.maxillarySubCategory}'),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.maxillaryModification!.length > 0 &&
                      model.maxillaryModification != 'Un Modified' &&
                      model.maxillaryModification != ' ',
                  builder: (context) =>
                      Text('modification :${model?.maxillaryModification}'),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model!.mandibularCategory! ==
                          'Full Mouth Rehabilitation' ||
                      model!.mandibularCategory! == 'Maxillofacial Case',
                  fallback: (context) => Text('${model?.mandibularCategory}'),
                  builder: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.mandibularSubCategory!.length > 0 &&
                      model.mandibularSubCategory != ' ',
                  builder: (context) => Text('${model?.mandibularSubCategory}'),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.mandibularModification!.length > 0 &&
                      model.mandibularModification != 'Un Modified' &&
                      model.mandibularModification != ' ',
                  builder: (context) =>
                      Text('modification :${model?.mandibularModification}'),
                  fallback: (context) => SizedBox()),
              rowItmes(
                text1: 'Current medications: ',
                text2: '${model.currentMedications}',
                maxline: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 7,
              ),
              ConditionalBuilder(
                  condition: model.others!.length > 0,
                  builder: (context) => rowItmes(
                        text1: 'Other notes : ',
                        text2: '${model.others}',
                        maxline: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  fallback: (context) => SizedBox()),
              SizedBox(
                height: 7,
              ),
              if (model.images.length != 0)
                ConditionalBuilder(
                  condition: model.images.length == 1,
                  builder: (context) => Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                    ),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: getcount(model.images.length),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(model.images[index]),
                              ),
                            ),
                          );
                        }),
                  ),
                  fallback: (context) => Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                    ),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: getcount(model.images.length),
                        itemBuilder: (context, index) {
                          if (model.images.length > 4) {
                            if (index < 3) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(model.images[index]),
                                  ),
                                ),
                              );
                            }
                            if (index == 3) {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(model.images[3],
                                      fit: BoxFit.contain),
                                  Positioned.fill(
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: Colors.black54,
                                      child: Text(
                                        '+${(model.images.length) - 4}',
                                        style: TextStyle(
                                            fontSize: 32, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          } else if (model.images.length <= 4) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(model.images[index]),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );

Widget supervisorBuildPost(
  caseModel model,
  context,
  Widget w,
  supervisorLayoutcubit supervisorLayoutcubit,
) =>
    InkWell(
      onTap: () {
        supervisorLayoutcubit.supervisorGetCase(model.caseId as String);
        navigateto(context, w);
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Color.fromRGBO(255, 255, 255, 0.62),
        elevation: 0,
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ConditionalBuilder(
                    condition: model?.image != null,
                    builder: (context) => Stack(
                      children: [
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage: NetworkImage(
                            '${model?.image}',
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
                        Center(
                          child: Text(
                            '${model!.name}',
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
                            '${model!.dateTime}',
                            style: TextStyle(
                                height: 1.4,
                                fontSize: 14,
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
                  color: Colors.grey[300],
                ),
              ),
              Text(
                'Medical history:',
                style: TextStyle(
                  color: HexColor('#004E7F'),
                  fontSize: 16,
                ),
              ),
              ConditionalBuilder(
                  condition: model.isDiabetes! as bool,
                  builder: (context) => Text(
                        'diabetes',
                        style: TextStyle(
                          color: HexColor('#06A4FF'),
                          fontSize: 15,
                        ),
                      ),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.isCardiac! as bool,
                  builder: (context) => Text(
                        'cardiac problems',
                        style: TextStyle(
                          color: HexColor('#06A4FF'),
                          fontSize: 15,
                        ),
                      ),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.isHypertension! as bool,
                  builder: (context) => Text(
                        'hypertension',
                        style: TextStyle(
                          color: HexColor('#06A4FF'),
                          fontSize: 15,
                        ),
                      ),
                  fallback: (context) => SizedBox()),
              SizedBox(
                height: 5,
              ),
              ConditionalBuilder(
                  condition: model.isAllergies! as bool,
                  builder: (context) => rowItmes(
                        text1: 'List of allergies:',
                        text2: '${model!.allergies}',
                        maxline: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  fallback: (context) => SizedBox()),
              SizedBox(
                height: 5,
              ),
              Text(
                'Diagnosis :',
                style: TextStyle(
                  color: HexColor('#004E7F'),
                  fontSize: 16,
                ),
              ),
              ConditionalBuilder(
                  condition: model!.maxillaryCategory!.length! > 0,
                  builder: (context) => Text('${model?.maxillaryCategory}',style: TextStyle(
                    color: HexColor('#06A4FF'),
                    fontSize: 15,
                  ),),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.maxillarySubCategory!.length > 0 &&
                      model.maxillarySubCategory != ' ',
                  builder: (context) => Text('${model?.maxillarySubCategory}',style: TextStyle(
                    color: HexColor('#06A4FF'),
                    fontSize: 15,
                  ),),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.maxillaryModification!.length > 0 &&
                      model.maxillaryModification != 'Un Modified' &&
                      model.maxillaryModification != ' ',
                  builder: (context) =>
                      Text('modification :${model?.maxillaryModification}',style: TextStyle(
                        color: HexColor('#06A4FF'),
                        fontSize: 15,
                      ),),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model!.mandibularCategory! ==
                          'Full Mouth Rehabilitation' ||
                      model!.mandibularCategory! == 'Maxillofacial Case',
                  fallback: (context) => Text('${model?.mandibularCategory}',style: TextStyle(
                    color: HexColor('#06A4FF'),
                    fontSize: 15,
                  ),),
                  builder: (context) => SizedBox()),

              ConditionalBuilder(
                  condition: model.mandibularSubCategory!.length > 0 &&
                      model.mandibularSubCategory != ' ',
                  builder: (context) => Text('${model?.mandibularSubCategory}',style: TextStyle(
                    color: HexColor('#06A4FF'),
                    fontSize: 15,
                  ),),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.mandibularModification!.length > 0 &&
                      model.mandibularModification != 'Un Modified' &&
                      model.mandibularModification != ' ',
                  builder: (context) =>
                      Text('modification :${model?.mandibularModification}',style: TextStyle(
                        color: HexColor('#06A4FF'),
                        fontSize: 15,
                      ),),
                  fallback: (context) => SizedBox()),
              rowItmes(
                text1: 'Current medications: ',
                text2: '${model!.currentMedications}',
                maxline: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 7,
              ),
              rowItmes(
                text1: 'Level: ',
                text2: '${model!.level}',
                maxline: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 7,
              ),
              ConditionalBuilder(
                  condition: model.others!.length > 0,
                  builder: (context) => rowItmes(
                        text1: 'Other notes : ',
                        text2: '${model!.others}',
                        maxline: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  fallback: (context) => SizedBox()),
              SizedBox(
                height: 7,
              ),
              if (model.images.length != 0)
                ConditionalBuilder(
                  condition: model.images.length == 1,
                  builder: (context) => Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                    ),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: getcount(model.images.length),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(model.images[index]),
                              ),
                            ),
                          );
                        }),
                  ),
                  fallback: (context) => Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                    ),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: getcount(model.images.length),
                        itemBuilder: (context, index) {
                          if (model.images.length > 4) {
                            if (index < 3) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(model.images[index]),
                                  ),
                                ),
                              );
                            }
                            if (index == 3) {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(model.images[3],
                                      fit: BoxFit.contain),
                                  Positioned.fill(
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: Colors.black54,
                                      child: Text(
                                        '+${(model.images.length) - 4}',
                                        style: TextStyle(
                                            fontSize: 32, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          } else if (model.images.length <= 4) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(model.images[index]),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                ),
              // Container(
              //   height: 300,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(
              //       4.0,
              //     ),
              //   ),
              //   child: GridView.builder(
              //     physics: NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       crossAxisSpacing: 5,
              //       mainAxisSpacing: 5,
              //     ),
              //     itemCount: getcount(model.images.length),
              //     itemBuilder: (context, index) {
              //       if (model.images.length > 4) {
              //         if (index < 3) {
              //           return CachedNetworkImage(
              //             imageUrl: model.images[index],
              //             progressIndicatorBuilder:
              //                 (context, url, downloadProgress) => Center(
              //                     child: CircularProgressIndicator(
              //                         value: downloadProgress.progress)),
              //             errorWidget: (context, url, error) =>
              //                 Icon(Icons.error),
              //           );
              //         }
              //         if (index == 3) {
              //           return Stack(
              //             fit: StackFit.expand,
              //             children: [
              //               CachedNetworkImage(
              //                 imageUrl: model.images[index],
              //                 progressIndicatorBuilder:
              //                     (context, url, downloadProgress) => Center(
              //                         child: CircularProgressIndicator(
              //                             value: downloadProgress.progress)),
              //                 errorWidget: (context, url, error) =>
              //                     Icon(Icons.error),
              //               ),
              //               //  Image.network(
              //               //  model.images[index],
              //               //  fit: BoxFit.cover,
              //               // ),
              //               Positioned.fill(
              //                 child: Container(
              //                   alignment: Alignment.center,
              //                   color: Colors.black54,
              //                   child: Text(
              //                     '+${(model.images.length) - 4}',
              //                     style: TextStyle(
              //                         fontSize: 32, color: Colors.white),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           );
              //         }
              //       } else {
              //         return CachedNetworkImage(
              //           imageUrl: model.images[index],
              //           progressIndicatorBuilder:
              //               (context, url, downloadProgress) =>
              //                   CircularProgressIndicator(
              //                       value: downloadProgress.progress),
              //           errorWidget: (context, url, error) => Icon(Icons.error),
              //         );
              //         // return Container(
              //         //   child:  Image.network(
              //         //     model.images[index],
              //         //     fit: BoxFit.cover,
              //         //   ),
              //         // );
              //       }
              //     },
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              // defaultbutton(
              //   onpress: () async {
              //     await supervisorLayoutcubit
              //         .supervisorGetCase(model.caseId as String);
              //     navigateto(context, editCaseScreen());
              //     /*  showtoast(
              //     text: ' Reported successfully',
              //     state: toaststates. ERROR);*/
              //   },
              //   text: 'Report Wrong Diagnosis',
              //   radius: 30,
              // ),
            ],
          ),
        ),
      ),
    );

Widget doctorBuildPostWithUpdate(
  caseModel model,
  context,
  Widget w,
  doctorLayoutcubit doctorLayoutcubit,
) =>
    InkWell(
      onTap: () async {
        // await doctorLayoutcubit.doctorGetCase(model.caseId as String);
        navigateto(context, w);
      },
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
        elevation: 0.0,
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ConditionalBuilder(
                    condition: model?.image != null,
                    builder: (context) => Stack(
                      children: [
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage: NetworkImage(
                            '${model?.image}',
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
                          ' ${model.name}',
                          style: TextStyle(
                              height: 1.4,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF004E7F)),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          ' ${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  height: 1.4,
                                  color: Color(0xFF004E7F),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          title: Text(
                            'Delete Case',
                            style: TextStyle(fontSize: 15),
                          ),
                          content: Text(
                              'Are you sure you want to permanently delete this Case ?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // doctorLayoutcubit.deleteCase(model.caseId);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(IconBroken.Delete),
                    color: cc.defcol,
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
                  color: Colors.grey[300],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Medical history:',
                style: TextStyle(
                  color: HexColor('#004E7F'),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ConditionalBuilder(
                  condition: model.isDiabetes as bool,
                  builder: (context) => Text(
                        'diabetes',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF06A4FF),
                        ),
                      ),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.isCardiac as bool,
                  builder: (context) => Text(
                        'cardiac problems',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF06A4FF),
                        ),
                      ),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.isHypertension as bool,
                  builder: (context) => Text(
                        'hypertension',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF06A4FF),
                        ),
                      ),
                  fallback: (context) => SizedBox()),
              SizedBox(
                height: 5,
              ),
              ConditionalBuilder(
                  condition: model.isAllergies as bool,
                  builder: (context) => rowItmes(
                        text1: 'List of allergies:   ',
                        text2: '${model.allergies}',
                        maxline: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  fallback: (context) => SizedBox()),
              SizedBox(
                height: 5,
              ),
              Text(
                'Diagnosis :',
                style: TextStyle(
                  color: HexColor('#004E7F'),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ConditionalBuilder(
                  condition: model!.maxillaryCategory!.length! > 0,
                  builder: (context) => Text(
                        '${model?.maxillaryCategory}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF06A4FF),
                        ),
                      ),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.maxillarySubCategory!.length > 0 &&
                      model.maxillarySubCategory != ' ',
                  builder: (context) => Text(
                        '${model?.maxillarySubCategory}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF06A4FF),
                        ),
                      ),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.maxillaryModification!.length > 0 &&
                      model.maxillaryModification != 'Un Modified' &&
                      model.maxillaryModification != ' ',
                  builder: (context) => Text(
                        'modification :${model?.maxillaryModification}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF06A4FF),
                        ),
                      ),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model!.mandibularCategory! ==
                          'Full Mouth Rehabilitation' ||
                      model!.mandibularCategory! == 'Maxillofacial Case',
                  fallback: (context) => Text(
                        '${model?.mandibularCategory}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF06A4FF),
                        ),
                      ),
                  builder: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.mandibularSubCategory!.length > 0 &&
                      model.mandibularSubCategory != ' ',
                  builder: (context) => Text(
                        '${model?.mandibularSubCategory}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF06A4FF),
                        ),
                      ),
                  fallback: (context) => SizedBox()),
              ConditionalBuilder(
                  condition: model.mandibularModification!.length > 0 &&
                      model.mandibularModification != 'Un Modified' &&
                      model.mandibularModification != ' ',
                  builder: (context) => Text(
                        'modification :${model?.mandibularModification}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF06A4FF),
                        ),
                      ),
                  fallback: (context) => SizedBox()),
              rowItmes(
                text1: 'Current medications: ',
                text2: '${model.currentMedications}',
                maxline: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 7,
              ),
              ConditionalBuilder(
                  condition: model.others!.length > 0,
                  builder: (context) => rowItmes(
                        text1: 'Other notes : ',
                        text2: '${model.others}',
                        maxline: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  fallback: (context) => SizedBox()),
              SizedBox(
                height: 7,
              ),
              if (model.images.length != 0)
                ConditionalBuilder(
                  condition: model.images.length == 1,
                  builder: (context) => Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                    ),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: getcount(model.images.length),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(model.images[index]),
                              ),
                            ),
                          );
                        }),
                  ),
                  fallback: (context) => Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                    ),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: getcount(model.images.length),
                        itemBuilder: (context, index) {
                          if (model.images.length > 4) {
                            if (index < 3) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(model.images[index]),
                                  ),
                                ),
                              );
                            }
                            if (index == 3) {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(model.images[3],
                                      fit: BoxFit.contain),
                                  Positioned.fill(
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: Colors.black54,
                                      child: Text(
                                        '+${(model.images.length) - 4}',
                                        style: TextStyle(
                                            fontSize: 32, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          } else if (model.images.length <= 4) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(model.images[index]),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              defaultbutton(
                onpress: () async {
                  // await doctorLayoutcubit.doctorGetCase(model.caseId as String);
                  // navigateto(context, doctorEditCaseScreen());
                },
                text: 'Update ',
                radius: 30,
              ),
            ],
          ),
        ),
      ),
    );
