import 'dart:async';

import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/DataSearch.dart';
import 'package:crafty/Helper/Navigation.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/CustomWidgets/Photoview.dart';
import 'package:crafty/UI/Fragments/About.dart';
import 'package:crafty/UI/Fragments/AllProducts.dart';
import 'package:crafty/UI/Fragments/Cart.dart';
import 'package:crafty/UI/Fragments/Contact_Us.dart';
import 'package:crafty/UI/Fragments/HomePage.dart';
import 'package:crafty/UI/Fragments/Login.dart';
import 'package:crafty/UI/Fragments/Men.dart';
import 'package:crafty/UI/Fragments/Orders.dart';
import 'package:crafty/UI/Fragments/Profile.dart';
import 'package:crafty/UI/Fragments/Result.dart';
import 'package:crafty/UI/Fragments/Signup.dart';
import 'package:crafty/UI/Fragments/SpecialAds.dart';
import 'package:crafty/UI/Fragments/WishList.dart';
import 'package:crafty/UI/Fragments/Women.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:fragment_navigate/navigate-support.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Host extends StatefulWidget {
  @override
  HostState createState() => HostState();
}

class HostState extends State<Host> {
  static int o = 0;
  static var id;
  static var bottom;
  static FragNavigate _fragNav;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    _fragNav = FragNavigate(
      firstKey: 'Home',
      drawerContext: null,
      screens: getList(),
    );
    new Future.delayed(Duration.zero, () {
      _fragNav.setDrawerContext = context;
      getEverything(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    _fragNav.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      Test.fragNavigate = _fragNav;
      _fragNav.setDrawerContext = context;
    } catch (e) {
      print("pROBLEM $e");
    }
    return Provider.of<CartData>(context).user == null
        ? Material(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitRing(
                  color: Colors.black,
                  size: 100.0,
                ),
                Text(
                  "Please Wait",
                  style: TextStyle(
                    fontFamily: "EBGaramond",
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        : WillPopScope(
            onWillPop: _onWillPop,
            child: StreamBuilder<FullPosit>(
                stream: _fragNav.outStreamFragment,
                builder: (con, s) {
                  if (s.data != null) {
                    return Scaffold(
                      key: _fragNav.drawerKey,
                      appBar: AppBar(
                        title: Text(s.data.title),
                        actions: [
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              showSearch(
                                  context: context,
                                  delegate: DataSearch(_fragNav));
                            },
                          )
                        ],
                        bottom: s.data.bottom.child,
                      ),
                      drawer: NavDrawer(_fragNav),
                      bottomNavigationBar: BottomNavigationBar(
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            label: 'Home',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.verified_user),
                            label: 'Profile',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.add_shopping_cart),
                            label: 'Cart',
                          ),
                        ],
                        currentIndex: _fragNav.screenList.keys
                                    .toList()
                                    .indexOf(_fragNav.currentKey) >
                                2
                            ? 0
                            : _fragNav.screenList.keys
                                .toList()
                                .indexOf(_fragNav.currentKey),
                        selectedItemColor: Colors.black,
                        backgroundColor: Colors.white70,
                        onTap: (index) {
                          setState(() {
                            bottom = index;
                            var b = _fragNav.screenList.keys.toList();
                            var c = _fragNav.actionsList;
                            if (c != null) {
                              _fragNav.putAndReplace(key: b[index]);
                            } else {
                              initialize();
                              try {
                                _fragNav.putAndReplace(key: b[index]);
                              } catch (e) {
                                print("GGOt $e");
                              }
                            }
                          });
                        },
                      ),
                      body: DefaultTabController(
                        length: s.data.bottom.length,
                        child: ScreenNavigate(
                            child: s.data.fragment, bloc: _fragNav),
                      ),
                    );
                  }

                  return Container();
                }),
          );
  }

  void getEverything(BuildContext context) async {
    print("ccc");
    UsersModel usersModel = UsersModel();
    UsersModel usersModel1 = UsersModel();
    UsersModel usersModel2 = UsersModel();
    UsersModel usersModel3 = UsersModel();
    var UserData = await usersModel1.getUser();
    if (UserData != "User Not Found") {
      print("CC");
      Provider.of<CartData>(context, listen: false).updateUser(UserData);
    } else {
      print("CC1");
      Dialogs.materialDialog(
          msg: 'Sorry Something is wrong',
          title: "Server Error",
          color: Colors.white,
          context: context,
          actions: [
            IconsButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Test.accessToken = null;
                Test.refreshToken = null;
                Provider.of<CartData>(context, listen: false).removeOrders(
                    Provider.of<CartData>(context, listen: false).order.length);
                Provider.of<CartData>(context, listen: false).removeProfile();
                Navigator.pop(context);
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              text: 'Accepted',
              iconData: Icons.delete,
              color: Colors.red,
              textStyle: TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
          ]);
    }
    var profile = await usersModel2
        .getProf(Provider.of<CartData>(context, listen: false).user.id);
    if (profile != "Server Error" && profile != null) {
      Provider.of<CartData>(context, listen: false).updateProfile(profile);
    }
    var order = await usersModel3.getOrdersforUser(
        Provider.of<CartData>(context, listen: false).user.id);
    if (order != "Server Error" && order != "Orders  not found") {
      print("GOR ORDER");
      Provider.of<CartData>(context, listen: false).orders(order);
    }
    var Data = await usersModel.getAll();
    List<Products> data = [];
    if (Data.toString() == "Server Error" ||
        Data.toString() == "Products not found") {
      Dialogs.materialDialog(
          msg: 'Sorry Something is wrong',
          title: "Server Error",
          color: Colors.white,
          context: context,
          actions: [
            IconsButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'Accepted',
              iconData: Icons.delete,
              color: Colors.red,
              textStyle: TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
          ]);
    } else {
      data = Data;
      List<Products> men = [];
      List<Products> women = [];
      if (data != null) {
        for (var i in data) {
          if (i.Gender == "MALE") {
            men.add(i);
            print("MEN $i");
          } else {
            women.add(i);
            print("WOMEN $i");
          }
        }
        setState(() {
          Provider.of<CartData>(context, listen: false).setAllProduct(data);
          Provider.of<CartData>(context, listen: false).setMen(men);
          Provider.of<CartData>(context, listen: false).setWomen(women);
        });
      } else {
        print("empty");
      }
      o = 4;
    }
  }

  getList() {
    return <Posit>[
      Posit(
          key: 'Home',
          title: 'Home',
          fragment: Container(
            color: Styles.bg_color,
            child: HomePage(Test.fragNavigate),
          ),
          icon: Icons.add),
      Posit(
          key: 'Profile',
          title: 'Profile',
          fragment: ProfilePage(),
          icon: Icons.accessibility),
      Posit(key: 'Cart', title: 'Cart', fragment: Cart(), icon: Icons.ac_unit),
      Posit(
          key: 'Men', title: 'Men', fragment: MenProducts(), icon: Icons.code),
      Posit(
          key: 'Women',
          title: 'Women',
          fragment: WomenProducts(),
          icon: Icons.code),
      Posit(
          key: 'WishList',
          title: 'Wishlist',
          fragment: WishList(),
          icon: Icons.code),
      Posit(
          key: 'Orders', title: 'Orders', fragment: Orders(), icon: Icons.code),
      Posit(
          key: 'Contact Us',
          title: 'Contact Us',
          fragment: ContactUs(),
          icon: Icons.code),
      Posit(key: 'About', title: 'About', fragment: About(), icon: Icons.code),
      Posit(
          key: 'Login',
          title: 'Login',
          fragment: Login(_fragNav),
          icon: Icons.code),
      Posit(
          key: 'Signup', title: 'Signup', fragment: Signup(), icon: Icons.code),
      Posit(
          key: 'Result', title: 'Crafty', fragment: Result(), icon: Icons.code),
      Posit(
          key: 'photo',
          title: 'Crafty',
          fragment: Photoview(Test.url),
          icon: Icons.code),
      Posit(
          key: 'All',
          title: 'All Products',
          icon: Icons.code,
          fragment: AllProducts()),
      Posit(
          key: 'Special',
          title: Provider.of<CartData>(context, listen: false).specialTxt==null?'Special':Provider.of<CartData>(context, listen: false).specialTxt,
          icon: Icons.code,
          fragment: SpecialAds(
          )),
    ];
  }

  void initialize() {
    _fragNav = FragNavigate(
      firstKey: 'Home',
      drawerContext: null,
      screens: getList(),
    );
    Test.fragNavigate = _fragNav;
    _fragNav.setDrawerContext = context;
  }
}
