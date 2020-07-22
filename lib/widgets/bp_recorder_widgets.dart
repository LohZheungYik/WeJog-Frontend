import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wejog1/model/blood_pressure.dart';
import 'package:wejog1/services/bp_data_service.dart';

//input fields with custom style at blood pressure recorder screen
class BloodPressureInputs extends StatelessWidget {
  
  final TextEditingController ctrl;
  final String hint, label;
  
  BloodPressureInputs({this.ctrl, this.hint, this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: Colors.black,
              ),
              controller: ctrl,
                decoration: InputDecoration(
                 enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                ) ,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color:  Colors.black,
                    width: 2.0
                  )
                ),
                labelText: label,
                labelStyle: TextStyle(
                  color: Colors.black,    
                ),
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.black,
                )
              ),
            );
  }
}

//save button at blood pressure screen
class SaveBpButton extends StatelessWidget {
  const SaveBpButton({
    Key key,
    @required this.sysController,
    @required this.diaController,
    @required this.pulseController,
    @required this.userId,
  }) : super(key: key);

  final TextEditingController sysController;
  final TextEditingController diaController;
  final TextEditingController pulseController;
  final userId;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
     color: Colors.green,
     onPressed: () async{
       final dateFormat = new DateFormat('yyyy-MM-dd hh:mm');
       var dateTime = DateTime.now();
       String date = dateFormat.format(dateTime);
       
       BloodPressure newBp = new BloodPressure(
         sys: int.parse(sysController.text),
         dia: int.parse(diaController.text),
         pulse: int.parse(pulseController.text),
         date: date,
         userId: userId
       );

       BpDataService b = BpDataService();
       BloodPressure addedBp = await b.createBP(bp: newBp);

       Navigator.of(context).pop(addedBp);
       
     },
     child: Text("Save", style: 
       TextStyle(
         color: Colors.white,
       ),),  
    );
  }
}
