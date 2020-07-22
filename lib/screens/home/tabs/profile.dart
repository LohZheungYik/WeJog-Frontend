import 'package:flutter/material.dart';
import 'package:wejog1/model/user.dart';
import 'package:wejog1/screens/home/dashboard.dart';
import 'package:wejog1/services/user_data_service.dart';
import 'package:wejog1/widgets/profile_widgets.dart';

class UserProfile extends StatefulWidget {
  User user;
  UserProfile({this.user});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController locationController = new TextEditingController(),
                        nationalityController = new TextEditingController(),
                        birthYearController = new TextEditingController(),
                        weightController = new TextEditingController(),
                        heightController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    locationController.text = widget.user.location;
    nationalityController.text = widget.user.nationality;
    birthYearController.text = widget.user.birthYear.toString();
    weightController.text = widget.user.weight.toString();
    heightController.text = widget.user.height.toString();
    
    return WillPopScope(
          onWillPop: ()async => false,
          child: Scaffold(
         appBar: AppBar(
          backgroundColor: Colors.green[500],
          elevation: 0,
          title: Text("My Profile"),
          leading: IconButton(icon: Icon(
            Icons.arrow_back
          ), onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dashboard(userId: widget.user.userId,)));
          }),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[ 
                ProfileContents(user:widget.user, state: this),
              ],
            ),
          )
        ),
        floatingActionButton: SaveButton(
          locationController: locationController, 
          nationalityController: nationalityController, 
          birthYearController: birthYearController, 
          weightController: weightController, 
          heightController: heightController, 
          widget: widget
        ),
      ),
    );
   }
  
 }

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key key,
    @required this.locationController,
    @required this.nationalityController,
    @required this.birthYearController,
    @required this.weightController,
    @required this.heightController,
    @required this.widget,
  }) : super(key: key);

  final TextEditingController locationController;
  final TextEditingController nationalityController;
  final TextEditingController birthYearController;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final UserProfile widget;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async{
        User updateUser = User(
          location: locationController.text,
          nationality: nationalityController.text,
          birthYear: int.parse(birthYearController.text),
          weight: int.parse(weightController.text),
          height: int.parse(heightController.text),
          userId: widget.user.userId
        );

        UserDataService u = UserDataService();
        u.updateUserDetail(user: updateUser);
        
        var snackBar = SnackBar(content: 
          Text("Updated"),
        );

        Scaffold.of(context).showSnackBar(snackBar);
       
      }, 
      label: Text("Save Changes"),
    );
  }
}


/*User profile information*/
class ProfileContents extends StatelessWidget {
  final user, state;
  ProfileContents({this.user, this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 5,0,0),
              child: Text("Tap a field to edit")
            ),
        ],),
        SizedBox(height: 15,),  
        InputBox(
          title: "Location", 
          hint: "Please enter your location", 
          ctrl: state.locationController, 
          inputType: TextInputType.text
        ),
        SizedBox(height: 15,),
        InputBox(
          title: "Nationality", 
          hint: "Please enter your nationality", 
          ctrl: state.nationalityController,
          inputType: TextInputType.text
        ),
        SizedBox(height: 15,),
        InputBox(
          title: "Year of birth", 
          hint: "Please enter your year of birth", 
          ctrl: state.birthYearController,
          inputType: TextInputType.number
        ),
        SizedBox(height: 15,),
        InputBox(
          title: "Weight (kg)", 
          hint: "Please enter your weight",
          ctrl: state.weightController,
          inputType: TextInputType.number
        ),
        SizedBox(height: 15,),
        InputBox(
          title: "Height (cm)", 
          hint: "Please enter your height", 
          ctrl: state.heightController,
          inputType: TextInputType.number
        ),
    ],
  ); 
}
}
/*User profile information end*/

