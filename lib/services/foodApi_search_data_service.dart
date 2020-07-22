import 'package:wejog1/model/food.dart';
import './foodApi_search_rest_service.dart';

class FoodApiSearchDataService {

  static final FoodApiSearchDataService _instance = FoodApiSearchDataService._constructor();
  factory FoodApiSearchDataService() {
    return _instance;
  }

  FoodApiSearchDataService._constructor();
  final rest = FoodAPISearchService();

  Future<List<Food>> getFoodSearchResults(String query) async {
    final listJson = await rest.get(query);

    return (listJson['foods'] as List)
        .map((itemJson) => Food.fromJson(itemJson))
        .toList();
  }
}
