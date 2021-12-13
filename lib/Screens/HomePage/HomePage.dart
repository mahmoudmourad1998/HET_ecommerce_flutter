import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter01/Controller/CategoryController.dart';
import 'package:flutter01/Controller/ProductController.dart';
import 'package:flutter01/Controller/UserController.dart';
import 'package:flutter01/Model/Category.dart';
import 'package:flutter01/Model/Product.dart';
import 'package:flutter01/Screens/CartPage/CartPage.dart';
import 'package:flutter01/Screens/LoginPage/LoginPage.dart';
import 'package:flutter01/Screens/MapsPage/MapsPage.dart';
import 'package:flutter01/Screens/OrdersPage/OrdersPage.dart';
import 'package:flutter01/Screens/ProductPage/ProductPage.dart';
import 'package:flutter01/Screens/ProfilePage/ProfilePage.dart';
import 'package:flutter01/src/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static var selected_index_categories_list_view = 0;
  static var _selected_index_bottom_nav_bar = 0;
  var my_categories = <Category>[];
  var my_products = <Product>[];
  bool show_loading_status = null;

  @override
  void initState(){
    print("Home Page Was Intialized");
    _GetCategories();
    print ("my categories length: ${my_categories.length}");
    show_loading_status = true;
    _GetProducts(selected_index_categories_list_view + 1);
    print ("my products length: ${my_products.length}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var drawer_context;
    List<Widget> tabs = <Widget>[_BuildingHomeBody(context), CartPage(), OrdersPage(), ProfilePage()];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary_color_light,
          iconTheme: IconThemeData(color: text_color_light),
          title: Text(
            "Mega Store",
            style: TextStyle(
              color: text_color_dark,
              letterSpacing: 5.0, fontWeight: FontWeight.w900),
          ),
          centerTitle: true,
          //menu icon to open drawer
          leading: Builder(
            builder: (context) {
              return IconButton(
                  icon: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    height: 36,
                    width: 36,
                    child: SvgPicture.asset('assets/icons/menu.svg', color: text_color_light),
                  ),
                  onPressed: () {
                    setState(() {
                      drawer_context = context;
                    });
                    return Scaffold.of(context).openDrawer();
                  }
              );
            }),
          actions: <Widget>[
            //cart icon app bar
            IconButton(
              icon: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                height: 36,
                width: 36,
                child: SvgPicture.asset('assets/icons/shopping_cart.svg', color: text_color_light),
              ),
              iconSize: 36,
              padding: EdgeInsets.all(0.0),
              onPressed: (){
                print("cart icon was pressed");
              },
            ),
            //search icon app bar
            IconButton(
              icon: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                height: 36,
                width: 36,
                child: SvgPicture.asset('assets/icons/search.svg', color: text_color_light),
              ),
              iconSize: 36,
              padding: EdgeInsets.all(0.0),
              onPressed: (){
                print("search icon was pressed");
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsetsDirectional.only(
              top: MediaQuery.of(context).size.height * 0.75
            ),
            children: [
              ListTile(
                title: Text(
                  'LogOut',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  //'ميت السلامه يا فقير ....',
                  "bye bye :)",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: (){
                  print("log out button was pressed");
                  _LoggingUserOut().then((value) {
                    if(value){
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage())
                      );
                    }
                  });
                },
              ),
              ListTile(
                contentPadding: EdgeInsetsDirectional.only(
                  top: 16.0,
                  start: 16.0
                ),
                title: Text(
                  'Open Maps',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  //'ما في خرايط خيو الدوره الجايه يا حب',
                  "",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: (){
                  //Scaffold.of(drawer_context).openDrawer();
                  //
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MapsPage())
                  );
                },
              ),

            ],
          ),
        ),
        //page container and scroll view as a scrollable page
        body: tabs[_selected_index_bottom_nav_bar],
        bottomNavigationBar: _BuildingBottomNavBar(context),
      ),
    );
  }

  Widget _BuildingHomeBody(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: secondary_color_light,
      child: Column(
        children: [
          //categories title
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                //color: Colors.black,
                margin: EdgeInsetsDirectional.only(top: 16.0, bottom: 0.0, start: 8.0, end: 0.0),
                child: Text(
                  "Categories",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          //categories list view
          Container(
            //color: Colors.red,
            margin: EdgeInsets.only(top: 8.0, bottom: 0.0, right: 0.0, left: 0.0),
            height: 32,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              itemCount: my_categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selected_index_categories_list_view = index;
                      show_loading_status = true;
                      _GetProducts(index + 1);
                      // Future.delayed(
                      //   Duration(seconds: 1),
                      //   (){
                      //     _GetProducts(index + 1);
                      //   }
                      // );
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          //color: Colors.purple,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                              top: 0.0, bottom: 0.0, right: 8.0, left: 8.0),
                          child: Text(
                            my_categories[index].title,
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: (selected_index_categories_list_view == index)
                                  ? primary_color_dark
                                  : secondary_color_dark,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 4,
                        width: 100.0,
                        alignment: Alignment.center,
                        color: (selected_index_categories_list_view == index)
                            ? Colors.black
                            : Colors.transparent,
                        margin: const EdgeInsets.only(
                            top: 28.0, bottom: 0.0, right: 8.0, left: 8.0),
                      ),
                    ],
                  ),
                );
                return null;
              },
            ),
          ),
          //products grid view
          Expanded(
            child: Container(
              //color: Colors.red,
              padding: EdgeInsetsDirectional.only(start: 12.0, end: 12.0, top: 12.0, bottom: 8.0),
              child: (show_loading_status)
                  ? ModalProgressHUD(
                child: Container(),
                inAsyncCall: show_loading_status,
                opacity: 1.0,
                color: Colors.transparent,
                progressIndicator: CircularProgressIndicator(
                  backgroundColor: primary_color_dark,
                  valueColor: AlwaysStoppedAnimation<Color>(primary_color_light),
                ),
                dismissible: false,
              )
                  : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 2.0,
                  ),
                  itemCount: my_products.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        print("you pressed on a product");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context){
                                  return ProductPage(my_product: my_products[index],);
                                }
                            )
                        );
                      },
                      //item container in the grid view
                      child: Container(
                        //color: Colors.deepOrangeAccent,
                        margin: const EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                            top: 0.0, bottom: 0.0),
                        padding: const EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                            top: 4.0, bottom: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                margin: const EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                                    top: 2.0, bottom: 2.0),
                                padding: const EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                                    top: 16.0, bottom: 16.0),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    color: background_color_light,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: background_color_dark, width: 4.0)
                                ),
                                child: Hero(
                                  tag: my_products[index].id,
                                  child: Image(
                                    image: NetworkImage(my_products[index].image_url),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            //item name container
                            Container(
                              //color: Colors.yellow,
                              height: 24,
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                                  top: 2.0, bottom: 2.0),
                              padding: const EdgeInsetsDirectional.only(start: 8.0, end: 8.0,
                                  top: 2.0, bottom: 2.0),
                              child: Text(
                                my_products[index].name,
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                maxLines: 1,
                              ),
                            ),
                            //item price container
                            Container(
                              //color: Colors.brown,
                              height: 24,
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsetsDirectional.only(start: 0.0, end: 0.0,
                                  top: 2.0, bottom: 2.0),
                              padding: const EdgeInsetsDirectional.only(start: 8.0, end: 8.0,
                                  top: 2.0, bottom: 2.0),
                              child: Text(
                                "${my_products[index].price.toString()} \$",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _BuildingBottomNavBar(BuildContext context){
    return BottomNavigationBar(
      currentIndex: _selected_index_bottom_nav_bar,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      iconSize: 32,
      backgroundColor: background_color_dark,
      selectedItemColor: primary_color_dark,
      unselectedItemColor: text_color_dark,
      selectedFontSize: 15.0,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w700
      ),
      unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500
      ),
      unselectedFontSize: 13.0,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: "Home",
          icon: SvgPicture.asset(
            'assets/icons/home.svg',
            color: background_color_light,
            height: 24,
            width: 24,
          ),
        ),
        BottomNavigationBarItem(
          label: "Cart",
          icon: SvgPicture.asset(
            'assets/icons/all_products.svg',
            color: background_color_light,
            height: 24,
            width: 24,
          ),
        ),
        BottomNavigationBarItem(
          label: "Orders",
          icon: SvgPicture.asset(
            'assets/icons/delivery_orders.svg',
            color: background_color_light,
            height: 24,
            width: 24,
          ),
        ),
        BottomNavigationBarItem(
          label: "Profile",
          icon: SvgPicture.asset(
            'assets/icons/profile.svg',
            color: background_color_light,
            height: 24,
            width: 24,
          ),
        ),
      ],
      onTap: (index){
        setState(() {
          _selected_index_bottom_nav_bar = index;
        });
      },
    );
  }

  void _GetProducts(int id) async{
    await ProductController.GetAllProductsWithCategory(category_id: id)
      .then((result){
        setState(() {
          my_products = result;
          show_loading_status = false;
        });
    });
  }

  void _GetCategories() async{
    await CategoryController.GetAllCategories()
        .then((result){
      setState(() {
        my_categories = result;
      });
    });
  }

  Future<bool> _LoggingUserOut() async{
    bool result;
    await UserController.LogOutUser().then((value) {result = value;});
    print("logout is done");
    SharedPreferences shared_prefs = await SharedPreferences.getInstance();
    await shared_prefs.clear();
    print("clearing shared preferences is done");
    return result;
  }
}
