import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/models/user_model.dart';
import 'package:project/modules/supervisor/requests_screen_perStudent.dart';
import '../../layout/supervisor/supervisorcubit/cubit.dart';
import '../../layout/supervisor/supervisorcubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class studentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<supervisorLayoutcubit, supervisorLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = supervisorLayoutcubit.get(context).supervisorStudents;
        return ConditionalBuilder(
          condition: cubit.length > 0,
          builder: (context) => Scaffold(
            backgroundColor: Color(0xFFB8F5FF),
            appBar: defaultAppBar(
              context: context,
              title: 'Students List',
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildItem(cubit[index], context),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.0,
                  ),
                  itemCount: cubit.length,
                ),
                SizedBox(
                  height: 8.0,
                ),
              ]),
            ),
          ),
          fallback: (context) => Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Students List',
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

  Widget buildItem(userModel modell, context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Card(
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
            child: Container(
              color: Colors.transparent,
              height: 116,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ConditionalBuilder(
                          condition: modell?.image != null,
                          builder: (context) => Stack(
                            children: [
                              CircleAvatar(
                                radius: 40.0,
                                backgroundImage: NetworkImage(
                                  '${modell?.image}',
                                ),
                              ),
                            ],
                          ),
                          fallback: (context) => Stack(
                            children: [
                              CircleAvatar(
                                radius: 40.0,
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
                                Center(
                                  child: Text(
                                    '${modell?.name}',
                                    style: TextStyle(
                                      height: 1.4,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(0, 78, 127, 1),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: defaultTextButton(
                                      onpress: () async {
                                        await supervisorLayoutcubit
                                            .get(context)
                                            .getRequestsPerStudent(
                                                modell!.uId as String);
                                        navigateto(
                                            context, requestScreenPerStudent());
                                      },
                                      text: 'View StudentRequests',
                                      size: 16,
                                      textalign: TextAlign.center,
                                      fontweight: FontWeight.w600),
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
        ],
      ),
    );
  }
}
