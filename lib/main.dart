import 'package:bloc/bloc.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/layout/admin/admincubit/cubit.dart';
import 'package:project/modules/splashscreen.dart';
import 'package:project/shared/components/blocobserver.dart';
import 'package:project/shared/components/components.dart';
import 'package:project/shared/components/constants.dart';
import 'package:project/shared/network/local/cache_helper.dart';
import 'package:project/shared/styles/themes.dart';
import 'layout/doctor/doctorcubit/cubit.dart';
import 'layout/student/studentcubit/cubit.dart';
import 'layout/supervisor/supervisorcubit/cubit.dart';
import 'package:firebase_admin/src/auth/credential.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  admin = FirebaseAdmin.instance.initializeApp(AppOptions(
      credential: ServiceAccountCredential.fromJson({
    "type": "service_account",
    "project_id": "easy-patient-finder",
    "private_key_id": "b85f9753e4ff5131a27e7f519ab345dac6ccb0f6",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDVwe7JG+WHDv9o\nxaTpBv2NYtWOd5LQxP2WeWv+dHtoCFZXWmsuQ63ZEXFa+YwfO1VQKP/SvbjB3h9D\nV6MMdUvaPsVo0pIMVhGsXIihz1RW6638LvQa3mnrSeER2G6VdKubSt/3cyHdwh4m\nc/1710vZOnVvGWD780eQmqvpEKoTLMJNElKJggHi6pL5dpM8T3EIgh8+HXX+H+PG\n4wt17QKODGjQtQ10qS9B78MH9ZIIK1xDS55m+KS36KZdNw4OWDjHWONMjQAbnJFh\n93MlxhGXcmCbP6CSC6+HbJyzJxMJI/pJVWFSCQVWoVCiC8lktrIepFyFDP4SHPEG\nrhnyWgILAgMBAAECggEAS7oYL6wP3RCNoF8ApMNiuR+N+5pV61sWYaQjg7Jdc8Yc\nXHb+aJX2dWOuDmZA42GgQDU+KDkpRpk75x4Zd9ToKem6AwAyWGd3fGINz5FFVkPJ\nUAGMXiZ0TLRQJYPQ7Wa3Ut0sShxCH69hAgtuflyQFOWWa+UITEnsDQkWpQtPzVmU\nu04TtrR+KFnGD+1n9hxR5uOVqFPuJemMzBSvmIq6Jw/oSuzF+rrgnb74lyV6AuwE\nZoPWZmIrElUk5jDDN0+W304xumEtXbXyFFBlQq2KjcVn9bJMZJ9GUiElwgfwcrDK\npkNl4X24cxrg1XIk2EVIXQuG3nqC7yX+SkR40cB+EQKBgQDtA1Cv2Zl2viBMvHqi\n4WX7CkXapJ8IOdAi27PwAYxaIfVeeswOxw8zobc36fsHoXIrkMI+6UzPIxxVOFfk\nzYthJMHkpJWTIOILwG8SoT5wApdlYDyHbIysEDnyMGU22l3nMxf7KxvBfTYxSAde\nSjLv9z14jX6MC9QBxden1NeKOwKBgQDm4bGMUUS9hiQSijH5TXwIFmY/5HLieDIb\ngLGIp71JXMpghgFrOaV6uR3zOvoMWIKmuJwCF2F4BMnbBy6W0yh6kH1Y9xG7Po7h\n+7i1mxYFQSrQU5pl9gx4BjaQpwaR4xDAQ2LNv+cYt4PPi9KcJ4eYEw9SVsCMnMVT\nsuJJcsQacQKBgQDLHo02t1Bq0BPUT672Ch8g3rPw5iYYoZs7VHhH1rvWvsWO28Qn\nYfcoM45Wj+J/rp+usFeYHM6jsh5k9m10+6ZYcWztqxM4zPSMR7WpDKD60222Bpy5\nHpEMILfYVBtZwBi7vDDwIwidcNZRs74E06gFuShoOTLbiIN/pXLlNWYm4wKBgQC2\nkXtjOJRBxcPagTrZJ2NPxd6e4VfTKzZ8Nvyr0fBFBcHmJ7ERh+kJrT44qsc1YfwW\nN97tbG2fiTHRJ9G4ZEsa+AyWf/Cefu5fVjyOJo94Ijrnt2RdAf6EHm2hXuI8FDCX\nx/FmPzxPeDYbtTYaUsvO/itcccsapZEICWkUqVLWkQKBgGGubw5D1zxf9bPpAMrJ\n+J3FbKsfDjZi8/zQcD5tmchGo1+9TZu1AwuVgl6/m8O6J/Ry0I0ZLHd2rRZcs+mC\n4mrB6kdCLjWZxUUfOa4KRIO0XivDWImaZwbs/pR4JMqVklo25x+WJKCDCyvFLIbN\nZGw3r3Chv1x3NKWP3rp9GSeF\n-----END PRIVATE KEY-----\n",
    "client_email":
        "firebase-adminsdk-pf9ht@easy-patient-finder.iam.gserviceaccount.com",
    "client_id": "109959152849471817138",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-pf9ht%40easy-patient-finder.iam.gserviceaccount.com"
  })));
  await Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('xxxxxx');
      showtoast(
          text: ' ${message.notification!.body!.toLowerCase()}',
          state: toaststates.WARNNING);
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await cacheHelper.init();
  Bloc.observer = MyBlocObserver();
  ROLE = cacheHelper.getdata(key: 'role');
  UID = cacheHelper.getdata(key: 'uId');
  print('hereeeee2');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => adminLayoutcubit()
              ..getStudents()
              ..getDoctors()
              ..getSupervisors()),
        BlocProvider(
            create: (context) => studentLayoutcubit()
              ..getStudentData()
              ..studentGetCases()
              ..getRequestedCases()),
        BlocProvider(
            create: (context) => doctorLayoutcubit()
              ..getDoctorData()
              ..docotrGetCases()
              ..loadClassifier()),
        BlocProvider(
            create: (context) => supervisorLayoutcubit()
              ..getSupervisorData()
              ..supervisorGetCases()
              ..getAllDoctors()
              ..getRequestedCases()),
      ],
      child: MaterialApp(
        theme: lighttheme, // lightmode
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,

        home: splashScreen(
          seenOnboarding: false,
        ),
      ),
    );
  }
}
