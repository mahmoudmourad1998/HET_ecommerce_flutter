import 'package:flutter/cupertino.dart';
import 'package:flutter01/Controller/OrderController.dart';
import 'package:flutter01/Model/Order.dart';
import 'package:flutter01/src/Constants.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  var my_orders = <Order>[];
  String my_orders_string= "";

  @override
  void initState(){
    _PassingOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsetsDirectional.only(
        start: 8.0,
        end: 8.0,
      ),
      decoration: BoxDecoration(
        color: background_color_light,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Column(
            children: [
              Text(
                "الزلمه هاد معاه مصاري كتير مو شايفين الاوردرات عقبالنا :(",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0
                ),
              ),
              Container(
                child: Center(
                  child: Text(my_orders_string),
                ),
              ),
            ]
        ),
      ),
    );
  }

  Future<void> _PassingOrders() async{
    await OrderController.GetAllOrdersOfUser()
      .then((result){
        setState(() {
          my_orders = result;
          my_orders.forEach((element) {my_orders_string= my_orders_string +  "\n\n" + element.toString();});
        });
      });
  }
}
