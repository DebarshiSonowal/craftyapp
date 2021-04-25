import 'dart:convert';
import 'dart:math';

import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/DioError.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/Address.dart';
import 'package:crafty/Models/CartProduct.dart';
import 'package:crafty/Models/Order.dart';
import 'package:crafty/Models/Profile.dart';
import 'package:crafty/Models/ServerOrder.dart';
import 'package:crafty/UI/CustomWidgets/AddressOption.dart';
import 'package:crafty/UI/CustomWidgets/BottomCard.dart';
import 'package:crafty/UI/CustomWidgets/CartScreen.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:dio/dio.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

BuildContext _context;
ProgressDialog pr;

class _CartState extends State<Cart> {
  Razorpay _razorpay;
  int item = 0;
  var products, id;
  double price = 0.00;
  ServerOrder order;
  EmptyListWidget emptyListWidget;
  TextEditingController pinT, phT, addT1, addTtown, addTdis, addTstate;

  Future<ServerOrder> getEveryThing(double price) async {
    UsersModel usersModel = UsersModel();
    return await usersModel.getOrder(price);
  }

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    pinT = TextEditingController();
    phT = TextEditingController();
    addT1 = TextEditingController();
    addTtown = TextEditingController();
    addTdis = TextEditingController();
    addTstate = TextEditingController();
    read("data");
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
    });
    super.initState();
  }

  @override
  void dispose() {
    var json = jsonEncode(Provider.of<CartData>(context, listen: false)
        .list
        .map((e) => e.toJson())
        .toList());
    save("data", json);
    pinT.dispose();
    phT.dispose();
    addT1.dispose();
    addTtown.dispose();
    addTdis.dispose();
    addTstate.dispose();
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
          : CartScreenn(
              item: item,
              save: save,
              onOrderInit: () {
                if (Provider.of<CartData>(context, listen: false).user !=
                    null) {
                  showModalBottomSheet(
                      context: context,
                      isDismissible: true,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return initModel(context);
                      });
                } else {
                  Styles.showSnackBar(context, Colors.yellow,
                      Duration(seconds: 3), 'Next', Colors.white, () {
                    setState(() {
                      Test.fragNavigate.putPosit(key: 'Login');
                    });
                  });
                }
              },
            ),
    );
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Styles.showWarningToast(Colors.green, "Successful", Colors.white, 15);
    Map data = {
      'orderId': response.orderId,
      'paymentId': response.paymentId,
      'signature': response.signature,
    };
    var body = json.encode(data);
    UsersModel usersModel = UsersModel();
    var b = await usersModel.saveOrder(body);
    if (b != "Failed to save" && b != "Server Error") {
      if (b["result"].toString() == "Successful") {
        try {
          UsersModel usersModel = UsersModel();
          var a = await usersModel.saveOrderDatabase(
              saveToDatabase(
                  response.orderId,
                  Provider.of<CartData>(_context, listen: false).getPrice() *
                      100,
                  response.paymentId,
                  _context),
              Provider.of<CartData>(_context, listen: false).name == null
                  ? Provider.of<CartData>(_context, listen: false).user.name
                  : Provider.of<CartData>(_context, listen: false).name);
          if (a != null && a != "Unable to save order") {
            CartData.removeALL(0, CartData.listLengths);
            CartData.RESULT = "assets/raw/successful.json";
            CartData.TXT = response.paymentId;
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

  _handlePaymentError(PaymentFailureResponse response) {
    pr.hide().then((isHidden) {
      Styles.showWarningToast(Colors.red, response.message, Colors.white, 15);
    });
  }

  _handleExternalWallet(ExternalWalletResponse response) {
    Styles.showWarningToast(
        Colors.green, "Successful ${response}", Colors.white, 15);
  }

  void save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  void read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var v = prefs.getString(key);
    if (v != null) {
      List<CartProduct> list = [];
      for (var i in jsonDecode(v)) {
        list.add(CartProduct.fromJson(i));
      }
      Provider.of<CartData>(context, listen: false).list = list;
    }
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  bool checkIfempty(BuildContext context) {
    if (Provider.of<CartData>(context, listen: false).user != null) {
      return true;
    } else {
      return false;
    }
  }

  Order saveToDatabase(id, double amount, String status, BuildContext context) {
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
        Provider.of<CartData>(context, listen: false).getAddress.address,
        Provider.of<CartData>(context, listen: false).getAddress.phone,
        Provider.of<CartData>(context, listen: false).getAddress.pin,
        "NOT AVAILABLE");
  }

  Widget initModel(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Container(
        height: MediaQuery.of(context).size.height / 4,
        child: Provider.of<CartData>(context, listen: false).profile.address !=
                null
            ? withoption(context)
            : withoutoption(context),
      ),
    );
  }

  withoption(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
            child: Text(
          'Please Select a address:',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )),
        Provider.of<CartData>(context, listen: false).user != null
            ? GestureDetector(
                onTap: () => defaultAddress(),
                child: AddressOption(
                    Provider.of<CartData>(context, listen: false).user.name,
                    Provider.of<CartData>(context, listen: false)
                        .profile
                        .phone
                        .toString(),
                    Provider.of<CartData>(context, listen: false)
                        .profile
                        .address
                        .toString(),
                    Provider.of<CartData>(context, listen: false)
                        .profile
                        .pincode
                        .toString()),
              )
            : Container(),
        Center(
            child: Text(
          'OR',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              showModalBottomSheet(
                  context: context,
                  isDismissible: true,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return BottomCard(
                        addT1, addTtown, addTdis, addTstate, phT, pinT, () {
                      if (addT1.text.isNotEmpty &&
                          addTtown.text.isNotEmpty &&
                          addTdis.text.isNotEmpty &&
                          addTstate.text.isNotEmpty &&
                          pinT.text.isNotEmpty &&
                          phT.text.isNotEmpty) {
                        if (pinT.text.length == 6) {
                          if (phT.text.length == 10) {
                            Provider.of<CartData>(context, listen: false)
                                .address = getAddress();
                            Provider.of<CartData>(context, listen: false)
                                .setAddress(Address(getAddress(),
                                    phT.text.toString(), pinT.text.toString()));
                            Navigator.pop(context);
                            showPaymentDialog();
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
                    });
                  });
            },
            child: Text('Add a new Address')),
      ],
    );
  }

  withoutoption(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              showModalBottomSheet(
                  context: context,
                  isDismissible: true,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return BottomCard(
                        addT1, addTtown, addTdis, addTstate, phT, pinT, () {
                      if (addT1.text.isNotEmpty &&
                          addTtown.text.isNotEmpty &&
                          addTdis.text.isNotEmpty &&
                          addTstate.text.isNotEmpty &&
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
                    });
                  });
            },
            child: Text('Add a new Address')),
      ],
    );
  }

  defaultAddress() {
    Provider.of<CartData>(context, listen: false).setAddress(Address(
        Provider.of<CartData>(context, listen: false).profile.address,
        Provider.of<CartData>(context, listen: false).profile.phone.toString(),
        Provider.of<CartData>(context, listen: false).profile.pincode.toString()));
    Navigator.pop(context);
    showPaymentDialog();
  }

  void saveDetails(BuildContext context) async {
    await pr.show();
    UsersModel usersModel = new UsersModel();
    var data = await usersModel.saveProf(Profile(
        Provider.of<CartData>(context, listen: false).profile.id,
        Provider.of<CartData>(context, listen: false).profile.name,
        Provider.of<CartData>(context, listen: false).profile.email,
        getAddress(),
        int.parse(phT.text),
        int.parse(pinT.text),
        null));
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

  String getAddress() {
    return addT1.text.trim() +
        "," +
        addTtown.text.trim() +
        "," +
        addTdis.text.trim() +
        "," +
        addTstate.text.trim();
  }

  void showPaymentDialog() {
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
                  String.fromCharCodes(Iterable.generate(length,
                      (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
              Styles.showWarningToast(
                  Colors.green, "Successful", Colors.white, 15);

              var id = "order_cod_" + getRandomString(5);
              try {
                var a = await usersModel.saveOrderDatabase(
                    saveToDatabase(
                        id,
                        Provider.of<CartData>(_context, listen: false)
                                .getPrice() *
                            100,
                        "COD",
                        _context),
                    Provider.of<CartData>(_context, listen: false).name == null
                        ? Provider.of<CartData>(_context, listen: false)
                            .user
                            .name
                        : Provider.of<CartData>(_context, listen: false).name);
                if (a != null && a != "Unable to save order") {
                  Provider.of<CartData>(context, listen: false)
                      .removeAll(0, CartData.listLengths);
                  setState(() {
                    pr.hide().then((isHidden) {
                      CartData.RESULT = "assets/raw/successful.json";
                      CartData.TXT = id;
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
                final errorMessage = DioExceptions.fromDioError(e).toString();
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
              var cx = Provider.of<CartData>(context, listen: false)
                  .razorpay
                  .Key
                  .toString();
              if (Provider.of<CartData>(context, listen: false).razorpay !=
                  null) {
                products = Provider.of<CartData>(context, listen: false).list;
                try {
                  id = await getEveryThing(
                          Provider.of<CartData>(context, listen: false)
                              .getPrice())
                      .then((value) {
                    return value.id;
                  });
                } catch (e) {
                  print(e);
                }
                var size = Provider.of<CartData>(context, listen: false).Sizes;
                var amount =
                    Provider.of<CartData>(context, listen: false).getPrice() *
                        100;
                var items = Provider.of<CartData>(context, listen: false).names;
                Test.currentCartItems =
                    Provider.of<CartData>(context, listen: false).list;

                var options = {
                  'key': Provider.of<CartData>(context, listen: false)
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
                try {
                  _razorpay.open(options);
                } catch (e) {
                  print("VVVV $e");
                }
              } else {
                Styles.showWarningToast(
                    Colors.red, "Failed Please Log out", Colors.white, 15);
              }
            },
            text: 'PAY',
            iconData: FontAwesomeIcons.dollarSign,
            color: Colors.green,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }
}
