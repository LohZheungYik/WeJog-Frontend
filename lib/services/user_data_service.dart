import 'package:wejog1/model/user.dart';
import './rest_service.dart';

class UserDataService {

  static final UserDataService _instance = UserDataService._constructor();
  factory UserDataService() {
    return _instance;
  }

  UserDataService._constructor();
  final rest = RestService();

  Future<User> createUser({User user}) async {
    final json = await rest.post('users', data: user);
    return User.fromJson(json);
  }

  Future<User> getUserDetail({String userId}) async{
    final listJson = await rest.get('users');
    User user = User();
  if(listJson!=null){
    List userList = (listJson as List)
        .map((itemJson) => ((itemJson['userId'] == userId))? User.fromJson(itemJson):null)
        .toList();
    
    for(int i=0; i<userList.length; i++){
      if(userList[i] != null){
        user = userList[i];
      }else{
        continue;
      }
    }
    
    return user;
  }
  return null;
  }

   void updateUserDetail({User user}) async{
    final listJson = await rest.get('users');
    String id = "";
    if(listJson!=null){
    List userList = (listJson as List)
        .map((itemJson) => ((itemJson['userId'] == user.userId))? User.fromJson(itemJson):null)
        .toList();
    
    for(int i=0; i<userList.length; i++){
      if(userList[i] != null){
        id = userList[i].id;
      }else{
        continue;
      }
    }
    }
  
    final json = await rest.patch('users/$id', data: {
      'location': user.location,
      'nationality': user.nationality,
      'birthYear': user.birthYear,
      'weight': user.weight,
      'height': user.height,
    });
    

  }

   void updateUserSetting({User user}) async{
    final listJson = await rest.get('users');
    String id = "";
    if(listJson != null){
    List userList = (listJson as List)
        .map((itemJson) => ((itemJson['userId'] == user.userId))? User.fromJson(itemJson):null)
        .toList();
    
    for(int i=0; i<userList.length; i++){
      if(userList[i] != null){
        id = userList[i].id;
      }else{
        continue;
      }
    }
    }
  
    final json = await rest.patch('users/$id', data: {
      'calorieGoal': user.calorieGoal,
      'distanceGoal': user.distanceGoal,
      'stepGoal': user.stepGoal
    });
    
    print(user.userId);
    print(id);

  }

}
