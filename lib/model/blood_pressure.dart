//Blood Pressure Class

class BloodPressure {
  int sys, dia, pulse;
  String date;
  String userId, id;
  BloodPressure({this.sys, this.dia, this.pulse, this.date, this.userId, this.id});

  BloodPressure.fromJson(Map<String, dynamic> json)
      : this(
          sys: json['sys'],
          dia: json['dia'],
          pulse: json['pulse'],
          date: json['date'],
          userId: json['userId'],
          id: json['id']
  );

  Map<String, dynamic> toJson() => {
        "sys": sys,
        "dia": dia,
        "pulse": pulse,
        "date": date,
        "userId": userId
      };
}
