//Food Class

class Food{
  String name;
  double calories;
  int serving = 0;
  List nutritions; 

  Food(this.name, this.nutritions);

  Food.fromJson(Map<String, dynamic> json)
      :this(
        json['description'],
        json['foodNutrients'],
  );

}

