import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wejog1/model/BloodPressure.dart';
import 'package:wejog1/model/mockData.dart';
import 'package:wejog1/screens/home/app_bar.dart';
import 'package:wejog1/screens/home/tabs/bloodPressureRecorder.dart';
import 'package:wejog1/screens/home/tabs/bloodPressureStatistic.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd");

class BloodPressureTracker extends StatefulWidget {
  @override
  _BloodPressureTrackerState createState() => _BloodPressureTrackerState();
}

class _BloodPressureTrackerState extends State<BloodPressureTracker> {
  void addBpRecordNavFunc() async{
    BloodPressure returnBp = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => BloodPressureRecorder()
      ));

    if(returnBp!=null){
      setState(() {
        mockBpRecords.add(returnBp);
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WeJogAppBars.bloodPressureAppBar(context, addBpRecordNavFunc),
      body: ListView.builder(
        itemCount: mockBpRecords.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Text("Blood Pressure: "+mockBpRecords[index].sys.toString()+"/"+mockBpRecords[index].dia.toString()+" Pulse: "+mockBpRecords[index].pulse.toString()),
              subtitle: Text(dateFormat.format(mockBpRecords[index].date)),
              onLongPress: (){
                mockBpRecords.removeAt(index);
                setState(() {                 
              });
             },            
            )
          );
        }
      ), 
    );
  }
}