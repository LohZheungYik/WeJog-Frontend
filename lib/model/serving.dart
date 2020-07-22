//Food Serving (for calorie tracker)

class Serving{
  String name, servingId, date, userId, id;
  int number;
  double calorie;

  Serving({
    this.name,
    this.servingId,
    this.date,
    this.userId,
    this.number,
    this.calorie,
    this.id
  });

  Serving.fromJson(Map<String, dynamic> json)
      :this(
        name: json['name'],
        servingId: json['servingId'],
        date: json['date'],
        userId: json['userId'],
        number: json['number'],
        calorie: json['calorie'].toDouble(),
        id: json['id']
  );

  Map<String, dynamic> toJson() =>
  {
    "name": name,
    "servingId": servingId,
    "date": date,
    "userId": userId,
    "number": number,
    "calorie": calorie
  };

}