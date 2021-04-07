import 'dart:async';

import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/DataSearch.dart';
import 'package:crafty/Helper/Navigation.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/Fragments/Cart.dart';
import 'package:crafty/UI/Fragments/Contact_Us.dart';
import 'package:crafty/UI/Fragments/HomePage.dart';
import 'package:crafty/UI/Fragments/Men.dart';
import 'package:crafty/UI/Fragments/Orders.dart';
import 'package:crafty/UI/Fragments/Profile.dart';
import 'package:crafty/UI/Fragments/WishList.dart';
import 'package:crafty/UI/Fragments/Women.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';
class Host extends StatefulWidget {
  @override
  HostState createState() => HostState();
}

class HostState extends State<Host> {
  static int o = 0;
  static var id;
  int _selectedIndex = 0;

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
            onPressed: () => {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop')
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  void sendToProfile(){
    final snackBar = SnackBar(
      content: Text('Please Add your profile'),
      action: SnackBarAction(
        label: 'Go to Profile',
        onPressed: () {
          selectedindex(1);
        },
      ),
    );
    Timer(Duration(seconds: 2), (){
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  show(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Product Added'),
      action: SnackBarAction(
        label: 'Next',
        onPressed: () {
          setState(() {
            selectedindex(2);
          });
        },
      ),
    ));
  }

  void selectedindex(int value) {
    setState(() {
      try {
        _selectedIndex = value;
        Navigator.of(context).pop();
      } catch (e) {
        print(e);
      }
    });
  }

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getFragment(int position) {
    switch (position) {
      case 1:
        return ProfilePage();
      case 2:
        return Cart(this);
      case 3:
        return ContactUs();
      case 4:
        return Orders();
      case 5:
        return MenProducts(this);
      case 6:
        return WomenProducts(this);
      case 7:
        return WishList();
      default:
        return HomePage(this);
    }
  }
  @override
  void initState() {
    super.initState();
    getEverything();
  }
  @override
  Widget build(BuildContext context) {
    return Provider.of<CartData>(context).user == null?Material(
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
    ):WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Crafty"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch(this));
              },
            )
          ],
        ),
        drawer: NavDrawer(this),
        body: getFragment(_selectedIndex),
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
          currentIndex: _selectedIndex > 2 ? 0 : _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
  void getEverything() async {
    print("run");
    UsersModel usersModel = UsersModel();
    UsersModel usersModel1 = UsersModel();
    UsersModel usersModel2 = UsersModel();
    UsersModel usersModel3 = UsersModel();
    var UserData = await usersModel1.getUser();
    if(UserData!="User Not Found"){
      Provider.of<CartData>(context, listen: false)
          .updateUser(UserData);
    }else{
      Dialogs.materialDialog(
          msg: 'Sorry Something is wrong',
          title: "Server Error",
          color: Colors.white,
          context: context,
          actions: [
            IconsButton(
              onPressed: () {
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
    var profile = await usersModel2.getProf( Provider.of<CartData>(context, listen: false).user.id);
    if(profile != "Server Error"&&profile != null){
      Provider.of<CartData>(context, listen: false)
          .updateProfile(profile);
    }

    var order = await usersModel3.getOrdersforUser(Provider.of<CartData>(context, listen: false).user.id);
    if(order != "Server Error"&&order != "Orders  not found"){
      Provider.of<CartData>(context, listen: false)
          .orders(order);
    }

    var Data = await usersModel.getAll();
    List<Products> data=[];
    if(Data.toString()=="Server Error"||Data.toString()=="Products not found"){
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
    }else{
      data = Data;

      List<Products> men = [];
      List<Products> women = [];
      if (data != null) {
        for (var i in data) {
          if (i.Gender == "MALE") {
            men.add(i);
          } else {
            women.add(i);
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
}
