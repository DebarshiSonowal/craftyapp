import 'dart:collection';
import 'dart:convert';
import 'package:crafty/Models/Ads.dart';
import 'package:crafty/Models/CartProduct.dart';
import 'package:crafty/Models/Categories.dart';
import 'package:crafty/Models/Order.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/Models/Profile.dart';
import 'package:crafty/Models/Razorpay.dart';
import 'package:crafty/Models/User.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartData extends ChangeNotifier {
  static List<CartProduct> _list = [];
  User _user = null;
  Profile _profile = null;
  List<Order> _order = [];
  List<Products> _allproducts = [];
  List<Products> _men = [];
  List<Products> _women = [];
  static String RESULT = "assets/raw/loading.json", TXT = "Please Wait";
  Razorpay _razorpay = null;
  List<Categories> _categ = [];
  List<Ads> _ads = [];

//Set
  void setCategory(List<Categories> list) {
    _categ = list;
    notifyListeners();
  }

  void setRazorpay(Razorpay razorpay) {
    _razorpay = razorpay;
    print("RAzor ${_razorpay.Key}");
    notifyListeners();
  }

  void setAds(List<Ads> ads) {
    _ads = ads;
    notifyListeners();
  }

  void setAllProduct(List<Products> product) {
    _allproducts = product;
    print(product.length);
    notifyListeners();
  }

  void setMen(List<Products> product) {
    _men = product;
  }

  void setWomen(List<Products> product) {
    _women = product;
  }

  void orders(List<Order> value) {
    _order = value;
    print(value);
  }

  void updateProfile(Profile profile) {
    _profile = profile;
    Styles.showWarningToast(Colors.green, "Profile Updated", Colors.white, 15);
    notifyListeners();
  }

  void removeProfile(){
    _profile = null;
    notifyListeners();
  }
  void removeOrders(int len){
    _order.removeRange(0, len);
    notifyListeners();
  }

  void updateUser(User user) {
    print(user.name);
    _user = user;
    notifyListeners();
  }

  set list(List<CartProduct> value) {
    _list = value;
    notifyListeners();
  }

  void Update(List<CartProduct> List) {
    _list = List;
    notifyListeners();
  }

  void addProduct(CartProduct cartProduct) {
    _list.add(cartProduct);
    print(cartProduct.quantity);
    Styles.showWarningToast(Colors.green, "Item added", Colors.white, 15);
    saveInfo();
    notifyListeners();
  }

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  static void saveInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("data", listString);
    print("DOne");
  }

//Get
  List<Products> get allproducts => _allproducts;

  Profile get profile => _profile;

  User get user {
    return _user;
  }

  Razorpay get razorpay => _razorpay;

  List<Ads> getAds() {
    return List<Ads>.unmodifiable(_ads);
  }

  List<String> getAdImage() {
    List<String> list = [];
    for (var i in getAds()) {
      list.add(i.picture);
    }
    print("Size ${list.length}");
    return list;
  }

  List<Categories> getCateg() {
    return List<Categories>.unmodifiable(_categ);
  }

  List<Order> get order => List<Order>.unmodifiable(_order);

  List<CartProduct> get list {
    return List<CartProduct>.unmodifiable(_list);
  }

  static String get listString {
    List<Map<String, dynamic>> jsonData =
        _list.map((word) => word.toJson()).toList();
    return jsonEncode(jsonData);
  }

  String get ids {
    List<String> a = [];
    for (var b in _list) {
      a.add("${b.UID}");
    }
    return a.join(",");
  }

  String get names {
    var a = "";
    for (var b in list) {
      a += b.name;
    }
    return a;
  }

  UnmodifiableListView<CartProduct> get listview {
    return UnmodifiableListView(_list);
  }

  static int get listLengths {
    return _list.length;
  }

  int get listLength {
    return _list.length;
  }

  double getPrice() {
    double price = 0;
    for (int i = 0; i < _list.length; i++) {
      price += double.parse(_list[i].payment.toString()) * _list[i].quantity;
    }
    return price;
  }

  String get Colours {
    List<String> col = [];
    for (var i in _list) {
      print(i.color.toString());
      col.add(i.color.toString().trim());
    }
    return col.join(",");
  }

  String get Pictures {
    List<String> col = [];
    for (var i in _list) {
      col.add(i.picture);
    }
    return col.join(",");
  }

  String get Sizes {
    List<String> col = [];
    for (var i in _list) {
      col.add(i.size);
    }
    return col.join(",");
  }

  String get Names {
    List<String> col = [];
    for (var i in _list) {
      col.add(i.name);
    }
    return col.join(",");
  }

  List<int> get Quantity {
    List<int> col = [];
    for (var i in _list) {
      col.add(i.quantity);
    }
    return col;
  }

  String get quantity {
    List<String> col = [];
    for (var i in _list) {
      col.add(i.quantity.toString());
    }
    return col.join(",");
  }

  List<Products> get men => _men;

  List<Products> get women => _women;

  //Remove
  static void removeALL(int first, int second) {
    _list.removeRange(first, second);
    saveInfo();
  }

  void removeAll(int first, int second) {
    _list.removeRange(first, second);
    saveInfo();
    notifyListeners();
  }

  void removeProduct(int index) {
    _list.removeAt(index);
    notifyListeners();
  }
}
