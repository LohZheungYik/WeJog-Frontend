import 'package:flutter/material.dart';
import 'package:wejog1/widgets/input_box.dart';

/*user info title*/
class ProfileTitle extends StatelessWidget {  
  final String child;
  ProfileTitle({this.child});

  @override
  Widget build(BuildContext context) {
    return Text(child, style: 
              TextStyle(
                color: Colors.white
              ),
    );
  }
}
/*user info title end*/

/*User info content*/
class ProfileInfo extends StatelessWidget {
  final String child;
  ProfileInfo({this.child});

  @override
  Widget build(BuildContext context) {
    return Text(child, 
      style: TextStyle(
              fontSize: 26,
              color: Colors.white
             ),
            );
  }
}
/*User info content end*/

/*Input box for updating profile information*/
class InputBox extends StatelessWidget {
  final title, hint, ctrl, inputType;
  InputBox({this.title, this.hint, this.ctrl, this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
      ),
      keyboardType: inputType,
      decoration: InputDeco.profileInputDeco(title, hint, Colors.green[500]),
      controller: ctrl,
    );
  }
}
/*end of Input box for updating profile information*/