import 'package:flutter/material.dart';
import 'package:wejog1/screens/home/dashboard.dart';
import 'package:wejog1/screens/home/tabs/blood_pressure_tracker.dart';
import 'package:wejog1/screens/home/tabs/calorie_tracker.dart';
import 'package:wejog1/screens/home/tabs/logout.dart';
import 'package:wejog1/screens/home/tabs/profile.dart';
import 'package:wejog1/screens/home/tabs/settings.dart';
import 'package:wejog1/screens/home/tabs/todo_screen.dart';
import 'package:wejog1/screens/splashScreen/Splash.dart';

Route<dynamic> createRoute(routeName){
switch(routeName.name){
  case '/splashScreen':
      return MaterialPageRoute(
        builder: (context) => SplashScr(
          
      ),
   );
   case '/dashboard':
      return MaterialPageRoute(
        builder: (context) => Dashboard(
          userId: routeName.arguments,
      ),
   );
   case '/profile':
      return MaterialPageRoute(
        builder: (context) => UserProfile(
          user: routeName.arguments,
      ),
   );
   case '/calorieTracker':
      return MaterialPageRoute(
        builder: (context) => CalorieTracker(
          userId: routeName.arguments,
      ),
   );
   case '/bloodPressure':
      return MaterialPageRoute(
        builder: (context) => BloodPressureTracker(
          userId: routeName.arguments,
      ),
   );
   case '/todo':
      return MaterialPageRoute(
        builder: (context) => TodoScreen(
          userId: routeName.arguments,
      ),
   );
   case '/settings':
      return MaterialPageRoute(
        builder: (context) => Settings(
          user: routeName.arguments,
      ),
   );
   case '/logout':
      return MaterialPageRoute(
        builder: (context) => Logout(
          
      ),
   );
  }

    return null;
}