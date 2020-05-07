class Food{
  String name;
  double calories;
  int _serving = 0;

  Food(this.name, this.calories);
  set serving(int s){
    _serving = s;
  }
  int get serving{
    return _serving;
  }
}