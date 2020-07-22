import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wejog1/model/blood_pressure.dart';
import 'package:wejog1/screens/home/app_bar.dart';
import 'package:wejog1/screens/home/tabs/blood_pressure_recorder.dart';
import 'package:wejog1/services/bp_data_service.dart';
import 'package:wejog1/widgets/loading_screen.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd");

//screen for viewing blood pressure records
class BloodPressureTracker extends StatefulWidget {
  final userId;
  BloodPressureTracker({this.userId});

  @override
  _BloodPressureTrackerState createState() => _BloodPressureTrackerState();
}

class _BloodPressureTrackerState extends State<BloodPressureTracker> {
  void addBpRecordNavFunc() async{
    BloodPressure returnBp = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => BloodPressureRecorder(userId: widget.userId)
      ));

    if(returnBp!=null){
      setState(() {
        bpList.add(returnBp);
      });
    }
  }

  BpDataService bpService = BpDataService();
  List<BloodPressure>bpList = [];
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BloodPressure>>(
      future: bpService.getAllBp(userId: widget.userId),
      builder: (context, snapshot){
        if(snapshot.hasData){
          bpList = snapshot.data;
          return Scaffold(
      appBar: WeJogAppBars.bloodPressureAppBar(context, addBpRecordNavFunc),
      body: ListView.builder(
        itemCount: bpList.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Text("Blood Pressure: "+bpList[index].sys.toString()+"/"+bpList[index].dia.toString()+" Pulse: "+bpList[index].pulse.toString()),
              subtitle: Text(bpList[index].date),
              onLongPress: () async{ //delete blood pressure record
                await bpService.deleteBp(id: bpList[index].id);
                bpList.removeAt(index);
                setState(() {                 
              });
             },            
            )
          );
        }
      ), 
    );
     }
        return LoadingScreen();
      }
    );
  }
}