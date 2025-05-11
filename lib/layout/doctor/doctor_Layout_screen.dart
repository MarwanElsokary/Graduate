import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'doctorcubit/cubit.dart';
import 'doctorcubit/states.dart';
Future<String?> getPredictionFromAI(File imageFile) async {
  String url = 'https://dcbe-156-211-90-124.ngrok-free.app/predict';
  String fileName = imageFile.path.split('/').last;

  FormData formData = FormData.fromMap({
    'image': await MultipartFile.fromFile(imageFile.path, filename: fileName),
  });

  try {
    Dio dio = Dio();
    Response response = await dio.post(url, data: formData);

    if (response.statusCode == 200) {
      return response.data['prediction'] ?? response.data.toString();
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('API Error: $e');
    return null;
  }
}

class doctorLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    doctorLayoutcubit.get(context).doctorsetupInteractedMessage(context);
    return BlocConsumer<doctorLayoutcubit, doctorLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = doctorLayoutcubit.get(context);
        return Scaffold(
            body: cubit.doctorbottomScreens[cubit.currentIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.88),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                // مهم علشان ياخد لون الـ Container
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset("images/home.icon.png", height: 24),
                    activeIcon: Image.asset("images/home.icon.png", height: 28),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset("images/add.png", height: 24),
                    activeIcon: Image.asset("images/add.png", height: 28),
                    label: "New Case",
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset("images/profile.icon.png", height: 24),
                    activeIcon:
                        Image.asset("images/profile.icon.png", height: 28),
                    label: "Profile",
                  ),
                ],
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changebottomdoctor(index);
                },
              ),
            ));
      },
    );
  }
}
