import 'package:flutter/material.dart';
import 'package:wejog1/model/BloodPressure.dart';
import 'package:wejog1/model/mockData.dart';
import 'package:wejog1/widgets/bpRecorderWidgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BloodPressureStatistic extends StatefulWidget {
  @override
  _BloodPressureStatisticState createState() => _BloodPressureStatisticState();
}

class _BloodPressureStatisticState extends State<BloodPressureStatistic> {
  List<charts.Series<BloodPressure, DateTime>> _seriesBpLineData;

  _generateData() {
     _seriesBpLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Systolic',
        data: mockBpRecords,
        domainFn: (BloodPressure bp, _) => bp.date,
        measureFn: (BloodPressure bp, _) => bp.sys,
      ),
    );

    _seriesBpLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        id: 'Diastolic',
        data: mockBpRecords,
        domainFn: (BloodPressure bp, _) => bp.date,
        measureFn: (BloodPressure bp, _) => bp.dia,
      ),
    );

    _seriesBpLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Pulse',
        data: mockBpRecords,
        domainFn: (BloodPressure bp, _) => bp.date,
        measureFn: (BloodPressure bp, _) => bp.pulse,
      ),
    );
    
  }
  
  @override
  void initState() {
    super.initState();
    _seriesBpLineData = List<charts.Series<BloodPressure, DateTime>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Blood Pressure & Pulse"),
      ),
      body: Container(
            child: Center(
                    child: Column(
                      children: <Widget>[            
                        Expanded(
                          child: BloodPressureGraph(lineData: _seriesBpLineData,),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}