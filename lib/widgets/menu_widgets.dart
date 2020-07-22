import 'package:flutter/material.dart';
import 'package:wejog1/screens/home/tabs/logout.dart';

/*menu header*/
class MenuHeader extends StatelessWidget {
  final userId, user;
  MenuHeader({this.userId, this.user});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Text(
        'Hi ' + user.fullName,
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      decoration: BoxDecoration(
        color: Colors.green,
      ),
    );
  }
}
/*end of menu header*/

/*menu items*/
class MenuItemList extends StatelessWidget {
  final userId, user;
  MenuItemList({this.userId, this.user});
  
   @override
   Widget build(BuildContext context) {
    final menuItems = ["Profile", "Calorie Tracker", "Blood Pressure Tracker", "Todo List", "Settings", "Logout"];
    final menuIcons = [Icons.account_circle, Icons.fastfood, Icons.accessibility_new, Icons.list, Icons.settings, Icons.exit_to_app];
    //final routeDestinations = [UserProfile(user: user), CalorieTracker(userId: userId), BloodPressureTracker(userId: userId), TodoScreen(userId: userId), Settings(user: user), Logout()];
    final routeDestinations = [
      '/profile', '/calorieTracker', '/bloodPressure', '/todo', '/settings'
    ];
    final routeArguments = [
      user, userId, userId, userId, user
    ];

     return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return ListTile(        
          leading: Icon(menuIcons[index]),
          title: Text(menuItems[index]),
          onTap: (){
            if(index == 0 || index == 4){
              Navigator.of(context).pushReplacementNamed(
                routeDestinations[index], 
                arguments: routeArguments[index]
              );
            }else if(index == 5){
             Navigator.push(
                context,
                  MaterialPageRoute(builder: (context) => Logout()),
                );
            }else{
              Navigator.of(context).pushNamed(
                routeDestinations[index],
                arguments: routeArguments[index]
              );
            }
          },
         );
        },
      );  
     }
}
/*end of menu items*/