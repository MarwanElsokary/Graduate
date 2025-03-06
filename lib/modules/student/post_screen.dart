import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project/layout/student/studentcubit/cubit.dart';
import 'package:project/layout/student/studentcubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class studentPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<studentLayoutcubit, studentLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: studentLayoutcubit.get(context).studentClickcase != null,
            fallback: (context) => Center(child: CircularProgressIndicator()),
            builder: (context) {
              var model = studentLayoutcubit.get(context).studentClickcase;
              return Scaffold(
                appBar: defaultAppBar(
                  context: context,
                  title: 'Case',
                ),
                body: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ConditionalBuilder(
                              condition:  model?.image !=null  ,
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
                                    backgroundImage: AssetImage('images/profileimage.jpg'),
                                  ),

                                ],
                              ), ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${model!.name}',
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
                                    '${model.dateTime}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          height: 1.4,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                rowItmes(
                                  text1: 'Patient name : ',
                                  text2: '${model.patientName}',
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                rowItmes(
                                  text1: 'Patient age : ',
                                  text2: '${model.patientAge}',
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                rowItmes(
                                  text1: 'Patient gender : ',
                                  text2: '${model.gender}',
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                rowItmes(
                                  text1: 'Current medications : ',
                                  text2: '${model.currentMedications}',
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  'Medical history :',
                                  style: TextStyle(
                                      color: HexColor('#5394AD'), fontSize: 15),
                                ),
                                ConditionalBuilder(
                                    condition: model.isDiabetes as bool,
                                    builder: (context) => Text('diabetes'),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition: model.isCardiac as bool,
                                    builder: (context) =>
                                        Text('cardiac problems'),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition: model.isHypertension as bool,
                                    builder: (context) => Text('hypertension'),
                                    fallback: (context) => SizedBox()),
                                SizedBox(
                                  height: 5,
                                ),
                                ConditionalBuilder(
                                    condition: model.allergies!.length > 0,
                                    builder: (context) => rowItmes(
                                          text1: 'List of allergies : ',
                                          text2: '${model.allergies}',
                                        ),
                                    fallback: (context) => SizedBox()),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  'Diagnosis :',
                                  style: TextStyle(
                                      color: HexColor('#5394AD'), fontSize: 15),
                                ),
                                ConditionalBuilder(
                                    condition: model.maxillaryCategory!.length>0,
                                    builder: (context) => Text( '${model.maxillaryCategory}' ),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition: model.maxillarySubCategory!.length>0   && model.maxillarySubCategory !=' ',
                                    builder: (context) => Text( '${model.maxillarySubCategory}' ),
                                    fallback: (context) =>SizedBox()  ),
                                ConditionalBuilder(
                                    condition: model.maxillaryModification!.length>0 && model.maxillaryModification != 'Un Modified' && model.maxillaryModification !=' ' ,
                                    builder: (context) => Text( 'modification :${model.maxillaryModification}' ),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition:  model.mandibularCategory! =='Full Mouth Rehabilitation' || model.mandibularCategory! =='Maxillofacial Case',
                                    fallback: (context) => Text( '${model.mandibularCategory}' ),
                                    builder: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition: model.mandibularSubCategory!.length>0  && model.mandibularSubCategory !=' ' ,
                                    builder: (context) => Text( '${model.mandibularSubCategory}' ),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition: model.mandibularModification!.length>0 && model.mandibularModification !='Un Modified' && model.mandibularModification !=' ',
                                    builder: (context) => Text('modification :${model.mandibularModification}' ),
                                    fallback: (context) => SizedBox()),
                                SizedBox(
                                  height: 7,
                                ),
                                ConditionalBuilder(
                                    condition: model.others!.length > 0,
                                    builder: (context) => rowItmes(
                                          text1: 'Other notes : ',
                                          text2: '${model.others}',
                                        ),
                                    fallback: (context) => SizedBox()),
                                if(model.images.length!=0)
                                Container(
                                  height: 320,
                                  decoration: BoxDecoration(),
                                  child: GridView.builder(
                                    physics: PageScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemCount: model.images.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: double.infinity,
                                        height: 250,
                                        child:  Image.network(
                                          model.images[index],
                                          fit: BoxFit.fitWidth,
                                          loadingBuilder: (BuildContext context, Widget child,
                                              ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null
                                                    ? loadingProgress.cumulativeBytesLoaded /
                                                    loadingProgress.expectedTotalBytes!
                                                    : null,
                                              ),
                                            );},
                                          errorBuilder: (context, exception, stackTrace) {
                                      return Icon(Icons.error);
                                      },

                                      ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      if(model.caseState == 'WAITING'&& !model.studentRequests!.contains(UID) )
                        defaultbutton(
                          onpress: () {
                            studentLayoutcubit.get(context).getStudentData();
                            var m = studentLayoutcubit.get(context).studentmodel;
                            if(m!.supervisorId ==null)
                            showtoast(text: 'currently you don\'t have a supervisor please select one to request contact information', state:toaststates.ERROR);
    else {
                            studentLayoutcubit.get(context).createRequest(
                              status: 'pending',
                              supervisorid: m.supervisorId!,
                              studentid: UID,
                              studentname: m.name!,
                              studentimage:m.image != null ? m.image as String : null,
                              requestid: '',
                              doctorid: model.uId as String,
                              doctorname: model.name as String,
                              doctorimage: model.image != null ? model.image as String : null,
                              caseid: model.caseId as String,
                              patientAge: model.patientAge as String,
                              patientName: model.patientName as String,
                              patientPhone: model.patientPhone as String,
                              gender: model.gender as String,
                              currentMedications: model.currentMedications as String,
                              dateTime: model.dateTime as String,
                              level: model.level as String,
                              patientAddress: model.patientAddress as String,
                              others: model.others as String,
                              images: model.images,
                              allergies: model.allergies as String,
                              isHypertension: model.isHypertension,
                              isAllergies: model.isAllergies,
                              isCardiac: model.isCardiac,
                              isDiabetes: model.isDiabetes,
                              mandibularCategory: model.mandibularCategory as String,
                              mandibularModification: model.mandibularModification.toString() == 'null'
                                  ? ' '
                                  : model.mandibularModification.toString(),
                              mandibularSubCategory:
                              model.mandibularSubCategory
                                  .toString() ==
                                  'null'
                                  ? ' '
                                  : model.mandibularSubCategory
                                  .toString(),
                              maxillaryCategory:
                              model.maxillaryCategory .toString(),
                              maxillaryModification:
                              model.maxillaryModification
                                  .toString() ==
                                  'null'
                                  ? ' '
                                  : model.maxillaryModification
                                  .toString(),
                              maxillarySubCategory:
                              model.maxillarySubCategory
                                  .toString() ==
                                  'null'
                                  ? ' '
                                  : model.maxillarySubCategory
                                  .toString(),


                            );

    }
                          },
                          text: 'Request conatct information',
                          radius: 30,

                        ),
                        if(model.caseState == 'WAITING'&& model.studentRequests!.contains(UID) )
                          defaultbutton(
                            onpress: () {
                              studentLayoutcubit.get(context).deleteRequest(model.caseId);
                            },
                            text: 'Un Request conatct information',
                            radius: 30,
                          ),

                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
