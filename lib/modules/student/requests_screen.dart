import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/models/user_model.dart';
import 'package:project/modules/student/post_screen.dart';
import '../../../layout/student/studentcubit/cubit.dart';
import '../../../layout/student/studentcubit/states.dart';
import '../../models/request.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class studentRequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<studentLayoutcubit, studentLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitcase = studentLayoutcubit.get(context).requestedCasesStudent;
        var cubitsuper =
            studentLayoutcubit.get(context).RequestedCasesSupervisor;

        return ConditionalBuilder(
          condition: cubitcase.length > 0,
          builder: (context) {
            return Scaffold(
              backgroundColor: Color(0xFFB8F5FF),
              appBar: AppBar(
                title: Text(
                  'Requests',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 78, 127, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: Color(0xFFB8F5FF),
              ),
              body: ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildRequestItem(
                    cubitcase[index], cubitsuper[index], context),
                separatorBuilder: (context, index) => SizedBox(
                  height: 8.0,
                ),
                itemCount: cubitcase.length,
              ),
            );
          },
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
        );
      },
    );
  }

  Widget buildRequestItem(requestModel model, userModel supermodel, context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ConditionalBuilder(
              condition: model.requeststatus == 'accept',
              builder: (context) => Card(
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
                        children: [
                          Row(
                            children: [
                              ConditionalBuilder(
                                condition: supermodel.image != null,
                                builder: (context) => Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 25.0,
                                      backgroundImage: NetworkImage(
                                        '${supermodel.image}',
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
                                width: 10.0,
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: Text(
                                          '${supermodel.name}',
                                          style: TextStyle(
                                              height: 1.4,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF004E7F)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: Text(
                                          'Accepted your request ',
                                          style: TextStyle(
                                              color: Colors.green[600],
                                              fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Patient Phone : ${model.patientPhone} ',
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: defaultTextButton(
                              onpress: () async {
                                await studentLayoutcubit
                                    .get(context)
                                    .studentGetCase(model.caseid as String);
                                navigateto(context, studentPostScreen());
                              },
                              text: 'View the case',
                              textalign: TextAlign.end,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              fallback: (context) => Card(
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
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              ConditionalBuilder(
                                condition: supermodel.image != null,
                                builder: (context) => Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 25.0,
                                      backgroundImage: NetworkImage(
                                        '${supermodel.image}',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: Text(
                                          '${supermodel.name}',
                                          style: TextStyle(
                                              height: 1.4,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF004E7F)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          'Rejected your request ',
                                          style: TextStyle(
                                              color: Colors.red[600],
                                              fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: defaultTextButton(
                                          onpress: () async {
                                            await studentLayoutcubit
                                                .get(context)
                                                .studentGetCase(
                                                    model.caseid as String);
                                            navigateto(
                                                context, studentPostScreen());
                                          },
                                          text: 'View the case',
                                          textalign: TextAlign.center,
                                          size: 12,
                                        ),
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
                  )),
        ],
      ),
    );
  }
}
