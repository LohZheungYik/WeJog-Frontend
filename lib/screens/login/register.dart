import 'package:flutter/material.dart';
import 'package:wejog1/screens/home/app_bar.dart';
import 'package:wejog1/widgets/registrationWidget.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WeJogAppBars.backBtnAppBar(context, "Register an account"),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            color: Colors.green,
            width: double.infinity,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    RegistrationField(
                      hint: "Name",
                      keyboardType: TextInputType.text,
                      isPassword: false,
                    ),
                    SizedBox(height: 10,),
                    RegistrationField(
                      hint: "Race",
                      keyboardType: TextInputType.text,
                      isPassword: false,
                    ),
                    SizedBox(height: 10,),
                    RegistrationField(
                      hint: "Nationality",
                      keyboardType: TextInputType.text,
                      isPassword: false,
                    ),
                    SizedBox(height: 10,),
                    RegistrationField(
                      hint: "Weight (kg)",
                      keyboardType: TextInputType.number,
                      isPassword: false,
                    ),
                    SizedBox(height: 10,),
                    RegistrationField(
                      hint: "Height (cm)",
                      keyboardType: TextInputType.number,
                      isPassword: false,
                    ),
                    SizedBox(height: 10,),
                    RegistrationField(
                      hint: "E-mail address",
                      keyboardType: TextInputType.text,
                      isPassword: false,
                    ),
                    SizedBox(height: 10,),
                    RegistrationField(
                      hint: "Password",
                      keyboardType: TextInputType.text,
                      isPassword: true,
                    ),
                    SizedBox(height: 10,),
                    RegistrationField(
                      hint: "Confirm password",
                      keyboardType: TextInputType.text,
                      isPassword: true,
                    ),
                    SizedBox(height: 20,),
                    RegisterButton(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}