import 'package:wejog1/model/serving.dart';

import './rest_service.dart';

class CalorieDataService {

  static final CalorieDataService _instance = CalorieDataService._constructor();
  factory CalorieDataService() {
    return _instance;
  }

  

  CalorieDataService._constructor();
  final rest = RestService();
  
   Future<List<Serving>> getAllServings({String userId, String date}) async {
    
    
    final listJson = await rest.get('calorie');
      
      if(listJson != null){ 
       List<Serving> foodList =  (listJson as List)
        .map((itemJson) => ((itemJson['userId'] == userId) && (itemJson['date'] == date))?Serving.fromJson(itemJson):null)
        .toList();

      List<Serving>userFoodList = List<Serving>();

      for(int i=0; i<foodList.length; i++){
        if(foodList[i] != null){
          userFoodList.add(foodList[i]);
        }else{
          continue;
        }
      }
        return userFoodList;
      
      }
      
   }
  

  Future<Serving> createServingRecord({Serving serving}) async {
    final json = await rest.post('calorie', data: serving);
    return Serving.fromJson(json);
  }

  Future<Serving> updateServingRecord({String id, Serving serving}) async{
    final json = await rest.patch('calorie/$id', data: {
    	'number': serving.number
    });
    return Serving.fromJson(json);
  }

   Future deleteServingRecord({String id}) async {
    await rest.delete('calorie/$id');
  }

}
