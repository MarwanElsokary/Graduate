// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project/layout/doctor/doctorcubit/cubit.dart';
// import 'package:project/layout/doctor/doctorcubit/states.dart';
// import 'package:project/modules/doctor/post_screen.dart';
// import 'package:project/shared/styles/colors.dart';
// import '../../shared/components/components.dart';
//
// class casesOfDoctor extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<doctorLayoutcubit, doctorLayoutstates>(
//       listener: (context, state) {
//         if (state is doctorDeleteCasesSucessState) {
//           showtoast(
//               text: 'Case Deleted Successfully', state: toaststates.SUCCESS);
//         }
//       },
//       builder: (context, state) {
//         return ConditionalBuilder(
//           condition: doctorLayoutcubit.get(context).casesperdoctor.length > 0,
//           builder: (context) => Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 "Home",
//                 style: TextStyle(
//                   fontSize: 24,
//                   color: Color(0xFF004E7F),
//                 ),
//               ),
//               backgroundColor: Color(0xFFB8F5FF),
//               automaticallyImplyLeading: false,
//             ),
//             body: SingleChildScrollView(
//               physics: BouncingScrollPhysics(),
//               child: Container(
//                 color: Color(0xFFB8F5FF),
//                 child: Column(children: [
//                   ListView.separated(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) => doctorBuildPostWithUpdate(
//                         doctorLayoutcubit.get(context).casesperdoctor[index],
//                         context,
//                         doctorPostScreen(),
//                         doctorLayoutcubit.get(context)),
//                     separatorBuilder: (context, index) => SizedBox(
//                       height: 8.0,
//                     ),
//                     itemCount:
//                         doctorLayoutcubit.get(context).casesperdoctor.length,
//                   ),
//                   SizedBox(
//                     height: 8.0,
//                   ),
//                 ]),
//               ),
//             ),
//           ),
//           fallback: (context) => Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 "Home",
//                 style: TextStyle(
//                   fontSize: 24,
//                   color: Color(0xFF004E7F),
//                 ),
//               ),
//               backgroundColor: Color(0xFFB8F5FF),
//               automaticallyImplyLeading: false,
//             ),
//             body: Container(
//               color: Color(0xFFb8f5ff),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Image.asset(
//                       'images/no_data_found1.png',
//                       width: double.infinity, // تحكمي في الحجم حسب الحاجة
//                       height: 347,
//                     ),
//                   ),
//                   SizedBox(height: 20), // مسافة بين الصورة والنص
//                   Expanded(
//                     child: Text(
//                       "Sorry We Can’t Find Any Data!",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF004E7F),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
