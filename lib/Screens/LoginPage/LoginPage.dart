import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter01/Controller/UserController.dart';
import 'package:flutter01/Screens/RegisterPage/RegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomePage/HomePage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email_text_field_controller = TextEditingController();
  var password_text_field_controller = TextEditingController();
  var user_logging_result;

  @override
  void initState() {
    _get_ntf_token();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ScreenHeight = MediaQuery.of(context).size.height;
    var ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 208, 127, 1.0),
          ),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            //reverse: true,
            //my login form container
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //upper empty space
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    height:double.infinity,
                    margin: EdgeInsets.only(right: 0.0, left: 0.0, top: 0.0),
                    padding: EdgeInsets.only(right: 12.0, left: 12.0, top: 12.0),
                    child: Center(
                      child: Image(
                        image: AssetImage('assets/images/app_logo.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    //color: Colors.red,
                  ),
                  //color: Colors.red,
                ),
                //welcome text container
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 12.0),
                  //color: Colors.green,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    fit: StackFit.loose,
                    children: [
                      //1st welcome text line
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25 * 0.5,
                        //color: Colors.yellow,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              top: 0.0, bottom: 0.0, start: 0.0, end: 0.0),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Text("Hello",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(226, 106, 44, 1.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //2nd welcome text line
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25 * 0.5,
                        //color: Colors.yellow,
                        margin: EdgeInsetsDirectional.only(
                            top: MediaQuery.of(context).size.height * 0.25 * 0.4,
                            bottom: 0.0, start: 0.0, end: 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              top: 0.0, bottom: 0.0, start: 4.0, end: 0.0),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Text("There.",
                              style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(225, 112, 26, 1.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //email and password container
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 12.0),
                  //color: Colors.black,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                        width: double.infinity,
                        child: Container(
                          //color: Colors.blue,
                        ),
                        //color: Colors.red,
                      ),
                      //email text field container
                      Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color.fromRGBO(170, 170, 170, 0.50),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: email_text_field_controller,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.80),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 12.0),
                              border: InputBorder.none,
                              hintText: "Email Address",
                              hintStyle: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                        width: double.infinity,
                        child: Container(
                          //color: Colors.blue,
                        ),
                        //color: Colors.red,
                      ),
                      //password text field container
                      Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color.fromRGBO(170, 170, 170, 0.50),
                        ),
                        child: Center(
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: Center(
                                  child: TextFormField(
                                    controller: password_text_field_controller,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.80),
                                    ),
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 12.0,
                                          right: MediaQuery.of(context).size.height * 0.06),
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: double.infinity,
                                width: MediaQuery.of(context).size.height * 0.06,
                                margin: EdgeInsets.only(right: 4.0,),
                                child: Center(
                                  child: IconButton(
                                      icon: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        child: Icon(Icons.lock, size: 32,),
                                      ),
                                      onPressed: null
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //space between password field and forgot password
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                        width: double.infinity,
                        child: Container(
                          //color: Colors.blue,
                        ),
                      ),
                      //forgot password container
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: double.infinity,
                        //color: Colors.yellow,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: null,
                              child: Container(
                                height: double.infinity,
                                width: MediaQuery.of(context).size.width * 0.40,
                                //color: Colors.purple,
                                margin: EdgeInsets.only(right: 4.0, top: 0.0, bottom: 20.0),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //space between forgot password and end of email password container
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                        width: double.infinity,
                        child: Container(
                          //color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                //signin and sign up buttons container
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 12.0),
                  //color: Colors.white,
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 30,
                        child: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                      Expanded(
                        flex: 40,
                        child: Container(
                          height: double.infinity,
                          width: MediaQuery.of(context).size.width*0.5,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0, bottom: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(226, 106, 44, 1.0),
                          ),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: GestureDetector(
                              onTap: (){
                                _LogUserIn(
                                  email: email_text_field_controller.text.toString(),
                                  password: password_text_field_controller.text.toString()
                                ).then((result) async{
                                  if(result == true){
                                    SharedPreferences shared_prefs = await SharedPreferences.getInstance();
                                    shared_prefs.setInt(
                                      'user_id', user_logging_result['user_id'].toInt());
                                    shared_prefs.setString(
                                      'user_name', user_logging_result['user_name'].toString());
                                    shared_prefs.setString(
                                      'user_email', user_logging_result['user_email'].toString());
                                    shared_prefs.setString(
                                      'user_api_token', user_logging_result['user_api_token'].toString());
                                    print("user_api_token: ${user_logging_result['user_api_token'].toString()}");
                                    shared_prefs.setString(
                                      'user_ntf_token', user_logging_result['user_ntf_token'].toString());
                                    print("user_ntf_token: ${user_logging_result['user_ntf_token'].toString()}");
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) => HomePage())
                                    );
                                  }
                                });
                              },
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 8
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.topCenter,
                          height: double.infinity,
                          margin: EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //color: Color.fromRGBO(226, 106, 44, 1.0),
                          ),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => RegisterPage())
                                );
                              },
                              child: Text(
                                'Not Having an Account? Register Now!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _LogUserIn({String email, String password}) async{
    bool result;
    Map<String, dynamic> user_credentials = <String, dynamic>{
      'email': email,
      'password': password,
    };
    await UserController.LoginUser(user_credentials).then((value) {
      setState(() {
        user_logging_result = value;
        email_text_field_controller.clear();
        password_text_field_controller.clear();
      });
      if(user_logging_result != null){
        print("logging user in is successful");
        print(user_logging_result);
        result= true;
      }
      else{
        print("logging user in is unsuccessful");
        result= false;
      }
    });
    return result;
  }

  void _get_ntf_token() async {
    FirebaseMessaging firebase_messaging_isntance = FirebaseMessaging();
    var ntf_token = await firebase_messaging_isntance.getToken();
    print('ntf_token: ${ntf_token}');
  }

}