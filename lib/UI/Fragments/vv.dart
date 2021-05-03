// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'package:crafty/Helper/CartData.dart';
// import 'package:crafty/Helper/DioError.dart';
// import 'package:crafty/Helper/Test.dart';
// import 'package:crafty/Models/CartProduct.dart';
// import 'package:crafty/Models/Order.dart';
// import 'package:crafty/Models/ServerOrder.dart';
// import 'package:crafty/UI/CustomWidgets/AddressOption.dart';
// import 'package:crafty/UI/CustomWidgets/BottomCard.dart';
// import 'package:crafty/UI/CustomWidgets/CartItems.dart';
// import 'package:crafty/UI/Styling/Styles.dart';
// import 'package:crafty/Utility/Users.dart';
// import 'package:dio/dio.dart';
// import 'package:empty_widget/empty_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:material_dialogs/material_dialogs.dart';
// import 'package:material_dialogs/widgets/buttons/icon_button.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:provider/provider.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// BuildContext _context;
// ProgressDialog pr;
//
// class Cart extends StatefulWidget {
//   @override
//   _CartState createState() => _CartState();
// }
//
// class _CartState extends State<Cart> {
//   Razorpay _razorpay;
//   int item = 0;
//   var products;
//   double price = 0.00;
//   ServerOrder order;
//   var id;
//   EmptyListWidget emptyListWidget;
//   var pinT = TextEditingController();
//   var phT = TextEditingController();
//   var addT1 = TextEditingController();
//   var addTtown = TextEditingController();
//   var addTdis = TextEditingController();
//   var addTstate = TextEditingController();
//
//   get buttonSize => 20.0;
//
//   Future<ServerOrder> getEveryThing(double price) async {
//     UsersModel usersModel = UsersModel();
//     return await usersModel.getOrder(price);
//   }
//
//   double calculatePriceAndItems(var bihuProducts) {
//     setState(() {
//       price = 0;
//       item = bihuProducts.length;
//     });
//     if (bihuProducts.isNotEmpty) {
//       for (int i = 0; i < bihuProducts.length; i++) {
//         setState(() {
//           price += double.parse(bihuProducts[i].payment);
//         });
//       }
//     }
//     return price;
//   }
//
//   @override
//   void initState() {
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//     read("data");
//     pinT = TextEditingController();
//     phT = TextEditingController();
//     addT1 = TextEditingController();
//     addTtown = TextEditingController();
//     addTdis = TextEditingController();
//     addTstate = TextEditingController();
//     new Future.delayed(Duration.zero, () {
//       _context = context;
//       pr = ProgressDialog(context,
//           type: ProgressDialogType.Normal,
//           isDismissible: false,
//           showLogs: true);
//       pr.style(
//           message: 'Please Wait....',
//           borderRadius: 10.0,
//           backgroundColor: Colors.white,
//           progressWidget: CircularProgressIndicator(),
//           elevation: 10.0,
//           insetAnimCurve: Curves.easeInOut,
//           progress: 0.0,
//           maxProgress: 100.0,
//           progressTextStyle: TextStyle(
//               color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
//           messageTextStyle: TextStyle(
//               color: Colors.black,
//               fontSize: 19.0,
//               fontWeight: FontWeight.w600));
//       setState(() {
//         emptyListWidget = EmptyListWidget(
//             title: 'No Items',
//             subTitle: 'No Items added to the cart',
//             image: 'assets/images/404.png',
//             titleTextStyle: Theme.of(context)
//                 .typography
//                 .dense
//                 .headline4
//                 .copyWith(color: Color(0xff9da9c7)),
//             subtitleTextStyle: Theme.of(context)
//                 .typography
//                 .dense
//                 .bodyText1
//                 .copyWith(color: Color(0xffabb8d6)));
//       });
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     var json = jsonEncode(Provider.of<CartData>(context, listen: false)
//         .list
//         .map((e) => e.toJson())
//         .toList());
//     save("data", json);
//     print("LISt $json");
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     item = Provider.of<CartData>(context).listLength;
//     _context = context;
//     return Container(
//       child: Provider.of<CartData>(context).listLength == 0
//           ? emptyListWidget
//           : buildColumn(context),
//     );
//   }
//
//   Column buildColumn(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Flexible(
//                 child: Text(
//                   "Shopping Cart",
//                   style: TextStyle(fontSize: 25),
//                 )),
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(17.0),
//               ),
//               child: IconButton(
//                 iconSize: 30,
//                 splashRadius: 30,
//                 onPressed: () {
//                   setState(() {
//                     Provider.of<CartData>(context, listen: false)
//                         .removeAll(0, item);
//                     Styles.showWarningToast(
//                         Styles.Log_sign, "All items removed", Colors.black, 15);
//                   });
//                 },
//                 enableFeedback: true,
//                 splashColor: Colors.redAccent,
//                 icon: Icon(
//                   FontAwesomeIcons.trash,
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.all(4.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Want to add more?',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold),
//               ),
//               IconButton(
//                   icon: Icon(
//                     FontAwesomeIcons.plus,
//                     color: Colors.red,
//                   ),
//                   onPressed: () {
//                     Test.fragNavigate.putPosit(key: 'Home', force: true);
//                   })
//             ],
//           ),
//         ),
//         Container(
//           height: MediaQuery.of(context).size.width / 1.2,
//           child: ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             itemCount: Provider.of<CartData>(context).listLength,
//             itemBuilder: (BuildContext ctxt, int index) {
//               return Dismissible(
//                 key: UniqueKey(),
//                 onDismissed: (item) {
//                   Styles.showWarningToast(
//                       Styles.Log_sign, "Item removed", Colors.black, 15);
//                   setState(() {
//                     Provider.of<CartData>(context, listen: false)
//                         .removeProduct(index);
//                     var json = jsonEncode(
//                         Provider.of<CartData>(context, listen: false)
//                             .list
//                             .map((e) => e.toJson())
//                             .toList());
//                     save("data", json);
//                   });
//                 },
//                 child: CartItem(
//                   index: index,
//                   list: Provider.of<CartData>(context).list,
//                   callback: () {
//                     Styles.showWarningToast(
//                         Styles.Log_sign, "Item removed", Colors.black, 15);
//                     setState(() {
//                       Provider.of<CartData>(context, listen: false)
//                           .removeProduct(index);
//                       var json = jsonEncode(
//                           Provider.of<CartData>(context, listen: false)
//                               .list
//                               .map((e) => e.toJson())
//                               .toList());
//                       save("data", json);
//                     });
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SizedBox(
//             height: 1,
//             width: MediaQuery.of(context).size.width,
//             child: Container(
//               color: Colors.grey,
//             ),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text(
//               "${Provider.of<CartData>(context).listLength} Items",
//               style: TextStyle(color: Colors.grey, fontSize: 18),
//             ),
//             Text(
//               "${Provider.of<CartData>(context).getPrice()}",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 19,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: FlatButton(
//             height: MediaQuery.of(context).size.width / 7,
//             minWidth: MediaQuery.of(context).size.width,
//             splashColor: Colors.white,
//             shape: new RoundedRectangleBorder(
//                 borderRadius: new BorderRadius.circular(6.0)),
//             padding: EdgeInsets.all(8),
//             color: Colors.deepOrangeAccent,
//             onPressed: () {
//               initPayment();
//               // showModalBottomSheet(
//               //   context: context,
//               //   isDismissible: true,
//               //   isScrollControlled: true,
//               //   builder: (BuildContext context){
//               //     return Card(
//               //       shape: RoundedRectangleBorder(
//               //           borderRadius: BorderRadius.only(
//               //               topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//               //       child: Container(
//               //         height: MediaQuery.of(context).size.width/2,
//               //         child: Column(
//               //           children: [
//               //             Text('')
//               //           ],
//               //         ),
//               //       ),
//               //     );
//               //   }
//               // ).whenComplete(() => initPayment());
//             },
//             child: Text(
//               "Next",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   void save(String key, value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(key, value);
//   }
//
//   void read(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     var v = prefs.getString(key);
//     if (v != null) {
//       List<CartProduct> list = [];
//       for (var i in jsonDecode(v)) {
//         list.add(CartProduct.fromJson(i));
//       }
//       Provider.of<CartData>(context, listen: false).list = list;
//     }
//   }
//
//   remove(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(key);
//   }
//
//   bool checkIfempty(BuildContext context) {
//     if (Provider.of<CartData>(context, listen: false).user != null) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   void initPayment() {
//     if (Test.accessToken != null && Test.refreshToken != null) {
//       showModalBottomSheet(
//           context: context,
//           isDismissible: true,
//           isScrollControlled: true,
//           builder: (BuildContext context) {
//             return Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20))),
//               child: Container(
//                 height: MediaQuery.of(context).size.height / 2,
//                 child: Column(
//                   children: [
//                     Provider.of<CartData>(_context, listen: false).user != null
//                         ? GestureDetector(
//                       onTap: ()=>defaultAddress(),
//                       child: AddressOption(
//                           Provider.of<CartData>(_context, listen: false)
//                               .user
//                               .name,
//                           Provider.of<CartData>(_context, listen: false)
//                               .profile
//                               .phone
//                               .toString(),
//                           Provider.of<CartData>(_context, listen: false)
//                               .profile
//                               .address
//                               .toString(),
//                           Provider.of<CartData>(_context, listen: false)
//                               .profile
//                               .pincode
//                               .toString()),
//                     )
//                         : Container(),
//                     ElevatedButton(
//                         onPressed: () {
//                           showModalBottomSheet(
//                               context: context,
//                               isDismissible: true,
//                               isScrollControlled: true,
//                               builder: (BuildContext context) {
//                                 return BottomCard(addT1, addTtown, addTdis, addTstate, phT, pinT);
//                               });
//                         }, child: Text('Add a new Address')),
//                   ],
//                 ),
//               ),
//             );
//           });
//       if (checkIfempty(context)) {
//         Dialogs.materialDialog(
//             msg: 'Select how do you want to pay?',
//             title: "Payment Mode",
//             color: Colors.white,
//             context: context,
//             actions: [
//               IconsButton(
//                 onPressed: () async {
//                   Navigator.pop(context);
//                   await pr.show();
//                   UsersModel usersModel = UsersModel();
//                   const _chars =
//                       'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
//                   Random _rnd = Random();
//                   String getRandomString(int length) =>
//                       String.fromCharCodes(Iterable.generate(
//                           length,
//                               (_) =>
//                               _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
//                   Styles.showWarningToast(
//                       Colors.green, "Successful", Colors.white, 15);
//
//                   var id = "order_cod_" + getRandomString(5);
//                   try {
//                     var a = await usersModel.saveOrderDatabase(
//                         saveToDatabase(
//                             id,
//                             Provider.of<CartData>(_context, listen: false)
//                                 .getPrice() *
//                                 100,
//                             "COD",
//                             _context),
//                         Provider.of<CartData>(_context, listen: false).name ==
//                             null
//                             ? Provider.of<CartData>(_context, listen: false)
//                             .user
//                             .name
//                             : Provider.of<CartData>(_context, listen: false)
//                             .name);
//                     if (a != null && a != "Unable to save order") {
//                       Provider.of<CartData>(context, listen: false)
//                           .removeAll(0, CartData.listLengths);
//                       setState(() {
//                         pr.hide().then((isHidden) {
//                           CartData.RESULT = "assets/raw/successful.json";
//                           CartData.TXT = id;
//                           Test.fragNavigate.putPosit(key: 'Result');
//                         });
//                       });
//                     } else {
//                       pr.hide().then((isHidden) {
//                         CartData.RESULT = "assets/raw/failed.json";
//                         CartData.TXT = id;
//                         Test.fragNavigate.putPosit(key: 'Result');
//                       });
//                     }
//                   } on DioError catch (e) {
//                     final errorMessage =
//                     DioExceptions.fromDioError(e).toString();
//                     print(errorMessage);
//                   }
//                   // var c = usersModel1.saveOrderDatabase()
//                   // usersModel1.saveOrderDatabase();
//                 },
//                 text: 'COD',
//                 iconData: FontAwesomeIcons.box,
//                 color: Colors.red,
//                 textStyle: TextStyle(color: Colors.white),
//                 iconColor: Colors.white,
//               ),
//               IconsButton(
//                 onPressed: () async {
//                   Navigator.pop(context);
//                   await pr.show();
//                   var cx = Provider.of<CartData>(context, listen: false)
//                       .razorpay
//                       .Key
//                       .toString();
//                   if (Provider.of<CartData>(context, listen: false).razorpay !=
//                       null) {
//                     products =
//                         Provider.of<CartData>(context, listen: false).list;
//                     try {
//                       id = await getEveryThing(
//                           Provider.of<CartData>(context, listen: false)
//                               .getPrice())
//                           .then((value) {
//                         return value.id;
//                       });
//                     } catch (e) {
//                       print(e);
//                     }
//                     var size =
//                         Provider.of<CartData>(context, listen: false).Sizes;
//                     var amount = Provider.of<CartData>(context, listen: false)
//                         .getPrice() *
//                         100;
//                     var items =
//                         Provider.of<CartData>(context, listen: false).names;
//                     Test.currentCartItems =
//                         Provider.of<CartData>(context, listen: false).list;
//
//                     var options = {
//                       'key': Provider.of<CartData>(context, listen: false)
//                           .razorpay
//                           .Id
//                           .toString(),
//                       'amount': amount,
//                       'order_id': '$id',
//                       'name': 'Crafty',
//                       'description': items,
//                       'external': {
//                         'wallets': ['paytm']
//                       }
//                     };
//                     try {
//                       _razorpay.open(options);
//                     } catch (e) {
//                       print("VVVV $e");
//                     }
//                   } else {
//                     Styles.showWarningToast(
//                         Colors.red, "Failed Please Log out", Colors.white, 15);
//                   }
//                 },
//                 text: 'PAY',
//                 iconData: FontAwesomeIcons.dollarSign,
//                 color: Colors.green,
//                 textStyle: TextStyle(color: Colors.white),
//                 iconColor: Colors.white,
//               ),
//             ]);
//         //
//         // pr.show();
//
//         // Provider.of<CartData>(context, listen: false).removeAll(0, Test.currentCartItems.length);
//       } else {
//         Styles.showWarningToast(
//             Styles.Log_sign,
//             "First add address,pincode and phone no in profile",
//             Colors.white,
//             15);
//         showModalBottomSheet(
//             context: context,
//             isDismissible: true,
//             isScrollControlled: true,
//             builder: (BuildContext context) {
//               return BottomCard(addT1, addTtown, addTdis, addTstate, phT, pinT);
//             });
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Please Login first'),
//         action: SnackBarAction(
//           label: 'Next',
//           onPressed: () {
//             setState(() {
//               print("GG ${Test.fragNavigate}");
//               Test.fragNavigate.putPosit(key: 'Login');
//             });
//           },
//         ),
//       ));
//     }
//   }
//
//   defaultAddress() {
//
//   }
// }
//
// void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//   Styles.showWarningToast(Colors.green, "Successful", Colors.white, 15);
//   Map data = {
//     'orderId': response.orderId,
//     'paymentId': response.paymentId,
//     'signature': response.signature,
//   };
//   var body = json.encode(data);
//   UsersModel usersModel = UsersModel();
//   var b = await usersModel.saveOrder(body);
//   if (b != "Failed to save" && b != "Server Error") {
//     if (b["result"].toString() == "Successful") {
//       try {
//         UsersModel usersModel = UsersModel();
//         var a = await usersModel.saveOrderDatabase(
//             saveToDatabase(
//                 response.orderId,
//                 Provider.of<CartData>(_context, listen: false).getPrice() * 100,
//                 response.paymentId,
//                 _context),
//             Provider.of<CartData>(_context, listen: false).name == null
//                 ? Provider.of<CartData>(_context, listen: false).user.name
//                 : Provider.of<CartData>(_context, listen: false).name);
//         if (a != null && a != "Unable to save order") {
//           CartData.removeALL(0, CartData.listLengths);
//           CartData.RESULT = "assets/raw/successful.json";
//           CartData.TXT = response.paymentId;
//           print("Success");
//           Test.fragNavigate.putPosit(key: 'Result');
//         } else {
//           Test.fragNavigate.putPosit(key: 'Result');
//           CartData.RESULT = "assets/raw/failed.json";
//           CartData.TXT = response.orderId;
//           Test.fragNavigate.putPosit(key: 'Result');
//         }
//       } on DioError catch (e) {
//         final errorMessage = DioExceptions.fromDioError(e).toString();
//         print(errorMessage);
//       }
//       // var c = usersModel1.saveOrderDatabase()
//       // usersModel1.saveOrderDatabase();
//       pr.hide().then((isHidden) {
//         CartData.RESULT = "assets/raw/successful.json";
//         CartData.TXT = "Payment ID" + response.paymentId;
//         Test.fragNavigate.putPosit(key: 'Result');
//       });
//     } else {
//       pr.hide().then((isHidden) {
//         CartData.RESULT = "assets/raw/failed.json";
//         CartData.TXT = "Payment ID" + response.orderId;
//         Test.fragNavigate.putPosit(key: 'Result');
//       });
//     }
//   }
// }
//
// void _handlePaymentError(PaymentFailureResponse response) {
//   pr.hide().then((isHidden) {
//     Styles.showWarningToast(Colors.red, response.message, Colors.white, 15);
//   });
// }
//
// Order saveToDatabase(id, double amount, String status, BuildContext context) {
//   // UsersModel usersModel = UsersModel();
//   return Order(
//       Provider.of<CartData>(context, listen: false).Colours,
//       "15-02-21",
//       Provider.of<CartData>(context, listen: false).Names,
//       Provider.of<CartData>(context, listen: false).user.email,
//       status,
//       Provider.of<CartData>(context, listen: false).ids,
//       Provider.of<CartData>(context, listen: false)
//           .Pictures
//           .split(",")[0]
//           .trim(),
//       amount,
//       Provider.of<CartData>(context, listen: false).quantity,
//       Provider.of<CartData>(context, listen: false).Sizes,
//       "Preparing",
//       id,
//       Provider.of<CartData>(context, listen: false).user.id,
//       Provider.of<CartData>(context, listen: false).profile.address,
//       Provider.of<CartData>(context, listen: false).profile.phone,
//       Provider.of<CartData>(context, listen: false).profile.pincode,
//       "NOT AVAILABLE");
// }
//
// void _handleExternalWallet(ExternalWalletResponse response) {
//   Styles.showWarningToast(
//       Colors.green, "Successful ${response}", Colors.white, 15);
// }