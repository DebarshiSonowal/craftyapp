
import 'package:crafty/UI/Activity/Login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../UI/Activity/Host.dart';
import 'package:provider/provider.dart';

import 'CartData.dart';
import 'Test.dart';

class NavDrawer extends StatelessWidget {
  final HostState parent;

  NavDrawer(this.parent);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Provider.of<CartData>(context).user== null? Text("ashishrawat"):Text("${Provider.of<CartData>(context).user.name}"),
            accountEmail: Provider.of<CartData>(context).user == null? Text("ashishrawat2911@gmail.com"):Text("${Provider.of<CartData>(context).user.email}"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: Text(
                "${Provider.of<CartData>(context).user== null?"Here":Provider.of<CartData>(context).user.name.toString()[0].toUpperCase()}",
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
            onTap: () => {this.parent.selectedindex(0)},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {this.parent.selectedindex(1)},
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text('Cart'),
            onTap: () => {this.parent.selectedindex(2)},
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
            title: Text('Man'),
            onTap: () => {this.parent.selectedindex(5)},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.venus),
            title: Text('Women'),
            onTap: () => {this.parent.selectedindex(6)},
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
            title: Text('WishList'),
            onTap: () => {this.parent.selectedindex(7)},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.box),
            title: Text('Orders'),
            onTap: () => {this.parent.selectedindex(4)},
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
            onTap: () => {
              this.parent.selectedindex(3)},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              clearTokens(context)

            },
          ),
        ],
      ),
    );
  }

  clearTokens(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.clear();
   Test.accessToken=null;
   Test.refreshToken=null;
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade, child: Login()));
  }
}
