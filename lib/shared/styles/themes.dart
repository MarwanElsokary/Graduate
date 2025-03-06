import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

/*
ThemeData darktheme=ThemeData(
  primarySwatch:cc.defcol,
  scaffoldBackgroundColor: HexColor('#054e59'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('#054e59'),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: cc.defcol,
    unselectedItemColor: Colors.white,
    elevation: 20,
  ),
  appBarTheme: AppBarTheme(
    titleSpacing:20  ,
    iconTheme: IconThemeData(
      color: Colors.white,
      size:25,
    ),
    titleTextStyle:   TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    backgroundColor:HexColor('#054e59'),
    elevation: 0.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor:HexColor('#054e59'),
      statusBarIconBrightness: Brightness.light,
    ),

  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ),
  ),
);*/
ThemeData lighttheme = ThemeData(
  primarySwatch: cc.defcol,
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: cc.defcol,
    unselectedItemColor: Colors.black,
    elevation: 20,
  ),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    iconTheme: IconThemeData(
      color: defaultcol,
      size: 25,
    ),
    titleTextStyle: TextStyle(
      color: defaultcol,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    //backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ),
  ),
);
