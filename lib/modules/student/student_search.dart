import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/models/case_model.dart';
import 'package:project/modules/student/post_screen.dart';

import '../../layout/student/studentcubit/cubit.dart';
import '../../layout/student/studentcubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';


class studentSearchScreen extends StatelessWidget {
  var searchcon = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<studentLayoutcubit,studentLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
       var cubit=studentLayoutcubit.get(context).search;
        return Scaffold(
          body: Container(
            color: defaultcol,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: defaultcol,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                              studentLayoutcubit.get(context). search = [];
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                IconBroken.Arrow___Left_2,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Search',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: searchcon,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                          studentLayoutcubit.get(context).Search(searchcon.text);
                          },
                          validator: (String? value) {
                            if (value!.isEmpty)
                              return 'search must not be empty';
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric( horizontal: 16.0),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search By Category ,Subcategory',
                            counterText: '',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color:defaultcol,
                              ),
                            ),
                            focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(30),
            topEnd: Radius.circular(30),
          ),
        ),
        child:  ConditionalBuilder(
          condition: cubit.length > 0,
          builder: (context) => Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildsearchitem(cubit[index], context),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 8.0,
                    ),
                    itemCount: cubit.length,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Scaffold(

            body: Container(
              width: double.infinity,
              padding: EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('images/lf20_v7tiqqzx.gif'),
                       width: 300,
                         height: 250,
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
          ),
        ),

        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
SingleChildScrollView buildsearchitem(caseModel model, context) {
  return   SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
          onTap: () async {
  await studentLayoutcubit.get( context).studentGetCase(model.caseId as String);
  navigateto(context, studentPostScreen());
          },

            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5.0,
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        child: Image(image: NetworkImage( '${model.images[0]}'),fit:BoxFit.contain ),
                      width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

}
