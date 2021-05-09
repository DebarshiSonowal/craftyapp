import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
          GestureDetector(
            onTap: () => onTap(context),
            child: UserAccountsDrawerHeader(
              accountName: Provider.of<CartData>(context).user == null
                  ? Text('')
                  : Text("${Provider.of<CartData>(context).user.name}"),
              accountEmail: Provider.of<CartData>(context).user == null
                  ? Text(
                      "Please Login",
                      style: TextStyle(fontSize: 18),
                    )
                  : Text("${Provider.of<CartData>(context).user.email}"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  "${Provider.of<CartData>(context).user == null ? "Login" : Provider.of<CartData>(context).user.name.toString()[0].toUpperCase()}",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
          Provider.of<CartData>(context, listen: true).user == null
              ? ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Login'),
                  onTap: () {
                    _fragNavigate.putPosit(key: 'Login', force: true);
                  },
                )
              : Container(),
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
            onTap: () {
              print(_fragNavigate.currentKey);
              try {
                _fragNavigate.putPosit(key: 'Home', force: true);
              } catch (e) {
                _fragNavigate.jumpBackTo('Home');
                print("hee $e");
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () {
              _fragNavigate.putPosit(key: 'Profile', force: true);
            },
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text('Cart'),
            onTap: () {
              _fragNavigate.putPosit(key: 'Cart', force: true);
            },
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
            onTap: () {
              _fragNavigate.putPosit(key: 'Men', force: true);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.venus),
            title: Text('Women'),
            onTap: () {
              _fragNavigate.putPosit(key: 'Women', force: true);
            },
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
            onTap: () {
              _fragNavigate.putPosit(key: 'WishList');
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.box),
            title: Text('Orders'),
            onTap: () {
              _fragNavigate.putPosit(key: 'Orders');
            },
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
            onTap: () {
              _fragNavigate.putPosit(key: 'Contact Us', force: true);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.info),
            title: Text('About'),
            onTap: () {
              _fragNavigate.putPosit(key: 'About', force: true);
            },
          ),
          Provider.of<CartData>(context, listen: true).user == null
              ? Container()
              : ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () {
                    clearTokens(context);
                  },
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
    Provider.of<CartData>(context, listen: false).removeOrders(
        Provider.of<CartData>(context, listen: false).order.length);
    Provider.of<CartData>(context, listen: false).user = null;
    Provider.of<CartData>(context, listen: false).removeProfile();
    _fragNavigate.putAndClean(key: 'Login', force: true);
  }

  onTap(BuildContext context) {
    if (Provider.of<CartData>(context, listen: false).user == null) {
      _fragNavigate.putAndClean(key: 'Login', force: true);
    }
  }
}
