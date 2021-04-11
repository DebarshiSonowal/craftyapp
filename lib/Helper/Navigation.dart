import 'package:crafty/UI/Activity/Login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../UI/Activity/Host.dart';
import 'package:provider/provider.dart';

import 'CartData.dart';
import 'Test.dart';

class NavDrawer extends StatelessWidget {
  final FragNavigate _fragNavigate;

  NavDrawer(this._fragNavigate);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Provider.of<CartData>(context).user == null
                ? Text("ashishrawat")
                : Text("${Provider.of<CartData>(context).user.name}"),
            accountEmail: Provider.of<CartData>(context).user == null
                ? Text("ashishrawat2911@gmail.com")
                : Text("${Provider.of<CartData>(context).user.email}"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: Text(
                "${Provider.of<CartData>(context).user == null ? "Here" : Provider.of<CartData>(context).user.name.toString()[0].toUpperCase()}",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Navigate",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: (){
              print(_fragNavigate.currentKey);
              try {
                _fragNavigate.putAndReplace(key: 'Home', force: true);
              } catch (e) {
                _fragNavigate.jumpBackTo('Home');
                print("hee $e");
              }},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: (){ _fragNavigate.putAndReplace(key: 'Profile', force: true);},
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text('Cart'),
            onTap: (){_fragNavigate.putAndReplace(key: 'Cart', force: true);},
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.mars),
            title: Text('Men'),
            onTap: (){_fragNavigate.putAndReplace(key: 'Men', force: true);},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.venus),
            title: Text('Women'),
            onTap: (){_fragNavigate.putAndReplace(key: 'Women', force: true);},
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Options",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.list),
            title: Text('Wishlist'),
            onTap: (){_fragNavigate.putAndReplace(key: 'WishList');},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.box),
            title: Text('Orders'),
            onTap: (){_fragNavigate.putAndReplace(key: 'Orders');},
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Contact",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.headphones),
            title: Text('Contact Us'),
            onTap: ()
                {_fragNavigate.putAndReplace(key: 'Contact Us', force: true);},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.info),
            title: Text('About'),
            onTap: (){
              _fragNavigate.putAndReplace(key: 'About', force: true);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: (){clearTokens(context);},
          ),
        ],
      ),
    );
  }

  clearTokens(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Test.accessToken = null;
    Test.refreshToken = null;
    print("D");
    _fragNavigate.putAndReplace(key: 'Login', force: true);
  }
}
