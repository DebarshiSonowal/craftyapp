import 'package:crafty/Models/CartProduct.dart';
import 'package:crafty/Models/Categories.dart';
import 'package:crafty/Models/Products.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Test {
  static var bihu;

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

//Lists
  static List<Categories> list = [
    Categories(
        "Men",
        "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",
        "_tag"),
    Categories(
        "Women",
        "https://www.wpexplorer.com/wp-content/uploads/wordpress-image-optimization-guide.jpg",
        "tag"),
    Categories(
        "Products",
        "https://cdn.arstechnica.net/wp-content/uploads/2016/02/5718897981_10faa45ac3_b-640x624.jpg",
        "ADa")
  ];

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
