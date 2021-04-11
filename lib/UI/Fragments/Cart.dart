import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/DioError.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/CartProduct.dart';
import 'package:crafty/Models/Order.dart';
import 'package:crafty/Models/ServerOrder.dart';
import 'package:crafty/UI/Activity/Payment.dart';
import 'package:crafty/UI/CustomWidgets/BottomCard.dart';
import 'package:crafty/UI/CustomWidgets/CartItems.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:dio/dio.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  EmptyListWidget emptyListWidget;
  var pinT = TextEditingController();
  var phT = TextEditingController();
  var addT = TextEditingController();

  get buttonSize => 20.0;

  Future<ServerOrder> getEveryThing(double price) async {
    UsersModel usersModel = UsersModel();
    print("HEREczccz");
    return await usersModel.getOrder(price);
  }

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

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    read("cartitems");
    pinT = TextEditingController();
    phT = TextEditingController();
    addT = TextEditingController();
    new Future.delayed(Duration.zero, () {
      _context = context;
      pr = ProgressDialog(context,
          type: ProgressDialogType.Normal,
          isDismissible: false,
          showLogs: true);
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
              color: Colors.black,
              fontSize: 19.0,
              fontWeight: FontWeight.w600));
      setState(() {
        emptyListWidget = EmptyListWidget(
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
                .copyWith(color: Color(0xffabb8d6)));
      });
      print("Done");
    });
    print("C");
    super.initState();
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
          ? emptyListWidget
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
              if (Test.accessToken != null && Test.refreshToken != null) {
                if (checkIfempty(context)) {
                  Dialogs.materialDialog(
                      msg: 'Select how do you want to pay?',
                      title: "Payment Mode",
                      color: Colors.white,
                      context: context,
                      actions: [
                        IconsButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            await pr.show();
                            UsersModel usersModel = UsersModel();
                            const _chars =
                                'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                            Random _rnd = Random();
                            String getRandomString(int length) =>
                                String.fromCharCodes(Iterable.generate(
                                    length,
                                    (_) => _chars.codeUnitAt(
                                        _rnd.nextInt(_chars.length))));

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
                                    .removeAll(0, CartData.listLengths);
                                setState(() {
                                  pr.hide().then((isHidden) {
                                    CartData.RESULT =
                                        "assets/raw/successful.json";
                                    CartData.TXT = id;
                                    print("Success");
                                    Test.fragNavigate.putPosit(key: 'Result');
                                  });
                                });
                              } else {
                                pr.hide().then((isHidden) {
                                  CartData.RESULT = "assets/raw/failed.json";
                                  CartData.TXT = id;
                                  Test.fragNavigate.putPosit(key: 'Result');
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
                            Navigator.pop(context);
                            await pr.show();
                            var cx =
                                Provider.of<CartData>(context, listen: false)
                                    .razorpay
                                    .Key
                                    .toString();
                            print("KEY $cx");
                            if (Provider.of<CartData>(context, listen: false)
                                    .razorpay !=
                                null) {

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
                                'key': Provider.of<CartData>(context,
                                        listen: false)
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
                        return BottomCard(addT, phT, pinT);
                      });
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Please Login first'),
                  action: SnackBarAction(
                    label: 'Next',
                    onPressed: () {
                      setState(() {
                        print("GG ${Test.fragNavigate}");
                        Test.fragNavigate.putPosit(key: 'Login');
                      });
                    },
                  ),
                ));
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

  saveit(dynamic response) async {}

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
      print("je ${_context.widget}");
      try {
        UsersModel usersModel = UsersModel();
        var a = await usersModel.saveOrderDatabase(saveToDatabase(
            response.orderId,
            Provider.of<CartData>(_context, listen: false).getPrice() * 100,
            response.paymentId,
            _context));
        if (a != null && a != "Unable to save order") {
          CartData.removeALL(0, CartData.listLengths);
          CartData.RESULT = "assets/raw/successful.json";
          CartData.TXT = response.paymentId;
          print("Success");
          Test.fragNavigate.putPosit(key: 'Result');
        } else {
          Test.fragNavigate.putPosit(key: 'Result');
          CartData.RESULT = "assets/raw/failed.json";
          CartData.TXT = response.orderId;
          Test.fragNavigate.putPosit(key: 'Result');
        }
      } on DioError catch (e) {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        print(errorMessage);
      }
      // var c = usersModel1.saveOrderDatabase()
      // usersModel1.saveOrderDatabase();
      pr.hide().then((isHidden) {
        CartData.RESULT = "assets/raw/successful.json";
        CartData.TXT = "Payment ID" + response.paymentId;
        Test.fragNavigate.putPosit(key: 'Result');
      });
    } else {
      pr.hide().then((isHidden) {
        CartData.RESULT = "assets/raw/failed.json";
        CartData.TXT = "Payment ID" + response.orderId;
        Test.fragNavigate.putPosit(key: 'Result');
      });
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
