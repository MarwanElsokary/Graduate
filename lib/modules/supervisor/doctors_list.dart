import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/models/user_model.dart';
import 'package:project/modules/supervisor/posts_perDoctor_screen.dart';
import '../../layout/supervisor/supervisorcubit/cubit.dart';
import '../../layout/supervisor/supervisorcubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class doctorsScreen extends StatelessWidget {
  const doctorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<supervisorLayoutcubit, supervisorLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = supervisorLayoutcubit.get(context).doctors;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Doctors List',
              style: TextStyle(
                color: Color.fromRGBO(0, 78, 127, 1),
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Color(0xFFB8F5FF),
          ),
          body: Container(
            color: Color(0xFFB8F5FF),
            child: ConditionalBuilder(
              condition: cubit.length > 0,
              builder: (context) => ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildItem(cubit[index], context),
                separatorBuilder: (context, index) => SizedBox(
                  height: 8.0,
                ),
                itemCount: cubit.length,
              ),
              fallback: (context) => Scaffold(
                body: Container(
                  width: double.infinity,
                  child: Container(
                    color: Color(0xFFB8F5FF),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "No doctors available",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF004E7F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                  verticalDirection: VerticalDirection.down,
                  children: [
                    Row(
                      children: [
                        ConditionalBuilder(
                          condition: modell.image != null,
                          builder: (context) => Stack(
                            children: [
                              CircleAvatar(
                                radius: 40.0,
                                backgroundImage: NetworkImage(
                                  '${modell.image}',
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
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Dr ${modell.name}',
                                  style: TextStyle(
                                    height: 1.4,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(0, 78, 127, 1),
                                  ),
                                ),
                                defaultTextButton(
                                  onpress: () {
                                    supervisorLayoutcubit
                                        .get(context)
                                        .supervisorGetCasesPerDoctor(
                                            modell!.uId as String);
                                    navigateto(context, postPerDoctorScreen());
                                  },
                                  text: 'View the cases',
                                  size: 16,
                                  textalign: TextAlign.center,
                                  fontweight: FontWeight.w600
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
