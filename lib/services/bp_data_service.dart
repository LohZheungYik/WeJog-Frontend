import 'package:wejog1/model/blood_pressure.dart';

import './rest_service.dart';

class BpDataService {
  static final BpDataService _instance = BpDataService._constructor();
  factory BpDataService() {
    return _instance;
  }

  BpDataService._constructor();
  final rest = RestService();

  Future<List<BloodPressure>> getAllBp({String userId}) async {
    final listJson = await rest.get('bloodpressure');
    List<BloodPressure>userBpList = List<BloodPressure>();

    if(listJson != null){
    List<BloodPressure> bpList = (listJson as List)
        .map((itemJson) => ((itemJson['userId'] == userId))?BloodPressure.fromJson(itemJson):null)
        .toList();

    
      for(int i=0; i<bpList.length; i++){
        if(bpList[i] != null){
          userBpList.add(bpList[i]);
        }else{
          continue;
        }
      }
    }
    return userBpList;
  }

  Future deleteBp({String id}) async {
    await rest.delete('bloodpressure/$id');
  }

  Future<BloodPressure> createBP({BloodPressure bp}) async {
    final json = await rest.post('bloodpressure', data: bp);
    return BloodPressure.fromJson(json);
  }

  Future<BloodPressure> getBP({String id, BloodPressure bp}) async {
    final json = await rest.get('bloodpressure/$id');

    return BloodPressure.fromJson(json);
  }
}
