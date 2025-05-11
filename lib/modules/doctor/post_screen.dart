import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project/layout/doctor/doctorcubit/cubit.dart';
import 'package:project/layout/doctor/doctorcubit/states.dart';
import '../../shared/components/components.dart';

class doctorPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<doctorLayoutcubit, doctorLayoutstates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = doctorLayoutcubit.get(context).doctorClickcase;

          return ConditionalBuilder(
            condition: doctorLayoutcubit.get(context).doctorClickcase != null,
            builder: (context) => Scaffold(
              appBar: defaultAppBar(
                context: context,
                title: 'Case',
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
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
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
                                    'DR. ${model?.name}',
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
                                    '${model?.dateTime}',
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
                                    text2: '${model?.patientName}'),
                                SizedBox(
                                  height: 7,
                                ),
                                rowItmes(
                                  text1: 'Patient age : ',
                                  text2: '${model?.patientAge}',
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                rowItmes(
                                  text1: 'Patient gender : ',
                                  text2: '${model?.gender}',
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                rowItmes(
                                  text1: 'Current medications : ',
                                  text2: '${model?.currentMedications}',
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  'Medical history :',
                                  style: TextStyle(
                                    color: Color(0xFF004E7F),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                ConditionalBuilder(
                                    condition: model?.isDiabetes as bool,
                                    builder: (context) => Text('diabetes',style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF06A4FF),
                                    ),),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition: model?.isCardiac as bool,
                                    builder: (context) =>
                                        Text('cardiac problems',style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF06A4FF),
                                        ),),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition: model?.isHypertension as bool,
                                    builder: (context) => Text('hypertension',style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF06A4FF),
                                    ),),
                                    fallback: (context) => SizedBox()),
                                SizedBox(
                                  height: 5,
                                ),
                                ConditionalBuilder(
                                    condition: model?.isAllergies as bool,
                                    builder: (context) => rowItmes(
                                          text1: 'List of allergies : ',
                                          text2: '${model?.allergies}',
                                          // maxline: 2,
                                          //   overflow: TextOverflow.ellipsis,
                                        ),
                                    fallback: (context) => SizedBox()),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  'Diagnosis :',
                                  style: TextStyle(
                                    color: Color(0xFF004E7F),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                ConditionalBuilder(
                                    condition:
                                        model!.maxillaryCategory!.length > 0,
                                    builder: (context) =>
                                        Text('${model.maxillaryCategory}',style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF06A4FF),
                                        ),),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition:
                                        model.maxillarySubCategory!.length >
                                                0 &&
                                            model.maxillarySubCategory != ' ',
                                    builder: (context) =>
                                        Text('${model.maxillarySubCategory}',style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF06A4FF),
                                        ),),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition:
                                        model.maxillaryModification!.length >
                                                0 &&
                                            model.maxillaryModification !=
                                                'Un Modified' &&
                                            model.maxillaryModification != ' ',
                                    builder: (context) => Text(
                                        'modification :${model.maxillaryModification}',style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF06A4FF),
                                    ),),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition: model.mandibularCategory! ==
                                            'Full Mouth Rehabilitation' ||
                                        model.mandibularCategory! ==
                                            'Maxillofacial Case',
                                    fallback: (context) =>
                                        Text('${model.mandibularCategory}',style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF06A4FF),
                                        ),),
                                    builder: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition:
                                        model.mandibularSubCategory!.length >
                                                0 &&
                                            model.mandibularSubCategory != ' ',
                                    builder: (context) =>
                                        Text('${model.mandibularSubCategory}',style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF06A4FF),
                                        ),),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition:
                                        model.mandibularModification!.length >
                                                0 &&
                                            model.mandibularModification !=
                                                'Un Modified' &&
                                            model.mandibularModification != ' ',
                                    builder: (context) => Text(
                                        'modification :${model.mandibularModification}',style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF06A4FF),
                                    ),),
                                    fallback: (context) => SizedBox()),
                                rowItmes(
                                  text1: 'Level : ',
                                  text2: '${model.level}',
                                ),
                                ConditionalBuilder(
                                    condition: model.others!.length > 0,
                                    builder: (context) =>
                                        Text('Other notes :${model.others}'),
                                    fallback: (context) => SizedBox()),
                                SizedBox(
                                  height: 7,
                                ),
                                if (model.images.length != 0)
                                  Container(
                                    height: 350,
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
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fitWidth,
                                              image: NetworkImage(
                                                  model.images[index]),
                                            ),
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }
}
