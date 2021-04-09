import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/DioError.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/CartProduct.dart';
import 'package:crafty/Models/Order.dart';
import 'package:crafty/Models/Profile.dart';
import 'package:crafty/Models/ServerOrder.dart';
import 'package:crafty/UI/Activity/Host.dart';
import 'package:crafty/UI/CustomWidgets/CartItems.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:dio/dio.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Result.dart';

BuildContext _context;
ProgressDialog pr;

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Razorpay _razorpay;
  int item = 0;
  var products;
  double price = 0.00;
  ServerOrder order;
  var id;

  Future<ServerOrder> getEveryThing(double price) async {
    UsersModel usersModel = UsersModel();
    print("HEREczccz");
    return await usersModel.getOrder(price);
  }

  var pinT = TextEditingController();
  var phT = TextEditingController();
  var addT = TextEditingController();

  double calculatePriceAndItems(var bihuProducts) {
    setState(() {
      price = 0;
      item = bihuProducts.length;
    });
    if (bihuProducts.isNotEmpty) {
      for (int i = 0; i < bihuProducts.length; i++) {
        setState(() {
          price += double.parse(bihuProducts[i].payment);
          print(price);
        });
      }
    }
    return price;
  }

  get buttonSize => 20.0;

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(
        message: 'Please Wait....',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    super.initState();
    read("cartitems");
    pinT = TextEditingController();
    phT = TextEditingController();
    addT = TextEditingController();
  }

  @override
  void dispose() {
    var json = jsonEncode(Provider.of<CartData>(context, listen: false)
        .list
        .map((e) => e.toJson())
        .toList());
    save("data", json);
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    item = Provider.of<CartData>(context).listLength;
    _context = context;
    return Container(
      child: Provider.of<CartData>(context).listLength == 0
          ? EmptyListWidget(
              title: 'No Items',
              subTitle: 'No Items added to the cart',
              image: 'assets/images/404.png',
              titleTextStyle: Theme.of(context)
                  .typography
                  .dense
                  .headline4
                  .copyWith(color: Color(0xff9da9c7)),
              subtitleTextStyle: Theme.of(context)
                  .typography
                  .dense
                  .bodyText1
                  .copyWith(color: Color(0xffabb8d6)))
          : buildColumn(context),
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
                child: Text(
              "Shopping Cart",
              style: TextStyle(fontSize: 28),
            )),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17.0),
              ),
              child: IconButton(
                iconSize: 40,
                splashRadius: 40,
                onPressed: () {
                  setState(() {
                    Provider.of<CartData>(context, listen: false)
                        .removeAll(0, item);
                    print("Done");
                  });
                },
                enableFeedback: true,
                splashColor: Colors.redAccent,
                icon: Icon(
                  FontAwesomeIcons.trash,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.width / 1.2,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: Provider.of<CartData>(context).listLength,
            itemBuilder: (BuildContext ctxt, int index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (item) {
                  Provider.of<CartData>(context, listen: false)
                      .removeProduct(index);
                },
                child: CartItem(
                  index: index,
                  list: Provider.of<CartData>(context).list,
                  callback: () {
                    Provider.of<CartData>(context, listen: false)
                        .removeProduct(index);
                  },
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 1,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: Colors.grey,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "${Provider.of<CartData>(context).listLength} Items",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            Text(
              "${Provider.of<CartData>(context).getPrice()}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: FlatButton(
            height: MediaQuery.of(context).size.width / 7,
            minWidth: MediaQuery.of(context).size.width,
            splashColor: Colors.white,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(6.0)),
            padding: EdgeInsets.all(8),
            color: Colors.deepOrangeAccent,
            onPressed: () {
              if (checkIfempty(context)) {
                Dialogs.materialDialog(
                    msg: 'Select how do you want to pay?',
                    title: "Payment Mode",
                    color: Colors.white,
                    context: context,
                    actions: [
                      IconsButton(
                        onPressed: () async {
                          UsersModel usersModel = UsersModel();
                          const _chars =
                              'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                          Random _rnd = Random();
                          String getRandomString(int length) =>
                              String.fromCharCodes(Iterable.generate(
                                  length,
                                  (_) => _chars.codeUnitAt(
                                      _rnd.nextInt(_chars.length))));
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Successful",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.black,
                              fontSize: 16.0);

                          var id = "order_cod_" + getRandomString(5);
                          try {
                            var a = await usersModel.saveOrderDatabase(
                                saveToDatabase(
                                    id,
                                    Provider.of<CartData>(_context,
                                                listen: false)
                                            .getPrice() *
                                        100,
                                    "COD",
                                    _context));
                            if (a != null && a != "Unable to save order") {
                              Provider.of<CartData>(context, listen: false)
                                  .removeAll(
                                      0,
                                      Provider.of<CartData>(context,
                                              listen: false)
                                          .listLength);
                              Navigator.pushAndRemoveUntil(
                                  _context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: Result()),
                                  (r) => false);
                              setState(() {
                                Provider.of<CartData>(_context, listen: false)
                                    .RESULT = "assets/raw/successful.json";
                                Provider.of<CartData>(_context, listen: false)
                                    .TXT = id;
                                print("Success");
                              });
                            } else {
                              Navigator.pushAndRemoveUntil(
                                  _context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: Result()),
                                  (r) => false);
                              setState(() {
                                Provider.of<CartData>(_context, listen: false)
                                    .RESULT = "assets/raw/failed.json";
                                Provider.of<CartData>(_context, listen: false)
                                    .TXT = id;
                              });
                            }
                          } on DioError catch (e) {
                            final errorMessage =
                                DioExceptions.fromDioError(e).toString();
                            print(errorMessage);
                          }
                          // var c = usersModel1.saveOrderDatabase()
                          // usersModel1.saveOrderDatabase();
                        },
                        text: 'COD',
                        iconData: FontAwesomeIcons.box,
                        color: Colors.red,
                        textStyle: TextStyle(color: Colors.white),
                        iconColor: Colors.white,
                      ),
                      IconsButton(
                        onPressed: () async {
                          var cx = Provider.of<CartData>(context, listen: false)
                              .razorpay
                              .Key
                              .toString();
                          print("KEY $cx");
                          if (Provider.of<CartData>(context, listen: false)
                                  .razorpay !=
                              null) {
                            Navigator.pop(context);
                            products =
                                Provider.of<CartData>(context, listen: false)
                                    .list;
                            try {
                              id = await getEveryThing(Provider.of<CartData>(
                                          context,
                                          listen: false)
                                      .getPrice())
                                  .then((value) {
                                return value.id;
                              });
                            } catch (e) {
                              print(e);
                            }
                            var size =
                                Provider.of<CartData>(context, listen: false)
                                    .Sizes;
                            var amount =
                                Provider.of<CartData>(context, listen: false)
                                        .getPrice() *
                                    100;
                            var items =
                                Provider.of<CartData>(context, listen: false)
                                    .names;
                            Test.currentCartItems =
                                Provider.of<CartData>(context, listen: false)
                                    .list;
                            print(Test.currentCartItems);
                            print(
                                "DDDDD ${Provider.of<CartData>(context, listen: false).razorpay.Id}");

                            var options = {
                              'key':
                                  Provider.of<CartData>(context, listen: false)
                                      .razorpay
                                      .Id
                                      .toString(),
                              'amount': amount,
                              'order_id': '$id',
                              'name': 'Crafty',
                              'description': items,
                              'external': {
                                'wallets': ['paytm']
                              }
                            };
                            print("INFOM ${id}");
                            try {
                              _razorpay.open(options);
                            } catch (e) {
                              print("VVVV $e");
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Failed Please Log out",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          }
                        },
                        text: 'PAY',
                        iconData: FontAwesomeIcons.dollarSign,
                        color: Colors.green,
                        textStyle: TextStyle(color: Colors.white),
                        iconColor: Colors.white,
                      ),
                    ]);
                //
                // pr.show();

                // Provider.of<CartData>(context, listen: false).removeAll(0, Test.currentCartItems.length);
              } else {
                Fluttertoast.showToast(
                    msg: "First add address,pincode and phone no in profile",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.black,
                    fontSize: 16.0);
                showModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return BottomCard(context);
                    });
              }
            },
            child: Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Card BottomCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Container(
        color: Styles.bg_color,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Enter the required details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: addT,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Styles.log_sign_text),
                  labelText: "Delivery Address",
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: phT,
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Styles.log_sign_text),
                  labelText: "Phone",
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: TextField(
                controller: pinT,
                keyboardType: TextInputType.number,
                maxLength: 6,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Styles.log_sign_text),
                  labelText: "Pincode",
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (addT.text.isNotEmpty &&
                        pinT.text.isNotEmpty &&
                        phT.text.isNotEmpty) {
                      if (pinT.text.length == 6) {
                        if (phT.text.length == 10) {
                          saveDetails(context);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please enter valid phone no",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please enter valid pincode",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.black,
                            fontSize: 16.0);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please enter required fields",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.black,
                          fontSize: 16.0);
                    }
                  },
                  child: Text('Save')),
            )
          ],
        ),
      ),
    );
  }

  void save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  void read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var v = prefs.getString(key);
    print("HER");
    if (v != null) {
      List<CartProduct> list = [];
      for (var i in jsonDecode(v)) {
        list.add(CartProduct.fromJson(i));
      }
      Provider.of<CartData>(context, listen: false).list = list;
      print("Data ${list}");
    }
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  void saveDetails(BuildContext context) async {
    await pr.show();
    UsersModel usersModel = new UsersModel();
    var data = await usersModel.saveProf(Profile(
        Provider.of<CartData>(context, listen: false).profile.id,
        Provider.of<CartData>(context, listen: false).profile.name,
        Provider.of<CartData>(context, listen: false).profile.email,
        addT.text,
        int.parse(phT.text),
        int.parse(pinT.text),
        null));
    print("MOCM ${data.toString()}");
    if (data != null) {
      pr.hide().then((isHidden) {
        print(isHidden);
        Fluttertoast.showToast(
            msg: "Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: 16.0);
        Provider.of<CartData>(context, listen: false)
            .updateProfile(Profile.fromJson(data));
        Navigator.pop(context);
      });
    } else {
      pr.hide().then((isHidden) {
        print(isHidden);
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: 16.0);
      });
    }
  }

  bool checkIfempty(BuildContext context) {
    print(Provider.of<CartData>(context, listen: false).profile.address);
    if (Provider.of<CartData>(context, listen: false).profile != null &&
        Provider.of<CartData>(context, listen: false).profile.address != null &&
        Provider.of<CartData>(context, listen: false).profile.phone != null &&
        Provider.of<CartData>(context, listen: false).profile.pincode != null) {
      return true;
    } else {
      return false;
    }
  }
}

void _handlePaymentSuccess(PaymentSuccessResponse response) async {
  Fluttertoast.showToast(
      msg: "Successful",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.black,
      fontSize: 16.0);
  Navigator.push(
      _context, PageTransition(type: PageTransitionType.fade, child: Result()));
  Map data = {
    'orderId': response.orderId,
    'paymentId': response.paymentId,
    'signature': response.signature,
  };
  var body = json.encode(data);
  print("ADAD");
  UsersModel usersModel = UsersModel();
  var b = await usersModel.saveOrder(body);
  if (b != "Failed to save" && b != "Server Error") {
    if (b["result"].toString() == "Successful") {
      try {
        var a = await usersModel.saveOrderDatabase(saveToDatabase(
            response.orderId,
            Provider.of<CartData>(_context, listen: false).getPrice() * 100,
            response.paymentId,
            _context));
        if (a != null && a != "Unable to save order") {
          Provider.of<CartData>(_context, listen: false).removeAll(
              0, Provider.of<CartData>(_context, listen: false).listLength);
          Navigator.pushAndRemoveUntil(
              _context,
              PageTransition(type: PageTransitionType.fade, child: Result()),
              (r) => false);

          Provider.of<CartData>(_context, listen: false).RESULT =
              "assets/raw/successful.json";
          Provider.of<CartData>(_context, listen: false).TXT =
              response.paymentId;
          print("Success");
        } else {
          Navigator.pushAndRemoveUntil(
              _context,
              PageTransition(type: PageTransitionType.fade, child: Result()),
              (r) => false);
          Provider.of<CartData>(_context, listen: false).RESULT =
              "assets/raw/failed.json";
          Provider.of<CartData>(_context, listen: false).TXT = response.orderId;
        }
      } on DioError catch (e) {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        print(errorMessage);
      }
      // var c = usersModel1.saveOrderDatabase()
      // usersModel1.saveOrderDatabase();
      Provider.of<CartData>(_context, listen: false).RESULT =
          "assets/raw/successful.json";
      Provider.of<CartData>(_context, listen: false).TXT =
          "Payment ID" + response.paymentId;
    } else {
      Provider.of<CartData>(_context, listen: false).RESULT =
          "assets/raw/failed.json";
      Provider.of<CartData>(_context, listen: false).TXT =
          "Payment ID" + response.orderId;
    }
  }
}

void _handlePaymentError(PaymentFailureResponse response) {
  print("ERRROR " + response.message + " " + response.code.toString() + "");
  pr.hide().then((isHidden) {
    print(isHidden);
  });
  print("DDDD");
}

Order saveToDatabase(id, double amount, String status, BuildContext context) {
  // UsersModel usersModel = UsersModel();
  return Order(
      Provider.of<CartData>(context, listen: false).Colours,
      "15-02-21",
      Provider.of<CartData>(context, listen: false).Names,
      Provider.of<CartData>(context, listen: false).user.email,
      status,
      Provider.of<CartData>(context, listen: false).ids,
      Provider.of<CartData>(context, listen: false)
          .Pictures
          .split(",")[0]
          .trim(),
      amount,
      Provider.of<CartData>(context, listen: false).quantity,
      Provider.of<CartData>(context, listen: false).Sizes,
      "Preparing",
      id,
      Provider.of<CartData>(context, listen: false).user.id,
      Provider.of<CartData>(context, listen: false).profile.address,
      Provider.of<CartData>(context, listen: false).profile.phone,
      Provider.of<CartData>(context, listen: false).profile.pincode,
      "NOT AVAILABLE");
}

void _handleExternalWallet(ExternalWalletResponse response) {
  print("My respones is ${response.walletName}");
  Fluttertoast.showToast(
      msg: "Successful ${response}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.black,
      fontSize: 16.0);
}
