import 'package:flutter/material.dart';
import 'package:wejog1/router.dart';
import 'package:wejog1/screens/login/auth.dart';
import 'package:wejog1/screens/login/provider.dart';

/*main function*/
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
          auth: Auth(), //initialize firebase authentication
          child: MaterialApp(
          debugShowCheckedModeBanner: false, //hide debug banner
          initialRoute: '/splashScreen',
          onGenerateRoute: createRoute,
          //home: SplashScr(), //launch splash screen
          //home: MyHomePage(),
        ),
    );
  }
}



