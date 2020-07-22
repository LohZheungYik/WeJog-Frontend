import 'package:flutter/material.dart';
import 'package:wejog1/widgets/menu_widgets.dart';

class NavDrawer extends StatelessWidget {
  final userId, user;
  NavDrawer({this.userId, this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Drawer(  
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            MenuHeader(userId: userId, user: user), //menu header that contain username
            MenuItemList(userId: userId, user: user), //menu items
         ],
        ),
       ),
      );
    }
 }

