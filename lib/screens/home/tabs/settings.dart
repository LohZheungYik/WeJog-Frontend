import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wejog1/model/user.dart';
import 'package:wejog1/screens/home/dashboard.dart';
import 'package:wejog1/services/user_data_service.dart';

class Settings extends StatefulWidget {
  final user;
  Settings({this.user});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  
  /*goal controllers*/
  TextEditingController stepGoalController = new TextEditingController();
  TextEditingController distanceGoalController = new TextEditingController();
  TextEditingController calorieGoalController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  
  /*end goal controllers*/

  /*goal default setting values*/
  @override
  void initState(){
    
    super.initState();
  }
  /*end of goal default values*/

  /*setting main screen*/
  @override
  Widget build(BuildContext context) {
    stepGoalController.text = widget.user.stepGoal.toString();
    distanceGoalController.text = widget.user.distanceGoal.toString();
    calorieGoalController.text = widget.user.calorieGoal.toString();

    return WillPopScope(
          onWillPop: ()async => false,
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[500],
          title: Text("Settings"),
          leading: IconButton(icon: Icon(
            Icons.arrow_back
          ), onPressed: () async{
            UserDataService u = UserDataService();
            User userData = new User();
            userData = await u.getUserDetail(userId: widget.user.userId);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dashboard(userId: widget.user.userId, userData: userData,)));
          }),
        ),
        body: Column(
          children: <Widget>[
            goalSettingList(), //goal setting list
          ],
        )
      ),
    );
  }
  /*end of setting main screen*/

  /*popup box for editing goal values*/
  Future <String> createAlertDialog(BuildContext context, TextEditingController ctrl, String instruction){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(instruction),
        content: TextField(
          keyboardType: TextInputType.number,
        controller: ctrl,
      ),
      actions: <Widget>[
        MaterialButton(
          child: Text("OK"),
          color: Colors.blue,
          onPressed: (){
            User userSetting = User(
              stepGoal: int.parse(stepGoalController.text),
              calorieGoal: int.parse(calorieGoalController.text),
              distanceGoal: int.parse(distanceGoalController.text),
              userId: widget.user.userId
            );
            
            UserDataService u = UserDataService();
            u.updateUserSetting(user: userSetting);
            
            createSavingDialog(context);
            //setState(() {});
          }
         ),
         MaterialButton(
          child: Text("Back"),
          color: Colors.blue,
          onPressed: (){
            Navigator.pop(context);
          }
         ),

       ],
     );
   });
  }//createAlertDialog
  /*end of popup box*/
  Future <String> createSavingDialog(BuildContext context){
    Timer(
      Duration(seconds: 5),
      () async{
         Navigator.of(context).pushReplacementNamed('/settings',
          arguments: widget.user
         );
      },
    );
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content: SizedBox(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              CircularProgressIndicator(),
              Text("Saving Changes... Please Wait")
            ]
          ),
        ),
      );

    });
  }

  /*goal setting list*/
  Widget goalSettingList(){
    final settingItems = ["Daily steps target", "Daily distance target(m)", "Daily calories to burn(Kcal)"];
    final settingIcons = [Icons.directions_run, Icons.location_on, Icons.fastfood, Icons.timer];
    final settingControllers = [stepGoalController, distanceGoalController, calorieGoalController, timeController];
    final settingInstructions = ["Type below to set your goal for daily step count", "Type below to set your goal for daily distance target(KM)", "Type below to set your goal for daily calories to burn(Kcal)"];

    return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: settingItems.length,
              itemBuilder: (context, index) {
              return Card( 
                child: ListTile(
                onTap: (){
                  createAlertDialog(context, settingControllers[index], settingInstructions[index]);
                },
                leading: Icon(settingIcons[index]),
                title: Text(settingItems[index]),
                //trailing: Text(settingControllers[index].text.toString())
            ),
          );
        },
      )
    );
  }
  /*end of goal setting list*/

}



