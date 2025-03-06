// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
//  import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project/layout/doctor/doctorcubit/cubit.dart';
// import 'package:project/layout/doctor/doctorcubit/states.dart';
// import 'package:project/modules/doctor/post_screen.dart';
// import 'package:project/shared/styles/colors.dart';
// import '../../shared/components/components.dart';
//
// class casesOfDoctor extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer< doctorLayoutcubit, doctorLayoutstates>(
//       listener: (context, state) {
//         if (state is doctorDeleteCasesSucessState){
//           showtoast(text: 'Case Deleted Successfully', state: toaststates.SUCCESS);
//         }
//       },
//       builder: (context, state)
//       {
//         // return ConditionalBuilder(
//         //    // condition: doctorLayoutcubit.get(context).casesperdoctor.length > 0,
//         //   builder: (context) => Scaffold(
//         //     appBar: defaultAppBar(
//         //       context: context,
//         //       title: 'Doctor Cases',
//         //     ),
//         //     body: SingleChildScrollView(
//         //       physics: BouncingScrollPhysics(),
//         //       child: Column(children: [
//         //         ListView.separated(
//         //           shrinkWrap: true,
//         //           physics: NeverScrollableScrollPhysics(),
//         //           itemBuilder: (context, index) => doctorBuildPostWithUpdate(
//         //               doctorLayoutcubit.get(context).casesperdoctor[index],
//         //             context,
//         //               doctorPostScreen(),
//         //               doctorLayoutcubit.get(context)
//         //           ),
//         //           separatorBuilder: (context, index) => SizedBox(
//         //             height: 8.0,
//         //           ),
//         //           itemCount: doctorLayoutcubit.get(context).casesperdoctor.length,
//         //         ),
//         //         SizedBox(
//         //           height: 8.0,
//         //         ),
//         //       ]),
//         //     ),
//         //   ),
//         //   fallback: (context) => Scaffold(
//         //     appBar: defaultAppBar(
//         //       context: context,
//         //       title: 'Doctor Cases',
//         //     ),
//         //
//         //     body: Container(
//         //       width: double.infinity,
//         //       padding: EdgeInsets.all(18.0),
//         //       child: Column(
//         //         crossAxisAlignment: CrossAxisAlignment.center,
//         //         mainAxisAlignment: MainAxisAlignment.center,
//         //         children: [
//         //           Image(
//         //             image: AssetImage('images/nodataavailable.gif'),
//         //             //  width: 250,
//         //             //    height: 250,
//         //           ),
//         //           Text(
//         //             'Sorry We Can\'t Find Any Data ',
//         //             style: TextStyle(
//         //               fontSize: 20,
//         //               color: defaultcol,
//         //               fontWeight: FontWeight.bold,
//         //             ),
//         //           ),
//         //         ],
//         //       ),
//         //     ),
//         //   ),
//         // );
//
//       },
//     );
//   }
//
//
// }
