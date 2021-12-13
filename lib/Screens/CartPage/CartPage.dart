import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter01/Controller/OrderController.dart';
import 'package:flutter01/Model/OrderItem.dart';
import 'package:flutter01/Model/Product.dart';
import 'package:flutter01/Screens/CartPage/CartItem.dart';
import 'package:flutter01/src/Constants.dart';
import 'package:flutter_svg/svg.dart';

class CartPage extends StatefulWidget {
   CartPage({Key key}) : super(key: key);
   static List<CartItem> cart_items = <CartItem>[];

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int selected_index_cart_items_list_view;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: background_color_light,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            _BuildTitle(context),
            _BuildItemsListView(context),
            _BuildConfirmOrder(),
          ]
        ),
      ),
    );
  }

  Widget _BuildTitle(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.10,
      width: double.infinity,
      //color: Colors.purple,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(
              start: 0.0, end: 0.0, top: 8.0, bottom: 0.0,
            ),
            alignment: Alignment.center,
            //color: Colors.green,
            child: Text(
              "Your Cart:",
              style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 3.0,
                  fontWeight: FontWeight.w900
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsetsDirectional.only(
                start: 0.0, end: 0.0, top: 4.0, bottom: 0.0,
              ),
              alignment: Alignment.center,
              //color: Colors.green,
              child: Text(
                "Items: ${CartPage.cart_items.length}",
                style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(
              start: 16.0, end: 16.0, top: 4.0, bottom: 0.0,
            ),
            child: Divider(
              thickness: 2.0,
              height: 8,
              color: text_color_light,
            ),
          )
        ],
      ),
    );
  }

  Widget _BuildItemsListView(BuildContext context){
    var items = CartPage.cart_items;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          width: double.infinity,
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              //color: Colors.red
          ),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              //image part
              Expanded(
                flex: 25,
                //image container
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                     //color: Colors.cyan
                  ),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: primary_color_dark, width: 5)
                    ),
                    child: Image(
                      image: NetworkImage(items[index].product.image_url),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              //item description container
              Expanded(
                flex: 60,
                //description and count container
                child: Container(
                  decoration: BoxDecoration(
                    //color: Colors.grey,
                  ),
                  margin: EdgeInsetsDirectional.only(
                    start: 8.0, end: 8.0, top: 6.0, bottom: 6.0,
                  ),
                  padding: EdgeInsetsDirectional.only(
                    start: 16.0, end: 8.0, top: 0.0, bottom: 0.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //item description
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsetsDirectional.only(
                            bottom: 2.0, top: 2.0,
                          ),
                          child: Text(
                            "${items[index].product.name}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(
                          bottom: 2.0, top: 2.0,
                        ),
                        child: Text(
                          "Price: ${items[index].product.price} \$",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(
                          bottom: 2.0, top: 2.0,
                        ),
                        child: Text(
                          "Count: ${items[index].count}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //remove icon container
              Expanded(
                flex: 15,
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsetsDirectional.only(
                    top: 8.0
                  ),
                  decoration: BoxDecoration(
                    //color: Colors.green
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      "assets/icons/cart_trash.svg",
                      color: primary_color,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    iconSize: 32,
                    onPressed: () {
                      _DeleteItemFromCart(index);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
        return null;
      },
    );
  }

  Widget _BuildConfirmOrder(){
    return Container(
      height: 48,
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsetsDirectional.only(
        top: 16.0, bottom: 16.0, start: 32.0, end: 32.0
      ),
      decoration: BoxDecoration(
          color: primary_color,
          border: Border.all(color: text_color_light, width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(40))
      ),
      //color: Colors.black,
      child: FlatButton(
        //color: primary_color,
        onPressed: () {
          print("in cart page confirm order button was pressed");
          _ConfirmOrder().then((value) {
            if(value){
              BotToast.showSimpleNotification(title: "Order Was Confirmed :)");
              setState(() {
                CartPage.cart_items.clear();
              });
            }
            else{
              BotToast.showSimpleNotification(title: "Unexpected Error Happened :(");
            }
          });
        },
        child: Text(
          (CartPage.cart_items.length == 0) ? "No Items In Cart!!".toUpperCase() : "Confirm Order!".toUpperCase(),
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: text_color_dark,
              letterSpacing: 2.0
          ),
        ),
      ),
    );
  }

  void _DeleteItemFromCart(int item_index) {
    setState(() {
      CartPage.cart_items.removeAt(item_index);
    });
  }

  Future<bool> _ConfirmOrder() async{
    bool result;
    if( CartPage.cart_items.length ==0){
      BotToast.showSimpleNotification(title: "There Is No Items يا حيوان");
    }
    else{
      double total_price = 0.00 ;
      CartPage.cart_items.forEach((element) {
        total_price = total_price + element.product.price * element.count;
      });
      await OrderController.PostOneOrdersOfUser(total_price: total_price, cart_items: CartPage.cart_items).then((value){
        result = value;
      });
      return result;
    }
  }
}
