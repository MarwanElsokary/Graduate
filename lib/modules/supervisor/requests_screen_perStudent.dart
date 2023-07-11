
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/modules/supervisor/post_screen.dart';
import '../../layout/supervisor/supervisorcubit/cubit.dart';
import '../../layout/supervisor/supervisorcubit/states.dart';
import '../../models/request.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class requestScreenPerStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

        BlocConsumer<supervisorLayoutcubit, supervisorLayoutstates>(
        listener: (context, state) {
        },
        builder: (context, state)
        {
         var cubit = supervisorLayoutcubit.get(context).requestsPerStudent;
         return ConditionalBuilder(
                  condition: cubit.length >0,
                  builder:(context) => Scaffold(
                    appBar: defaultAppBar(
                      context:  context,
                      title:  'Requests List',
                    ),

                    body: ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildRequestItem(cubit[index],context),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 8.0,
                      ),
                      itemCount:cubit.length,
                    ),
                  ) ,
                  fallback:  (context) => Scaffold(
                    appBar: defaultAppBar(
                      context:  context,
                      title:  'Requests List',
                    ),
                    body: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('images/nodataavailable.gif'),
                            //  width: 250,
                            //    height: 250,
                          ),
                          Text(
                            'Sorry We Can\'t Find Any Data ',
                            style: TextStyle(
                              fontSize: 20,
                              color: defaultcol,
                              fontWeight: FontWeight.bold,
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
  Widget buildRequestItem(requestModel model, context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5.0,
            margin: EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      ConditionalBuilder(
                        condition: model.studentimage != null,
                        builder: (context) => Stack(
                          children: [
                            CircleAvatar(
                              radius: 35.0,
                              backgroundImage: NetworkImage(
                                '${model.studentimage}',
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
                        width: 10.0,
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${model.studentname}' ,
                                style: TextStyle(
                                  height: 1.4,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Request  contact  information  of ',
                              ),
                              Align(
                                heightFactor: .5,
                                child: Row(
                                  children: [
                                    Text('the case..'),
                                    defaultTextButton(
                                      onpress: () async {
                                    await    supervisorLayoutcubit
                                            .get(context)
                                            .supervisorGetCase(
                                            model.caseid as String);
                                        navigateto(context, superPostScreen());
                                      },
                                      text: 'View the case',
                                      size: 12,
                                      textalign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: defaultbutton(
                                      onpress: () {
                                        supervisorLayoutcubit
                                            .get(context)
                                            .updateRequest(
                                          requeststatus: 'accept',
                                          supervisorid:
                                          model.supervisorid! as String,
                                          studentid:
                                          model.studentid as String,
                                          requestid:
                                          model.requestid as String,
                                          studentimage:
                                          model.studentimage != null
                                              ? model.studentimage
                                          as String
                                              : '',
                                          studentname:
                                          model.studentname as String,
                                          doctorname:
                                          model.doctorname as String,
                                          doctorimage: model.doctorimage !=
                                              null
                                              ? model.doctorimage as String
                                              : '',
                                          caseid: model.caseid as String,
                                          patientAge: model.patientAge
                                          as String,
                                          patientName: model
                                              .patientName as String,
                                          patientPhone: model
                                              .patientPhone as String,
                                          gender:
                                          model.gender as String,

                                          currentMedications: model
                                              .currentMedications as String,
                                          dateTime:
                                          model.dateTime as String,
                                          level: model.level as String,
                                          patientAddress: model
                                              .patientAddress as String,
                                          others:
                                          model.others as String,
                                          images: model.images  ,

                                          allergies: model.allergies
                                          as String,
                                          isHypertension:
                                          model.isHypertension,
                                          isAllergies:
                                          model.isAllergies,
                                          isCardiac: model.isCardiac,
                                          isDiabetes: model.isDiabetes,
                                          maxillarySubCategory:model.maxillaryCategory as String,
                                          maxillaryModification: model.maxillaryModification as String,
                                          maxillaryCategory: model.maxillaryCategory as String,
                                          mandibularSubCategory: model.mandibularSubCategory as String,
                                          mandibularModification: model.mandibularModification as String,
                                          mandibularCategory: model.mandibularCategory as String,
                                          doctorid: model.doctorid as String,
                                        );
                                        supervisorLayoutcubit
                                            .get(context)
                                            .updateCase(
                                          uId: model.doctorid as String,
                                          name: model.doctorname as String,
                                          image: model.doctorimage != null
                                              ? model.doctorimage as String
                                              : '',
                                          caseId:
                                          model.caseid as String,
                                          patientAge: model.patientAge
                                          as String,
                                          patientName: model
                                              .patientName as String,
                                          patientPhone: model
                                              .patientPhone as String,
                                          gender:
                                          model.gender as String,
                                          caseState: 'COMPLETE',
                                          currentMedications: model
                                              .currentMedications as String,
                                          dateTime:
                                          model.dateTime as String,
                                          level: model.level as String,
                                          patientAddress: model
                                              .patientAddress as String,
                                          others:
                                          model.others as String,
                                          images: model.images as List<String>,

                                          allergies: model.allergies
                                          as String,
                                          isHypertension:
                                          model.isHypertension,
                                          isAllergies:
                                          model.isAllergies,
                                          isCardiac: model.isCardiac,
                                          isDiabetes: model.isDiabetes,
                                          maxillarySubCategory:model.maxillaryCategory as String,
                                          maxillaryModification: model.maxillaryModification as String,
                                          maxillaryCategory: model.maxillaryCategory as String,
                                          mandibularSubCategory: model.mandibularSubCategory as String,
                                          mandibularModification: model.mandibularModification as String,
                                          mandibularCategory: model.mandibularCategory as String,
                                        );
                                      },
                                      text: 'Accept',
                                      textalign: TextAlign.center,
                                      radius: 30,
                                      hight: 35,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: defaultbutton(
                                      onpress: () {
                                        supervisorLayoutcubit
                                            .get(context)
                                            .updateRequest(
                                          requeststatus: 'ignore',
                                          supervisorid:
                                          model.supervisorid! as String,
                                          studentid:
                                          model.studentid as String,
                                          requestid:
                                          model.requestid as String,
                                          studentimage:
                                          model.studentimage != null
                                              ? model.studentimage
                                          as String
                                              : '',
                                          studentname:
                                          model.studentname as String,
                                          doctorname:
                                          model.doctorname as String,
                                          doctorimage: model.doctorimage !=
                                              null
                                              ? model.doctorimage as String
                                              : '',
                                          caseid: model.caseid as String,
                                          patientAge: model.patientAge
                                          as String,
                                          patientName: model
                                              .patientName as String,
                                          patientPhone: model
                                              .patientPhone as String,
                                          gender:
                                          model.gender as String,

                                          currentMedications: model
                                              .currentMedications as String,
                                          dateTime:
                                          model.dateTime as String,
                                          level: model.level as String,
                                          patientAddress: model
                                              .patientAddress as String,
                                          others:
                                          model.others as String,
                                          images: model.images ,

                                          allergies: model.allergies
                                          as String,
                                          isHypertension:
                                          model.isHypertension,
                                          isAllergies:
                                          model.isAllergies,
                                          isCardiac: model.isCardiac,
                                          isDiabetes: model.isDiabetes,
                                          maxillarySubCategory:model.maxillaryCategory as String,
                                          maxillaryModification: model.maxillaryModification as String,
                                          maxillaryCategory: model.maxillaryCategory as String,
                                          mandibularSubCategory: model.mandibularSubCategory as String,
                                          mandibularModification: model.mandibularModification as String,
                                          mandibularCategory: model.mandibularCategory as String,
                                          doctorid: model.doctorid as String,
                                        );
                                      },
                                      text: 'Ignore',
                                      textalign: TextAlign.center,
                                      radius: 30,
                                      hight: 35,
                                    ),
                                  ),
                                ],
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
        ],
      ),
    );
  }

}
