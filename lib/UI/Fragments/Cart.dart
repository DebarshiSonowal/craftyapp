import 'dart:convert';
import 'dart:math';

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/DioError.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/Address.dart';
import 'package:crafty/Models/CartProduct.dart';
import 'package:crafty/Models/CashOrder.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

BuildContext _context;
ProgressDialog pr;

class _CartState extends State<Cart> {
  int item = 0;
  var products, id, list;
  double price = 0.00;
  ServerOrder order;
  EmptyListWidget emptyListWidget;
  TextEditingController pinT, phT, addT1, addTtown, addTdis, addTstate;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<ServerOrder> getEveryThing(double price) async {
    UsersModel usersModel = UsersModel();
    return await usersModel.getOrder(price);
  }

  @override
  void initState() {
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
    var json = jsonEncode(list.map((e) => e.toJson()).toList());
    save("data", json);
    pinT.dispose();
    phT.dispose();
    addT1.dispose();
    addTtown.dispose();
    addTdis.dispose();
    addTstate.dispose();
    emptyListWidget = null;
    // order = null;
    // price=null;
    // products=null;
    // item=null;
    // id =null;
    // // _context= null;
    // pr = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    item = Provider.of<CartData>(context).listLength;
    _context = context;
    list = Provider.of<CartData>(_context, listen: false).list;
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      key: _scaffoldKey,
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
                      Duration(seconds: 3), 'Login', Colors.white, () {
                    setState(() {
                      Test.fragNavigate.putPosit(key: 'Login');
                    });
                  });
                }
              },
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

  Order saveToDatabase(
      id, double amount, String status, BuildContext context, String indv) {
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
        "NOT AVAILABLE",
        indv);
  }

  Widget initModel(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Container(
        color: Styles.bg_color,
        height: MediaQuery.of(context).size.height / 3,
        child: checkIfLoggedIn(),
      ),
    );
  }

  withoption(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
            child: Text(
          'Please Select an address:',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
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
            style: ElevatedButton.styleFrom(
              primary: Styles.Log_sign,
            ),
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
            child: Text(
              'Add a new Address',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
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
        Provider.of<CartData>(context, listen: false)
            .profile
            .pincode
            .toString()));
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
                        _context,
                        Provider.of<CartData>(_context, listen: false)
                            .getIndivisualPrice()),
                    Provider.of<CartData>(_context, listen: false).name == null
                        ? Provider.of<CartData>(_context, listen: false)
                            .user
                            .name
                        : Provider.of<CartData>(_context, listen: false).name);
                if (a != null && a != "Unable to save order") {
                  Provider.of<CartData>(context, listen: false)
                      .removeAll(0, CartData.listLengths);
                  setState(() {
                    pr.hide().then((isHidden) async {
                      var a = await usersModel.triggerResponse(
                          id,
                          Provider.of<CartData>(context, listen: false)
                              .profile
                              .email);
                      if (a == "complete") {
                        CartData.RESULT = "assets/raw/successful.json";
                        CartData.TXT = id;
                        Test.fragNavigate.putPosit(key: 'Result');
                      } else {}
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
              var amount =
                  Provider.of<CartData>(context, listen: false).getPrice();
              var items = Provider.of<CartData>(context, listen: false).names;
              Test.currentCartItems =
                  Provider.of<CartData>(context, listen: false).list;
              CashOrder order = getOrder(amount);
              var data = await getTokenData(order);
              order.tokenData = data['body']['cftoken'].toString();
              order.appId = data['id'];
              order.stage = data['status'];
              order.orderNote = items;
              order.notifyUrl =
                  "https://officialcraftybackend.herokuapp.com/users/successfulWebhook";
              order.orderId = order.orderId
                  .toString()
                  .substring(1, order.orderId.toString().length - 1);
              var inputs = order.toMap();
              // inputs.addAll(UIMeta().toMap());
              inputs.putIfAbsent('orderCurrency', () {
                return "INR";
              });
              // inputs.forEach((key, value) {
              //   print("$key : $value");
              // });
              print("the inputs \n ${inputs}");
              CashfreePGSDK.doPayment(inputs).onError((error, stackTrace) {
                print(error);
                return error;
              }).then((value) {
                value?.forEach((key, value) async {
                  print("$key : $value");
                });
                if (value['txStatus'].toString() == "SUCCESS") {
                  initiateSaving(value);
                }
              }).whenComplete(() {
                pr.hide().then((isHidden) {});
              });
            },
            text: 'PAY',
            iconData: FontAwesomeIcons.dollarSign,
            color: Colors.green,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  getTokenData(CashOrder cashOrder) async {
    UsersModel usersModel = new UsersModel();
    return await usersModel.savePayment(cashOrder);
  }

  getOrder(var amount) {
    var order = CashOrder();
    order.customerName =
        Provider.of<CartData>(context, listen: false).user.name;
    order.customerEmail = Provider.of<CartData>(context, listen: false).profile.email;
    order.customerPhone = Provider.of<CartData>(context, listen: false).profile.phone;
    order.orderAmount = 1;
    order.stage = "PROD";
    return order;
  }

  checkIfLoggedIn() {
    if (Provider.of<CartData>(context, listen: false).profile == null) {
      return Container(
        child: Text('Log in first'),
      );
    } else {
      return Provider.of<CartData>(context, listen: false).profile.address !=
              null
          ? withoption(context)
          : withoutoption(context);
    }
  }

  void initiateSaving(dynamic value) async {
    try {
      UsersModel usersModel = UsersModel();
      var a = await usersModel.saveOrderDatabase(
          saveToDatabase(
              value['orderId'],
              Provider.of<CartData>(_scaffoldKey.currentContext, listen: false)
                      .getPrice() *
                  100,
              value['referenceId'],
              _scaffoldKey.currentContext,
              Provider.of<CartData>(_context, listen: false)
                  .getIndivisualPrice()),
          Provider.of<CartData>(_scaffoldKey.currentContext, listen: false)
                      .name ==
                  null
              ? Provider.of<CartData>(_scaffoldKey.currentContext,
                      listen: false)
                  .user
                  .name
              : Provider.of<CartData>(_scaffoldKey.currentContext,
                      listen: false)
                  .name);
      if (a != null && a != "Unable to save order") {
        CartData.removeALL(0, CartData.listLengths);
        CartData.RESULT = "assets/raw/successful.json";
        CartData.TXT = value['referenceId'];
        Test.fragNavigate.putPosit(key: 'Result');
      } else {
        Test.fragNavigate.putPosit(key: 'Result');
        CartData.RESULT = "assets/raw/failed.json";
        CartData.TXT = value['orderId'];
        Test.fragNavigate.putPosit(key: 'Result');
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print(errorMessage);
    }
  }
}
