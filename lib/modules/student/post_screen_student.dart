import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project/layout/supervisor/supervisorcubit/cubit.dart';
import 'package:project/layout/supervisor/supervisorcubit/states.dart';
import 'package:project/modules/supervisor/update_case.dart';
import '../../shared/components/components.dart';

class PostScreenStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<supervisorLayoutcubit, supervisorLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = supervisorLayoutcubit.get(context).supervisorClickcase;

        return ConditionalBuilder(
            condition:
                supervisorLayoutcubit.get(context).supervisorClickcase != null,
            fallback: (context) => Center(child: CircularProgressIndicator()),
            builder: (context) {
              return Scaffold(
                backgroundColor: Color(0xFF6BC9FF),
                appBar: defaultAppBar(
                  context: context,
                  title: 'Case',
                ),
                body: Card(
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
                                    radius: 25.0,
                                    backgroundImage: NetworkImage(
                                      '${model?.image}',
                                    ),
                                  ),
                                ],
                              ),
                              fallback: (context) => Scaffold(
                                appBar: defaultAppBar(
                                  context: context,
                                  title: 'Doctor Cases',
                                ),
                                body: Container(
                                  color: Color(0xFFb8f5ff),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          'images/no_data_found1.png',
                                          width: double.infinity, // تحكمي في الحجم حسب الحاجة
                                          height: 347,
                                        ),
                                      ),
                                      SizedBox(height: 20), // مسافة بين الصورة والنص
                                      Expanded(
                                        child: Text(
                                          "Sorry We Can’t Find Any Data!",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF004E7F),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                    '${model!.dateTime}',
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
                                  text2: '${model!.patientName}',
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                rowItmes(
                                  text1: 'Patient age : ',
                                  text2: '${model!.patientAge}',
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                rowItmes(
                                  text1: 'Patient gender : ',
                                  text2: '${model!.gender}',
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                rowItmes(
                                  text1: 'Current medications : ',
                                  text2: '${model!.currentMedications}',
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
                                    condition: model!.isDiabetes as bool,
                                    builder: (context) => Text('diabetes'),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition: model!.isCardiac as bool,
                                    builder: (context) =>
                                        Text('cardiac problems'),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition: model!.isHypertension as bool,
                                    builder: (context) => Text('hypertension'),
                                    fallback: (context) => SizedBox()),
                                SizedBox(
                                  height: 5,
                                ),
                                ConditionalBuilder(
                                    condition: model!.isAllergies as bool,
                                    builder: (context) => rowItmes(
                                          text1: 'List of allergies : ',
                                          text2: '${model!.allergies}',
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
                                    condition:
                                        model!.maxillaryCategory!.length! > 0,
                                    builder: (context) =>
                                        Text('${model?.maxillaryCategory}'),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition:
                                        model.maxillarySubCategory!.length >
                                                0 &&
                                            model.maxillarySubCategory != ' ',
                                    builder: (context) =>
                                        Text('${model?.maxillarySubCategory}'),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition:
                                        model.maxillaryModification!.length >
                                                0 &&
                                            model.maxillaryModification !=
                                                'Un Modified' &&
                                            model.maxillaryModification != ' ',
                                    builder: (context) => Text(
                                        'modification :${model?.maxillaryModification}'),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition: model!.mandibularCategory! ==
                                            'Full Mouth Rehabilitation' ||
                                        model!.mandibularCategory! ==
                                            'Maxillofacial Case',
                                    fallback: (context) =>
                                        Text('${model?.mandibularCategory}'),
                                    builder: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition:
                                        model.mandibularSubCategory!.length >
                                                0 &&
                                            model.mandibularSubCategory != ' ',
                                    builder: (context) =>
                                        Text('${model?.mandibularSubCategory}'),
                                    fallback: (context) => SizedBox()),
                                ConditionalBuilder(
                                    condition:
                                        model.mandibularModification!.length >
                                                0 &&
                                            model.mandibularModification !=
                                                'Un Modified' &&
                                            model.mandibularModification != ' ',
                                    builder: (context) => Text(
                                        'modification :${model?.mandibularModification}'),
                                    fallback: (context) => SizedBox()),
                                rowItmes(
                                  text1: 'Level : ',
                                  text2: '${model!.level}',
                                ),
                                ConditionalBuilder(
                                    condition: model.others!.length > 0,
                                    builder: (context) => rowItmes(
                                          text1: 'Other notes : ',
                                          text2: '${model!.others}',
                                        ),
                                    fallback: (context) => SizedBox()),
                                SizedBox(
                                  height: 7,
                                ),
                                if (model.images.length != 0)
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
                                          child: Image.network(
                                            model.images[index],
                                            fit: BoxFit.fitWidth,
                                            width: double.infinity,
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
                        defaultbutton(
                          onpress: () async {
                            await supervisorLayoutcubit
                                .get(context)
                                .supervisorGetCase(model.caseId as String);
                            navigateto(context, editCaseScreen());
                            /* showtoast(
                            text: ' Reported successfully',
                            state: toaststates. ERROR);*/
                          },
                          text: 'WOWWWWWWWW',
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
