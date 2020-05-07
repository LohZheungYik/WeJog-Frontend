
import 'package:wejog1/model/BloodPressure.dart';
import 'package:wejog1/model/Food.dart';
import 'package:wejog1/model/Health.dart';
import 'package:wejog1/model/Todo.dart';

List <Food> foodDataList = [
  Food("Nasi lemak", 650),
  Food("Milo", 120),
  Food("Fried chicken", 250),
  Food("Fish head curry", 288),
  Food("Stir Fried vegetables", 66),
  Food("Chicken curry", 200),
  Food("Chicken rice", 230),
  Food("Fried kembong fish", 219),
  Food("Agar-agar", 37),
  Food("Coconut water", 110),
  Food("Fried sotong", 630),
];

 List<Todo>mockTodo = [
  Todo("Buy vegetables", "wireframes only", true),
  Todo("Prototype 1", "compulsory scr only", true),
  Todo("Prototype 2", "frontend only", false),
  Todo("Backend", "finish app with backend", false),
  
];

  //mock data
  var lineFootStepsData = [
    FootSteps(DateTime(2020,4,20), 500),
    FootSteps(DateTime(2020,4,21), 700),
    FootSteps(DateTime(2020,4,22), 200),
    FootSteps(DateTime(2020,4,23), 100),
    FootSteps(DateTime(2020,4,24), 200),  
  ];

  var lineActiveMinutesData = [
    ActiveMinutes(DateTime(2020,4,20), 45),
    ActiveMinutes(DateTime(2020,4,21), 60),
    ActiveMinutes(DateTime(2020,4,22), 40),
    ActiveMinutes(DateTime(2020,4,23), 75),
    ActiveMinutes(DateTime(2020,4,24), 45), 
  ];

  var lineDistanceData = [
    Distance(DateTime(2020,4,20), 450),
    Distance(DateTime(2020,4,21), 500),
    Distance(DateTime(2020,4,22), 300),
    Distance(DateTime(2020,4,23), 700),
    Distance(DateTime(2020,4,24), 450), 
  ];

  var lineCaloriesData = [
    Calories(DateTime(2020,4,20), 245),
    Calories(DateTime(2020,4,21), 460),
    Calories(DateTime(2020,4,22), 340),
    Calories(DateTime(2020,4,23), 575),
    Calories(DateTime(2020,4,24), 545), 
  ];

  List<BloodPressure>mockBpRecords = [
  BloodPressure(110, 70, 65, DateTime(2020,4,20)),
  BloodPressure(140, 90, 73, DateTime(2020,4,21)),
  BloodPressure(130, 80, 80, DateTime(2020,4,22)),
  BloodPressure(120, 80, 65, DateTime(2020,4,23)),
];