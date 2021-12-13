import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter01/Controller/UserController.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var full_name_controller= TextEditingController();
  var email_controller= TextEditingController();
  var password_controller= TextEditingController();
  var password_controller2= TextEditingController();
  var phone_controller= TextEditingController();
  FirebaseMessaging firebase_messaging_isntance = FirebaseMessaging();
  var user_registration_result;

  @override
  Widget build(BuildContext context) {
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
            //reverse: false,
            //my login form container
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.00,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    width: double.infinity,
                    height:double.infinity,
                    color: Colors.green,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.94,
                  //color: Colors.black,
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Expanded(
                        flex: 20,
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          //color: Colors.red,
                          margin: EdgeInsets.only(right: 24.0, left: 24.0, top: 0.0),
                          padding: EdgeInsets.only(right: 12.0, left: 12.0, top: 24.0),
                          child: Image(
                            image: AssetImage('assets/images/app_logo.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      //input fields container
                      Expanded(
                        flex: 60,
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          //color: Colors.blue,
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              //name text field
                              Expanded(
                                flex: 20,
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Color.fromRGBO(170, 170, 170, 0.50),
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      controller: full_name_controller,
                                      keyboardType: TextInputType.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.80),
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 12.0),
                                        border: InputBorder.none,
                                        hintText: "Full Name",
                                        hintStyle: TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.75)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //email address text field
                              Expanded(
                                flex: 20,
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Color.fromRGBO(170, 170, 170, 0.50),
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: email_controller,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.80),
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 12.0),
                                        border: InputBorder.none,
                                        hintText: "Email Address",
                                        hintStyle: TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.75)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //password text field
                              Expanded(
                                flex: 20,
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
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
                                              controller: password_controller,
                                              keyboardType: TextInputType.visiblePassword,
                                              style: TextStyle(
                                                fontSize: 20,
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
                                                    fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.75)),
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
                              ),
                              //confirm password text field
                              Expanded(
                                flex: 20,
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
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
                                              controller: password_controller2,
                                              keyboardType: TextInputType.visiblePassword,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black.withOpacity(0.80),
                                              ),
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(left: 12.0,
                                                    right: MediaQuery.of(context).size.height * 0.06),
                                                border: InputBorder.none,
                                                hintText: "Confirm Password",
                                                hintStyle: TextStyle(
                                                    fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.75)),
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
                              ),
                              //phone number text field
                              Expanded(
                                flex: 20,
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Color.fromRGBO(170, 170, 170, 0.50),
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      controller: phone_controller,
                                      keyboardType: TextInputType.phone,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.80),
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 12.0),
                                        border: InputBorder.none,
                                        hintText: "Phone Number",
                                        hintStyle: TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.75)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //register button container
                      Expanded(
                        flex: 20,
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 12.0),
                          //color: Colors.white,
                          child: Flex(
                            direction: Axis.vertical,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 18,
                                child: SizedBox(
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                              ),
                              Expanded(
                                flex: 60,
                                child:  Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  height: double.infinity,
                                  width: MediaQuery.of(context).size.width*0.45,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0, bottom: 8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(226, 106, 44, 1.0),
                                  ),
                                  child: MaterialButton(
                                    onPressed: (){
                                      _RegisterUser();
                                    },
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: FittedBox(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      fit: BoxFit.fill,
                                      child: Text(
                                        'REGISTER',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2
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
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Already Having an Account? Sign In!',
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
                                flex: 7,
                                child: SizedBox(
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    width: double.infinity,
                    height:double.infinity,
                    //color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dynamic _GetNtfToken() async{
    return await firebase_messaging_isntance.getToken();
  }

  void _RegisterUser() async{
    var ntf_token;
    await _GetNtfToken().then((result){
      ntf_token = result;
      print("ntf token ${ntf_token}");
    });
    Map<String, dynamic> user_credentials = <String, dynamic>{
      'name': full_name_controller.text.toString(),
      'email': email_controller.text.toString(),
      'password': password_controller.text.toString(),
      'ntf_token': ntf_token.toString(),
    };
    await UserController.RegisterUser(user_credentials).then((value) {
      setState(() {
        user_registration_result = value;
        full_name_controller.clear();
        email_controller.clear();
        password_controller.clear();
        password_controller2.clear();
        phone_controller.clear();
      });
      if(user_registration_result != null){
        print("registration successful");
        print(user_registration_result);
      }
      else{
        print("registration unsuccessful");
      }
    });
  }
}
