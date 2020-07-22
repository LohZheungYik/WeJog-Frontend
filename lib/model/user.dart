//User class

class User{
  String fullName = "", 
        location = "",
        nationality = "",
        email = "",
        userId = "",
        id = "";
  
  int age = 0,
      height = 0,
      weight = 0,
      birthYear = 0,
      stepGoal = 10000,
      distanceGoal = 2000,
      calorieGoal = 600;

  User({
    this.fullName, 
    this.location,
    this.nationality,
    this.email,
    this.birthYear,
    this.height,
    this.weight,
    this.userId,
    this.stepGoal,
    this.distanceGoal,
    this.calorieGoal,
    this.id
    
  });

  User.fromJson(Map<String, dynamic> json)
      :this(
        fullName: json['fullName'],
        location: json['location'],
        nationality: json['nationality'],
        email: json['email'],
        birthYear: json['birthYear'],
        height: json['height'],
        weight: json['weight'],
        userId: json['userId'],
        stepGoal: json['stepGoal'],
        distanceGoal: json['distanceGoal'],
        calorieGoal: json['calorieGoal'],
        id: json['id']
  );

  Map<String, dynamic> toJson() =>
  {
    "fullName": fullName,
    "location": location,
    "nationality": nationality,
    "email": email,
    "birthYear": birthYear,
    "height": height,
    "weight": weight,
    "userId": userId,
    "stepGoal": 10000,
    "distanceGoal": 2000,
    "calorieGoal": 600 
  };

  
}