import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter01/Screens/HomePage/HomePage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/LoginPage/LoginPage.dart';
import 'Constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences shared_prefs = await SharedPreferences.getInstance();
  print('lanching app');
  print("token ${shared_prefs.getString('user_api_token')}");
  var status = (shared_prefs.getString('user_api_token') != null)
      && (shared_prefs.getString('user_ntf_token') != null);
  print("status ${status}");
  runApp(MyApp(logged: status));
}

class MyApp extends StatelessWidget {
  final bool logged;


  MyApp({this.logged}); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mega Store',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (logged) ? HomePage() : LoginPage(title: 'Login Page') ,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}




/*class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _value= 0;
  var text_controller= TextEditingController();
  var value_controller= TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mahmoud For Flutter Development",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.lock),
            onPressed: () {
              return Fluttertoast.showToast(msg: "Logout");
            },
          ),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                return Fluttertoast.showToast(msg: "Settings");
              }),
          GestureDetector(
            child: Icon(Icons.alarm),
            onTap: (){
              return Fluttertoast.showToast(msg: "alarm");
            },
          )
        ],
      ),
      drawer: Drawer(),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: ListView(children: <Widget>[
          Row(
            children: [
              Container(
                height: 100,
                width: (MediaQuery.of(context).size.width) / 3,
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text('1', style: TextStyle(fontSize: 20))],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('2', style: TextStyle(fontSize: 20))],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Text('3', style: TextStyle(fontSize: 20))],
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                width: (MediaQuery.of(context).size.width) / 3,
                color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('4', style: TextStyle(fontSize: 20)),
                    Text('5', style: TextStyle(fontSize: 20)),
                    Text('6', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              Container(
                height: 100,
                width: (MediaQuery.of(context).size.width) / 3,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('7', style: TextStyle(fontSize: 20)),
                        Text('8', style: TextStyle(fontSize: 20)),
                        Text('9', style: TextStyle(fontSize: 20))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(
            color: Colors.amber,
            height: 40,
            thickness: 2.5,
          ),
          Padding(
              padding: EdgeInsets.all(4),
              child: TextFormField(
                controller: text_controller,
                decoration: InputDecoration(
                  hintText: 'enter your name'
                )
              )
          ),
          RaisedButton(
            child: Icon(Icons.person),
            onPressed: (){
              var text= text_controller.text.toString();
              text_controller.clear();
              if(text.isNotEmpty){
                return Fluttertoast.showToast(msg: text);
              }
              else{
                return Fluttertoast.showToast(msg: "enter valid input");
              }
            }
          ),
          Divider(
            color: Colors.amber,
            height: 40,
            thickness: 2.5,
          ),
          ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Card(
                  child: ListTile(
                    title: Text("hi",
                        style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    subtitle: Text("some text",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
              Card(
                  child: ListTile(
                    title: Text("hi",
                        style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    subtitle: Text("some text",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
              Card(
                  child: ListTile(
                    title: Text("hi",
                        style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    subtitle: Text("some text",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
              Card(
                  child: ListTile(
                    title: Text("hi",
                        style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    subtitle: Text("some text",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
              Card(
                  child: ListTile(
                    title: Text("hi",
                        style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    subtitle: Text("some text",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
              Card(
                  child: ListTile(
                    title: Text("hi",
                        style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    subtitle: Text("some text",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
              Card(
                  child: ListTile(
                    title: Text("hi",
                        style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    subtitle: Text("some text",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
              Card(
                  child: ListTile(
                    title: Text("hi",
                        style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    subtitle: Text("some text",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
              Card(
                  child: ListTile(
                    title: Text("hi",
                        style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    subtitle: Text("some text",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
              Card(
                  child: ListTile(
                    title: Text("hi",
                        style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    subtitle: Text("some text",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ))
            ],
          ),
          Text(_value.toString(), style: TextStyle(fontSize: 48)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(child: Text("add"), onPressed: (){
                _value++;
                setState(() {

                });
              }),
              RaisedButton(child: Text("subtract"), onPressed: (){
                _value--;
                setState(() {

                });
              }),
              RaisedButton(child: Text("enter value"),
                  onPressed: (){
                    showDialog<void>(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('enter value'),
                            content: TextFormField(
                              controller: value_controller,
                              decoration: InputDecoration(
                                hintText: "enter value"
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _value= int.parse(value_controller.text);
                                      value_controller.clear();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text('Close')),
                            ],
                          );
                        });
                  }),
            ],
          )
        ]),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.chat),
      //   onPressed: () {
      //     return Fluttertoast.showToast(msg: "chat");
      //   },
      // ),
    );
  }
}*/
