import 'package:crafty/Models/CartProduct.dart';
import 'package:crafty/Models/Categories.dart';
import 'package:crafty/Models/Products.dart';
import 'package:fragment_navigate/navigate-bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Test {
  static var bihu;

  static String url;


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



  static List<String> currentIds = [];

  static List<CartProduct> currentCartItems = [];

  static get() {
    for (var i in currentCartItems) {
      currentIds.add(i.UID.toString());
    }
    return currentIds;
  }
}
