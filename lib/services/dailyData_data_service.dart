import 'package:intl/intl.dart';
import 'package:wejog1/model/daily_data.dart';
import './rest_service.dart';

class DailyDataService {

  static final DailyDataService _instance = DailyDataService._constructor();
  factory DailyDataService() {
    return _instance;
  }

  DailyDataService._constructor();
  final rest = RestService();

  void createDailyData({DailyData dailyData}) async {
    final json = await rest.post('dailyData', data: dailyData);
  }

  Future<DailyData> checkDataExistence({String userId, String date}) async{
    final listJson = await rest.get('dailyData');

    DailyData existingData = new DailyData();
    if(listJson != null){
    List<DailyData> dataList =  (listJson as List)
        .map((itemJson) => ((itemJson['userId'] == userId) && (itemJson['date'] == date))?DailyData.fromJson(itemJson):null)
        .toList();

      for(int i=0; i<dataList.length; i++){
       if(dataList[i] != null){ 
        if((dataList[i].userId == userId) && (dataList[i].date == date)){
          
          existingData = dataList[i];
          return existingData;
        }else{
          return null;
        }
       }else{
         continue;
       }
      }
      }
      return null;
  }

  Future<int> getPreviousFootStep({String userId, String todayDate}) async{
  	final listJson = await rest.get('dailyData');
    
    if(listJson != null){
    List<DailyData> rawDataList =  (listJson as List)
        .map((itemJson) => ((itemJson['userId'] == userId))?DailyData.fromJson(itemJson):null)
        .toList();

    List<DailyData> dataList = List<DailyData>();

    for(int i=0; i<rawDataList.length; i++){
      if((rawDataList[i] != null) && (rawDataList[i].date != todayDate)){
        dataList.add(rawDataList[i]);
      }else{
        continue;
      }
    }

    DateTime today = DateTime.now();
    if(dataList.length > 0){
    int smallestDateDifference = today.difference(DateTime.parse(
      dataList[0].date
    )).inDays;

    int yesterdayIndex = 0;
    int dateDifference = 0;

    for(int i=0; i<dataList.length; i++){
       if(dataList[i] != null){ 
        if((dataList[i].userId == userId)){
          
          DateTime dataDate = DateTime.parse(dataList[i].date);
          dateDifference = today.difference(dataDate).inDays;
          print(dataDate.toString() + "#" + dateDifference.toString());

          if(dateDifference == 0){
            continue;
          }
          else if((dateDifference < smallestDateDifference) && dateDifference > 0 ){
            smallestDateDifference = dateDifference;
            yesterdayIndex = i;
          }
        }else{
          continue;
        }
       }else{
         continue;
       }
      }
      
      if(dateDifference == 0){
        //print("120 = " +dateDifference.toString());
        return 0;
      }else{
        //print("cCount = " +dataList[yesterdayIndex].footstep.cummulativeCount.toString());
        //print(dataList[yesterdayIndex].date);
        return dataList[yesterdayIndex].footstep.cummulativeCount;
      }
      
      }
    }
    //print(0);
      return 0;

    
  }

   Future<int> getTodayFootStep({String userId}) async{
   		final dateFormat = new DateFormat('yyyy-MM-dd');
       var dateTime = DateTime.now();
      String date = dateFormat.format(dateTime);

   		final listJson = await rest.get('dailyData');
    	if(listJson != null){
    		List<DailyData> dataList =  (listJson as List)
        	.map((itemJson) => ((itemJson['userId'] == userId) && (itemJson['date'] == date))?DailyData.fromJson(itemJson):null)
        	.toList();

      	for(int i=0; i<dataList.length; i++){
       		if(dataList[i] != null){ 
        		if((dataList[i].userId == userId) && (dataList[i].date == date)){
          			return dataList[i].footstep.count;
        		}else{
          		return 0;
        		}
       		}else{
         		continue;
       		}
      		}
      	}
      return 0;
   }

  void updateDailyData({String id, DailyData dailyData}) async{
    final json = await rest.patch('dailyData/$id', data: {
      "calorie": {
        "calorieCount": dailyData.calorie.calorieCount,
        "date": dailyData.calorie.date
      },
      "distance": {
        "date": dailyData.distance.date,
        "distanceCount": dailyData.distance.distanceCount
      },
      "footstep": { 
        "count": dailyData.footstep.count,
        "cummulativeCount": dailyData.footstep.cummulativeCount,
        "date": dailyData.footstep.date
      }
    }); 
  }
}
