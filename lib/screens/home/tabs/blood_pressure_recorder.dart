import 'package:flutter/material.dart';
import 'package:wejog1/screens/home/app_bar.dart';
import 'package:wejog1/widgets/bp_recorder_widgets.dart';

//screen for adding new blood pressure record
class BloodPressureRecorder extends StatelessWidget {
  final userId;
  BloodPressureRecorder({this.userId});
  
  @override
  Widget build(BuildContext context) {
    TextEditingController sysController = TextEditingController();
    TextEditingController diaController = TextEditingController();
    TextEditingController pulseController = TextEditingController();
    
    return WillPopScope(
          onWillPop: ()async => false,
          child: Scaffold(
        appBar: WeJogAppBars.backBtnAppBar(context, "Blood Pressure Recorder"),
        body: Container(
         padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
         child: Column(
           children: <Widget>[
             BloodPressureInputs(
               hint: "usually 3 digits",
               label: "Systolic",
               ctrl: sysController,
             ),
             SizedBox(height: 20,),
             BloodPressureInputs(
               hint: "usually 2 digits",
               label: "Diastolic",
               ctrl: diaController,
             ),
             SizedBox(height: 20,),
             BloodPressureInputs(
               hint: "enter pulse rate",
               label: "Pulse",
               ctrl: pulseController,
             ),
             SizedBox(height: 20,),
             SaveBpButton(
               sysController: sysController, 
               diaController: diaController, 
               pulseController: pulseController, 
               userId: userId
            ),
           ],
         ),
        ),
      ),
    );
  }
}

