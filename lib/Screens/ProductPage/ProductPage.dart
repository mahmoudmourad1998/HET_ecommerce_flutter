

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter01/Model/Product.dart';
import 'package:flutter01/Screens/CartPage/CartItem.dart';
import 'package:flutter01/Screens/CartPage/CartPage.dart';
import 'package:flutter01/src/Constants.dart';
import 'package:flutter_svg/svg.dart';

class ProductPage extends StatefulWidget {
  final Product my_product;
  const ProductPage({Key key, this.my_product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Product the_product;
  int _item_count = 1;
  @override
  void initState() {
    the_product = widget.my_product;
    print(the_product.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: background_color_light,
          elevation: 0.0,
          leading: Builder(
              builder: (context) {
                return IconButton(
                    icon: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      alignment: Alignment.center,
                      height: 36,
                      width: 36,
                      child: SvgPicture.asset('assets/icons/back_arrow.svg', color: text_color_light),
                    ),
                    onPressed: () {
                      return Navigator.pop(context);
                    }
                );
              }
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: background_color_light,
          child: Stack(
            children: [
              //upper container
              Container(
                height: MediaQuery.of(context).size.height * 0.50,
                width: double.infinity,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  //color: Colors.red,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
                  border: Border.all(color: Colors.transparent, width: 4.0),
                ),
                margin: EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                    top:0.0, bottom: 0.0),
                padding: EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                    top: 10.0, bottom: 0.0),
                //product image container
                child: FractionallySizedBox(
                  widthFactor: 0.70,
                  heightFactor: 0.70,
                  alignment: Alignment.center,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                        top:0.0, bottom: 0.0),
                    padding: EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                        top: 0.0, bottom: 0.0),
                    decoration: BoxDecoration(
                      //color: Colors.yellow,
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      border: Border.all(color: secondary_color_dark, width: 4.0),
                    ),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Image(
                        image: NetworkImage(the_product.image_url),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              //lower container
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
                    border: Border.all(color: Colors.transparent, width: 4.0),
                ),
                margin: EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                    top: MediaQuery.of(context).size.height * 0.40, bottom: 0.0),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      flex: 16,
                      //price and stock container
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin: EdgeInsetsDirectional.only(start: 4.0, end: 4.0,
                            top: 4.0, bottom: 0.0),
                        padding: EdgeInsetsDirectional.only(start: 8.0, end: 8.0,
                            top: 0.0, bottom: 0.0),
                        decoration: BoxDecoration(
                          //color: Colors.red
                          border: Border.all(color: background_color_dark, width: 4.0),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            //price container
                            Expanded(
                              flex: 50,
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                                    top: 0.0, bottom: 0.0),
                                padding: EdgeInsetsDirectional.only(start: 12.0, end: 0.0,
                                    top: 0.0, bottom: 0.0),
                                decoration: BoxDecoration(
                                  //color: Colors.yellow
                                  //border: Border.all(color: background_color_dark, width: 4.0),
                                  //borderRadius: BorderRadius.all(Radius.circular(40))
                                ),
                                child: Text(
                                  "Price: ${the_product.price} \$",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                            //stock container
                            Expanded(
                              flex: 50,
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                alignment: Alignment.centerRight,
                                margin: EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                                    top: 0.0, bottom: 0.0),
                                padding: EdgeInsetsDirectional.only(start: 0.0, end: 12.0,
                                    top: 0.0, bottom: 0.0),
                                decoration: BoxDecoration(
                                    //color: Colors.greenAccent
                                ),
                                child: Text(
                                  "Stock : ${the_product.stock} PCS",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 40,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsetsDirectional.only(start: 12.0, end: 12.0,
                            top: 8.0, bottom: 8.0),
                        decoration: BoxDecoration(
                            //color: Colors.yellow
                        ),
                        child: Text(
                          "${the_product.description}",
                          maxLines: 5,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 18,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          //color: Colors.blue
                        ),
                        child: BuildItemNumberAndReview(context),
                      ),
                    ),
                    Expanded(
                      flex: 22,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          //color: Colors.purple
                        ),
                        child: BuildAddToCart(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget BuildItemNumberAndReview(BuildContext context){
    return Flex(
      direction: Axis.horizontal,
      children: [
        //item counter container
        Expanded(
          flex: 50,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            //color: Colors.purple,
            alignment: Alignment.centerLeft,
            margin: EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                top: 0.0, bottom: 0.0),
            padding: EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                top: 0.0, bottom: 0.0),
            child: Row(
              children: [
                //minus container
                Container(
                  width: 48,
                  height: 32,
                  margin: EdgeInsetsDirectional.only(
                    start: 8.0,
                    end: 8.0,
                    top: 0.0,
                    bottom: 0.0,
                  ),
                  padding: EdgeInsetsDirectional.only(
                    start: 0.0,
                    end: 0.0,
                    top: 0.0,
                    bottom: 0.0,
                  ),
                  child: OutlineButton(
                    padding: EdgeInsetsDirectional.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: (){
                      print("you pressed on substract");
                      setState(() {
                        if(_item_count >= 2){
                          _item_count = _item_count - 1;
                        }
                      });
                    },
                    child: Icon(Icons.remove),
                  ),
                ),
                //number container
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                    //color: Colors.yellow,
                    margin: EdgeInsetsDirectional.only(start: 2.0, end: 2.0,
                        top: 0.0, bottom: 0.0),
                    padding: EdgeInsetsDirectional.only(start: 8.0, end: 8.0,
                        top: 8.0, bottom: 8.0),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                          top: 0.0, bottom: 0.0),
                      padding: EdgeInsetsDirectional.only(start: 2.0, end: 2.0,
                          top: 2.0, bottom: 2.0),
                      decoration: BoxDecoration(
                        //color: Colors.deepOrange,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          _item_count.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20.0
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //plus container
                Container(
                  width: 48,
                  height: 32,
                  margin: EdgeInsetsDirectional.only(
                    start: 8.0,
                    end: 8.0,
                    top: 0.0,
                    bottom: 0.0,
                  ),
                  padding: EdgeInsetsDirectional.only(
                    start: 0.0,
                    end: 0.0,
                    top: 0.0,
                    bottom: 0.0,
                  ),
                  child: OutlineButton(
                    padding: EdgeInsetsDirectional.only(
                      start: 0.0,
                      end: 0.0,
                      top: 0.0,
                      bottom: 0.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide.none
                    ),
                    onPressed: (){
                      print("you pressed on add");
                      setState(() {
                        if(_item_count <= widget.my_product.stock - 1){
                          _item_count = _item_count + 1;
                        }
                      });
                    },
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
        ),
        //review Container
        Expanded(
          flex: 50,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            //color: Colors.greenAccent,
            alignment: Alignment.centerRight,
            margin: EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                top: 0.0, bottom: 0.0),
            padding: EdgeInsetsDirectional.only(start: 24.0, end: 8.0,
                top: 8.0, bottom: 8.0),
            decoration: BoxDecoration(
              //color: Colors.greenAccent,
            ),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                  top: 0.0, bottom: 0.0),
              padding: EdgeInsetsDirectional.only(start: 8.0, end: 8.0,
                  top: 8.0, bottom: 8.0),
              decoration: BoxDecoration(
                //color: Colors.yellow,
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: Text(
                "${the_product.review} / 5.0",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900
                ),
                maxLines: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget BuildAddToCart(BuildContext context){
    return Flex(
      direction: Axis.horizontal,
      children: [
        //add to cart icon
        Expanded(
          flex: 25,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsetsDirectional.only(
              start: 32.0, end: 8.0, top: 4.0, bottom: 4.0,
            ),
            decoration: BoxDecoration(
              //color: Colors.yellow,
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/add_to_cart.svg",
                color: primary_color,
                height: double.infinity,
                width: double.infinity,
              ),
              iconSize: 64,
              onPressed: () {},
            ),
          ),
        ),
        //ad to cart button big container
        Expanded(
          flex: 75,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsetsDirectional.only(
              start: 8.0, end: 32.0, top: 12.0, bottom: 12.0,
            ),
            decoration: BoxDecoration(
              //color: Colors.red,
            ),
            //flat button container
            child: Container(
              height: 48,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primary_color,
                border: Border.all(color: text_color_light, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(40))
              ),
              //color: Colors.black,
              child: FlatButton(
                //color: primary_color,
                onPressed: () {
                  print("add to cart was pressed");
                  _AddProductToCart(widget.my_product, _item_count);
                },
                child: Text(
                  "Buy  Now".toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: text_color_dark,
                    letterSpacing: 2.0
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _AddProductToCart(Product the_product, int count){
    CartPage.cart_items.add(new CartItem(product: the_product, count: count));
  }
}
