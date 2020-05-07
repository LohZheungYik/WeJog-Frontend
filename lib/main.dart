import 'package:flutter/material.dart';
import 'package:wejog1/screens/home/index.dart';
import 'package:wejog1/screens/home/tabs/bloodPressureTracker.dart';
import 'package:wejog1/screens/home/tabs/calorieTracker.dart';
import 'package:wejog1/screens/home/tabs/searchFood.dart';
import 'package:wejog1/screens/home/tabs/settings.dart';
import 'package:wejog1/screens/home/tabs/todo.dart';
import 'package:wejog1/screens/login/login.dart';
import 'package:wejog1/screens/login/register.dart';
import 'package:wejog1/screens/splashScreen/Splash.dart';

/*main function*/
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     //home: BloodPressureTracker(),
     home: Login(),
     //home: Index(), //launch splash screen
      //home: Register(),
      //home: Settings(),
    );
  }
}


