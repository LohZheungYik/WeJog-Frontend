import 'package:flutter/material.dart';
import 'package:wejog1/model/user.dart';
import 'package:wejog1/screens/home/dashboard.dart';
import 'package:wejog1/screens/login/provider.dart';
import 'package:wejog1/services/user_data_service.dart';
import 'package:wejog1/widgets/login_widgets.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);
  @override
    _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async => false,
          child: Scaffold(
        backgroundColor: Colors.green[500],
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/logo.png'), //logo
              SizedBox(
                height: 50
              ),
              LoginScreenInputs(ctrl: emailController, hint: "Enter your email", label: "E-mail", isPassword: false,), //email box
              SizedBox(
                height: 20
              ),
              LoginScreenInputs(ctrl: passwordController, hint: "Enter your password", label: "Password", isPassword: true,), //password box

              //LoginButton(nameCtrl: emailController, passwordCtrl: passwordController), //login button
               Builder(
                    builder: (context)=> SizedBox(
                    width: double.infinity,
                    child: RaisedButton.icon(
                    onPressed: (){
                      submitLogin(emailController.text, passwordController.text, context);
                    },
                    icon: Icon(Icons.exit_to_app), 
                    label: Text("Login"),
                    color: Colors.blue,
                    textColor: Colors.white,
                    
                  ),
                ),
              ), 
              
              RegisterButton(),
              
            ],
          ),
        )
      ),
    );
  }

    void submitLogin(String email, String password, BuildContext c) async{
    try{
      final auth = Provider.of(context).auth;
      String userId = await auth.signInWithEmailAndPassword(
        //emailController.text, passwordController.text
        email, password
        
      );
      UserDataService u = UserDataService();
      User userData = new User();
      userData = await u.getUserDetail(userId: userId);
      // final scaffold = Scaffold.of(c);
      // scaffold.showSnackBar(SnackBar(
      //   content: Text("Loading Dashboard"),
      // ));

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Dashboard(userId: userId, userData: userData)),
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



