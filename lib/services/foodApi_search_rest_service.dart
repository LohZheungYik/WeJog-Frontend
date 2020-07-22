import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodAPISearchService {
  static final FoodAPISearchService _instance = FoodAPISearchService._constructor();
  factory FoodAPISearchService() {
    return _instance;
  }

  FoodAPISearchService._constructor();

  static const String baseUrl =
      'https://api.nal.usda.gov/fdc/v1/search?api_key=QKWPuyXrxLCe5fr9AExKGAtU9Brn9CkiIo2eH103&generalSearchInput=';

  Future get(String query) async {
    final response = await http.get('$baseUrl'+'$query');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

}
