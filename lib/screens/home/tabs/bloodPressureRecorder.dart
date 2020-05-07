import 'package:flutter/material.dart';
import 'package:wejog1/screens/home/app_bar.dart';
import 'package:wejog1/widgets/bpRecorderWidgets.dart';

class BloodPressureRecorder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController sysController = TextEditingController();
    TextEditingController diaController = TextEditingController();
    TextEditingController pulseController = TextEditingController();
    
    return Scaffold(
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
             sys: sysController.text,
             dia: diaController.text,
             pulse: pulseController.text,
           ),
         ],
       ),
      ),
    );
  }
}