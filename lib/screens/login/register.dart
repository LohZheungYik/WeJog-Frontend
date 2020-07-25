import 'package:flutter/material.dart';
import 'package:wejog1/model/user.dart';
import 'package:wejog1/screens/home/app_bar.dart';
import 'package:wejog1/screens/login/login.dart';
import 'package:wejog1/screens/login/provider.dart';
import 'package:wejog1/services/user_data_service.dart';
import 'package:wejog1/widgets/registration_widgets.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  
  final formKey = GlobalKey<FormState>();
  
  var nameController = new TextEditingController();
  var nationalityController = new TextEditingController();
  var locationController = new TextEditingController();
  var birthYearController = new TextEditingController();
  var weightController = new TextEditingController();
  var heightController = new TextEditingController();
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();
  var cpasswordController = new TextEditingController();
  

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
                  ctrl: nameController,
                ),
                SizedBox(height: 10,),
                RegistrationField(
                  hint: "Location",
                  keyboardType: TextInputType.text,
                  isPassword: false,
                  ctrl: locationController,
                ),
                SizedBox(height: 10,),
                RegistrationField(
                  hint: "Nationality",
                  keyboardType: TextInputType.text,
                  isPassword: false,
                  ctrl: nationalityController,
                ),
                SizedBox(height: 10,),
                RegistrationField(
                  hint: "Year of Birth",
                  keyboardType: TextInputType.number,
                  isPassword: false,
                  ctrl: birthYearController,
                ),
                SizedBox(height: 10,),
                RegistrationField(
                  hint: "Weight (kg)",
                  keyboardType: TextInputType.number,
                  isPassword: false,
                  ctrl: weightController,
                ),
                SizedBox(height: 10,),
                RegistrationField(
                  hint: "Height (cm)",
                  keyboardType: TextInputType.number,
                  isPassword: false,
                  ctrl: heightController,
                ),
                SizedBox(height: 10,),
                RegistrationField(
                  hint: "E-mail address",
                  keyboardType: TextInputType.text,
                  isPassword: false,
                  ctrl: emailController,
                ),
                SizedBox(height: 10,),
                RegistrationField(
                  hint: "Password",
                  keyboardType: TextInputType.text,
                  isPassword: true,
                  ctrl: passwordController,
                ),
                SizedBox(height: 10,),
                RegistrationField(
                  hint: "Confirm password",
                  keyboardType: TextInputType.text,
                  isPassword: true,
                  ctrl: cpasswordController,
                ),
                SizedBox(height: 20,),
                MaterialButton(
                  child: Text("Register"),
                  onPressed: (){
                    if((nameController.text == "" ||
                    locationController.text == "" ||
                    nationalityController.text == "" ||
                    emailController.text == "" ||
                    birthYearController.text == "" ||
                    heightController.text == "" ||
                    weightController.text == "")
                    ){

                    final scaffold = Scaffold.of(context);
                      scaffold.showSnackBar(SnackBar(
                      content: Text("Some inputs are missing"),
                    ));


                    }else if(passwordController.text != cpasswordController.text){
                      final scaffold = Scaffold.of(context);
                      scaffold.showSnackBar(SnackBar(
                      content: Text("The entered passwords are not match. Please confirm again"),
                    ));
                    }else{
                    try{
                    User user = new User(
                        fullName: nameController.text,
                        location: locationController.text,
                        nationality: nationalityController.text,
                        email: emailController.text,
                        birthYear: int.parse(birthYearController.text),
                        height: int.parse(heightController.text),
                        weight: int.parse(weightController.text),
                        stepGoal: 10000,
                        distanceGoal: 700,
                        calorieGoal: 100,
                      );
                    
                      submitRegistration(user, passwordController.text, context);
                    }catch(e){
                      final scaffold = Scaffold.of(context);
                      scaffold.showSnackBar(SnackBar(
                      content: Text("Some inputs are missing"),
                    ));
                    }
                    }
                  },
                  color: Colors.amber,

                ),
                //RegisterButton(func: submit),
              ],
            ),
          ),
        ),
      );
    },
        ),
      );
  }


  void submitRegistration(User user, String password, BuildContext c) async{
    try{
      final auth = Provider.of(context).auth;
      final dataService = UserDataService();
      String userId = await auth.createUserWithEmailAndPassword(
        user.email, password
      );
      user.userId = userId;
      await dataService.createUser(user: user);

      print(userId + "registered");
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Login()),
      );
    }catch(e){
      //print(e);
      final scaffold = Scaffold.of(c);
      scaffold.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

}