import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter01/Controller/UserController.dart';
import 'package:flutter01/Screens/LoginPage/LoginPage.dart';
import 'package:flutter01/Screens/RegisterPage/RegisterPage.dart';
import 'package:flutter01/src/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ProfileWidget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _user;

  @override
  void initState() {
    _GetUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsetsDirectional.only(
          top: 32
        ),
        color: primary_color_light,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: (_user != null) ? _user['image_url'] : '',
              onClicked: () async {
              },
            ),
            const SizedBox(height: 24),
            buildName(_user),
            const SizedBox(height: 24),
            Center(child: buildUpgradeButton()),
            const SizedBox(height: 24),
            //NumbersWidget(),
            const SizedBox(height: 48),
            buildAbout(_user),
          ],
        ),
      ),
    );
  }

  Widget buildName(user) {
    print("build name");
    return Column(
    children: [
      Text(
        (_user != null) ? _user['name'] : '',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        (_user != null) ? _user['email'] : '',
        style: TextStyle(color: Colors.grey),
      )
    ],

  );
  }

  Widget buildUpgradeButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      ),
      child: Text('Upgrade To PRO'),
      onPressed: () {},
    );
  }

  Widget buildAbout(user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          (_user != null) ? _user['about'] : '',
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );

  Future<void> _GetUserData() async{
    SharedPreferences shared_prefs = await SharedPreferences.getInstance();
    setState(() {
      _user = <String, dynamic>{
        'name': shared_prefs.getString('user_name'),
        'email': shared_prefs.getString('user_email'),
        'phone': shared_prefs.getString('+9055379551'),
        'image_url': 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1024px-Circle-icons-profile.svg.png',
        'about': "Hi I am Mahmoud and I Love Mr. Eyad.\nيخلي لنا اياك"
      };
      print(_user);
    });
  }

}
