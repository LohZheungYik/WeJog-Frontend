import 'package:flutter/material.dart';
import 'package:wejog1/model/BloodPressure.dart';
import 'package:charts_flutter/flutter.dart' as charts;


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

class SaveBpButton extends StatelessWidget {
  final sys, dia, pulse;
  SaveBpButton({this.sys, this.dia, this.pulse});
  
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
            color: Colors.green,
            onPressed: (){
              BloodPressure bp = new BloodPressure(
                int.parse(sys),
                int.parse(dia),
                int.parse(pulse),
                DateTime.now()
              );

              Navigator.of(context).pop(bp);
            },
            child: Text("Save", style: 
              TextStyle(
                color: Colors.white,
              ),),  
          );
  }
}

class BloodPressureGraph extends StatelessWidget {
  final lineData;
  BloodPressureGraph({this.lineData});

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
                            lineData,
                            defaultRenderer: new charts.LineRendererConfig(
                            includeArea: true, stacked: false),
                            animate: true,
                            animationDuration: Duration(seconds: 1),
                            behaviors: [
                              new charts.ChartTitle('Date',
                                behaviorPosition: charts.BehaviorPosition.bottom,
                                titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
                              new charts.ChartTitle('Value',
                                behaviorPosition: charts.BehaviorPosition.start,
                                titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                              new charts.SeriesLegend()
                            ]
                          );
  }
}