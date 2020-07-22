class DailyData{
  FootSteps footstep;
  Distance distance;
  Calories calorie;
  String id;
  String userId;
  String date;

  DailyData({this.footstep, this.distance, this.calorie, this.id, this.userId, this.date});

  DailyData.fromJson(Map<String, dynamic> json)
      :this(
        footstep: FootSteps.fromJson(json['footstep']),
        distance: Distance.fromJson(json['distance']),
        calorie: Calories.fromJson(json['calorie']),
        id: json['id'],
        userId: json['userId'],
        date: json['date']
        
  );

  Map<String, dynamic> toJson() =>
  {
    'footstep': footstep,
    'distance': distance,
    'calorie': calorie,
    'userId': userId,
    'date': date
  };

}

class FootSteps{
  
  String date;
  int count;
  int cummulativeCount;

  FootSteps({this.date, this.count, this.cummulativeCount});

  FootSteps.fromJson(Map<String, dynamic> json)
      :this(
        date: json['date'],
        count: json['count'],
        cummulativeCount: json['cummulativeCount']
  );

  Map<String, dynamic> toJson() =>
  {
    "date": date,
    "count": count,
    "cummulativeCount": cummulativeCount
  };
}

class Distance{
  
  String date;
  int distanceCount;

  Distance({this.date, this.distanceCount});

  Distance.fromJson(Map<String, dynamic> json)
      :this(
        date: json['date'],
        distanceCount: json['distanceCount']
  );

  Map<String, dynamic> toJson() =>
  {
    "date": date,
    "distanceCount": distanceCount
  };


}

class Calories{
  
  String date;
  int calorieCount;

  Calories({this.date, this.calorieCount});

  Calories.fromJson(Map<String, dynamic> json)
      :this(
        date: json['date'],
        calorieCount: json['calorieCount']
  );

  Map<String, dynamic> toJson() =>
  {
    "date": date,
    "calorieCount": calorieCount
  };

}


