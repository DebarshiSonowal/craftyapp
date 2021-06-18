import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Models/CartProduct.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Test {
  static var bihu;

  static GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  static String url;

  static String specialTag=null;

  static saveKeys() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access', Test.accessToken);
    await prefs.setString('refresh', Test.refreshToken);
  }
//Auth
  static Future<String> access() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('access');
  }

  static Future<String> refresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('refresh');
  }

  static String accessToken, refreshToken;
  var message;
  static var fragNavigate;

  static List<Products> special = null;

  static List<CartProduct> cart = null;

  static List<Products> products = null;

  static List<Products> Men = null;

  static addToCart(CartProduct cartProduct) {
    cart.add(cartProduct);
    print(cartProduct);
  }
  static getAllProducts(BuildContext context) async{
    UsersModel usersModel = UsersModel();
    var Data = await usersModel.getAll();
    if (Data.toString() != "Server Error" ||
        Data.toString() != "Products not found") {
      List<Products> data = Data;
      if (data != null) {
        Provider.of<CartData>(context, listen: false)
            .setAllProduct(data);
        addData(data,context);
      }
    }
  }
  static addData(List<Products> data,BuildContext context) {
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
        Provider.of<CartData>(context, listen: false).setMen(men);
        Provider.of<CartData>(context, listen: false).setWomen(women);
    } else {
      print("empty");
    }
  }

  static List<String> currentIds = [];

  static List<CartProduct> currentCartItems = [];

  static get() {
    for (var i in currentCartItems) {
      currentIds.add(i.UID.toString());
    }
    return currentIds;
  }
}
