import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/DioError.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/Address.dart';
import 'package:crafty/Models/CashOrder.dart';
import 'package:crafty/Models/Order.dart';
import 'package:crafty/Models/ServerOrder.dart';
import 'package:crafty/UI/CustomWidgets/AllProductsFragmentProductItemview.dart';
import 'package:crafty/UI/CustomWidgets/PaymentOptionsMethod.dart';
import 'package:crafty/UI/Fragments/NewAddressPage.dart';
import 'package:crafty/UI/Fragments/ProductView.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:dio/dio.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartDup extends StatefulWidget {
  @override
  _CartDupState createState() => _CartDupState();
}

class _CartDupState extends State<CartDup> with TickerProviderStateMixin{
  var selectedSize = "1";
  var paymentMethod = [
    'Pay Now',
    'COD'
  ];
  var products,id;
  ProgressDialog pr;
  BuildContext buildContext;
  Widget emptyListWidget;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  void initState() {
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
    buildContext = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    emptyListWidget = Styles.EmptyError;
    buildContext = context;
    return SafeArea(
      child:  Provider.of<CartData>(context, listen: true).list.length > 0?Container(
        color: Color(0xffE3E3E3),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Provider.of<CartData>(context, listen: true).list.length > 0?Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                            Provider.of<CartData>(context, listen: true)
                                .list
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              return index==0?specialCard(index):Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Color(0xffE3E3E3),
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                    ),
                                    height: 200,
                                    child: Column(
                                      children: [
                                        Expanded(
                                            flex: 12,
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        padding:
                                                        EdgeInsets.only(
                                                            top: 8,
                                                            right: 14,
                                                            left: 14,
                                                            bottom: 8),
                                                        child:
                                                        GestureDetector(
                                                          onTap: ()=>onCartItemTap(index),
                                                          child: CachedNetworkImage(
                                                            fit: BoxFit.fill,
                                                            imageUrl: Provider.of<
                                                                CartData>(
                                                                context)
                                                                .list[index]
                                                                .picture,
                                                            progressIndicatorBuilder:
                                                                (context, url,
                                                                downloadProgress) =>
                                                                SizedBox(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  child:
                                                                  SpinKitCubeGrid(
                                                                    color: Styles
                                                                        .price_color,
                                                                    size: 50.0,
                                                                    controller: AnimationController(
                                                                        vsync: this,
                                                                        duration: const Duration(
                                                                            milliseconds:
                                                                            1200)),
                                                                  ),
                                                                ),
                                                            errorWidget: (context,
                                                                url, error) =>
                                                                Icon(Icons.error),
                                                          ),
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 5,
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Expanded(
                                                                flex: 3,
                                                                child:
                                                                Container(
                                                                  width: 300,
                                                                  padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                      top: 8,left:20,bottom: 10),
                                                                  child: Text(
                                                                    "${Provider.of<CartData>(context).list[index].name}",
                                                                    textAlign: TextAlign.start,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        "Halyard",
                                                                        fontSize:
                                                                        18,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                )),
                                                            Expanded(
                                                              flex: 8,
                                                              child: Container(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        Text(
                                                                          "Color:",
                                                                          textAlign:
                                                                          TextAlign.start,
                                                                          style: TextStyle(
                                                                              fontFamily: "Halyard",
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w200,
                                                                              color: Colors.black45),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                              top: 16,
                                                                              bottom: 12),
                                                                          child:
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                "Size:  ",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(fontFamily: "Halyard", fontSize: 14, fontWeight: FontWeight.w200, color: Colors.black45),
                                                                              ),
                                                                              SizedBox(width: 20,),
                                                                              Text(
                                                                                "${Provider.of<CartData>(context).list[index].size}",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(fontFamily: "Halyard", fontSize: 14, fontWeight: FontWeight.w200, color: Colors.black),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "Price: ",
                                                                          textAlign:
                                                                          TextAlign.start,
                                                                          style: TextStyle(
                                                                              fontFamily: "Halyard",
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w200,
                                                                              color: Colors.black45),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width: 7,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                      children: [
                                                                        Text(
                                                                          "${Provider.of<CartData>(context).list[index].color}",
                                                                          style: TextStyle(
                                                                              fontFamily: "Halyard",
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w200,
                                                                              color: Colors.black),
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              "Qty:  ",
                                                                              style: TextStyle(fontFamily: "Halyard", fontSize: 14, fontWeight: FontWeight.w200, color: Colors.black45),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 25,
                                                                            ),
                                                                            DropdownButton<String>(
                                                                              focusColor: Colors.white,
                                                                              value: Provider.of<CartData>(context).list[index].quantity.toString(),
                                                                              //elevation: 5,
                                                                              style: TextStyle(fontFamily: "Halyard", fontSize: 14, fontWeight: FontWeight.w200, color: Colors.black),
                                                                              iconEnabledColor: Colors.black,
                                                                              items: getLabels().map<DropdownMenuItem<String>>((String value) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: value,
                                                                                  child: Text(
                                                                                    "${value}",
                                                                                    style: TextStyle(color: Colors.black),
                                                                                  ),
                                                                                );
                                                                              }).toList(),
                                                                              hint: Text(
                                                                                "",
                                                                                style: TextStyle(fontFamily: "Halyard", fontSize: 14, fontWeight: FontWeight.w200, color: Colors.black),
                                                                              ),
                                                                              onChanged: (String value) {
                                                                                setState(() {
                                                                                  Provider.of<CartData>(context, listen: false).list[index].setQuantity = int.parse(value.toString());
                                                                                });
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              "₹ ${int.parse((Provider.of<CartData>(context).list[index].payment).toString())*int.parse((Provider.of<CartData>(context, listen: false).list[index].quantity).toString())}",
                                                                              style: TextStyle(
                                                                                  fontFamily: "Halyard",
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.w200,
                                                                                  color: Styles.price_color),
                                                                            ),
                                                                            SizedBox(width: 5,),
                                                                            Text(
                                                                              "₹ ${699*int.parse((Provider.of<CartData>(context, listen: false).list[index].quantity).toString())}",
                                                                              style: TextStyle(
                                                                                  decoration: TextDecoration.lineThrough,
                                                                                  fontFamily: "Halyard",
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w200,
                                                                                  color: Colors.black),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            )),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 1,
                                                bottom: 1,
                                                left: 8,
                                                right: 8),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                  width: .1,
                                                  color: Color(0xffb2b2b2),
                                                ),
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Provider.of<CartData>(context,
                                                    listen: false)
                                                    .removeProduct(index, Provider.of<CartData>(context,
                                                    listen: false).list[index].Id);
                                                Styles.showWarningToast(
                                                    Styles.Log_sign,
                                                    "Item removed",
                                                    Colors.black,
                                                    15);
                                              },
                                              style: ButtonStyle(
                                                enableFeedback: true,
                                                backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                                shadowColor:
                                                MaterialStateProperty.all(
                                                    Color(0xffE3E3E3)),
                                                elevation:
                                                MaterialStateProperty.all(
                                                    2),
                                                overlayColor:
                                                MaterialStateProperty
                                                    .resolveWith(
                                                      (states) {
                                                    return states.contains(
                                                        MaterialState
                                                            .pressed)
                                                        ? Color(0xffE3E3E3)
                                                        : null;
                                                  },
                                                ),
                                              ),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                    20,
                                                child: Center(
                                                  child: Text("REMOVE",
                                                      style: TextStyle(
                                                          fontFamily: "Halyard",
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w200,
                                                          color: Colors.black45)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            }),
                      ): Container(
                        height: 10,
                      ),
                      Card(
                        elevation: 1.5,
                        child: Container(
                          height: 170,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              new BoxShadow(
                                color: Color(0xffE3E3E3),
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        "(${Provider.of<CartData>(context).listLength}) Items",
                                        style: TextStyle(
                                            fontFamily: "Halyard",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 35),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Total MRP",
                                                  textAlign:
                                                  TextAlign.start,
                                                  style: TextStyle(
                                                      fontFamily: "Halyard",
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w200,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  "Delivery Charge",
                                                  textAlign:
                                                  TextAlign.start,
                                                  style: TextStyle(
                                                      fontFamily: "Halyard",
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w200,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  "Discount on MRP",
                                                  textAlign:
                                                  TextAlign.start,
                                                  style: TextStyle(
                                                      fontFamily: "Halyard",
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w200,
                                                      color: Styles
                                                          .price_color),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "₹${Provider.of<CartData>(context).noOfTotalItems * 699}",
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      fontFamily: "Halyard",
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  "Free",
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      fontFamily: "Halyard",
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  "${Provider.of<CartData>(context, listen: true).list.length > 0?getDiscount(context).toInt():0}%",
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      fontFamily: "Halyard",
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: Styles
                                                          .price_color),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 8.0,
                                            right: 8.0,
                                            top: 1,
                                            bottom: 1),
                                        child: SizedBox(
                                          height: 1,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          child: Container(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 35),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Total amount",
                                                  style: TextStyle(
                                                      fontFamily: "Halyard",
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "₹${Provider.of<CartData>(context).getPrice()}",
                                                  style: TextStyle(
                                                      fontFamily: "Halyard",
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "You saved ₹${((Provider.of<CartData>(context).noOfTotalItems * 699) - (Provider.of<CartData>(context).getPrice()).toInt())}",
                                        style: TextStyle(
                                            fontFamily: "Halyard",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Styles.price_color),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(elevation: 1, child: allproducts()),
                      Card(
                        elevation: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              new BoxShadow(
                                color: Color(0xffE3E3E3),
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(2),
                          child: Image.asset("assets/images/payment.jpg"),
                        ),
                      ),
                      // remaining stuffs
                    ]),
              ),
            ),
            Card(
              elevation: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  // color: Colors.white,
                  // color: Color(0xffE3E3E3),
                  boxShadow: [
                    new BoxShadow(
                      color: Color(0xffE3E3E3),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                padding: EdgeInsets.only(
                  top: 4,
                ),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Test.fragNavigate
                                .putPosit(key: 'Home', force: true);
                          },
                          style: ButtonStyle(
                            enableFeedback: true,
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                )),
                            backgroundColor: MaterialStateProperty.all(
                                Color(0xffE3E3E3)),
                            shadowColor: MaterialStateProperty.all(
                                Color(0xffE3E3E3)),
                            elevation: MaterialStateProperty.all(4),
                            overlayColor: MaterialStateProperty.resolveWith(
                                  (states) {
                                return states
                                    .contains(MaterialState.pressed)
                                    ? Color(0xffE3E3E3)
                                    : null;
                              },
                            ),
                          ),
                          child: Container(
                            child: Center(
                              child: Text("Continue Shopping",
                                  style: TextStyle(
                                      fontFamily: "Halyard",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 2,
                        child: Container(
                          margin: EdgeInsets.all(2),
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // showSelectAddress();
                            if (Provider.of<CartData>(context,
                                listen: false)
                                .profile !=
                                null) {
                              if(Provider.of<CartData>(context, listen: false).list.length > 0){
                                // showSelectAddress();
                              }else{
                                Fluttertoast.showToast(
                                    msg: 'Add some items to the Cart',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Styles.price_color,
                                    textColor: Colors.white,
                                    fontSize: 14);
                              }

                            } else {
                              Styles.showSnackBar(
                                  context,
                                  Colors.red,
                                  Duration(seconds: 2),
                                  "Log in first",
                                  Colors.white, () {
                                Test.fragNavigate
                                    .putPosit(key: 'Login', force: true);
                              });
                            }
                          },
                          style: ButtonStyle(
                            enableFeedback: true,
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                )),
                            backgroundColor: MaterialStateProperty.all(
                                Styles.price_color),
                            shadowColor: MaterialStateProperty.all(
                                Color(0xffE3E3E3)),
                            elevation: MaterialStateProperty.all(4),
                            overlayColor: MaterialStateProperty.resolveWith(
                                  (states) {
                                return states
                                    .contains(MaterialState.pressed)
                                    ? Color(0xffE3E3E3)
                                    : null;
                              },
                            ),
                          ),
                          child: Container(
                            child: Center(
                              child: Text("Select Address",
                                  style: TextStyle(
                                      fontFamily: "Halyard",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ):EmptyListWidget(
        title: "Oops! Looks like the cart is empty",
        image: "assets/images/cartEmpty.png",
        titleTextStyle: TextStyle(color: Styles.price_color,fontSize: 18,fontFamily: 'Halyard'),
        subTitle: "Please add items to the cart",
        subtitleTextStyle: TextStyle(color:  Styles.price_color,fontSize: 14,fontFamily: 'Halyard'),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Card BottomSheetAddressSelector(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      color: Colors.transparent,
      child: Wrap(
        children: [
          BottomSheetWidget(context),
        ],
      ),
    );
  }

  Container BottomSheetWidget(BuildContext context) {
    return Container(
      color: Colors.white,
      // height: MediaQuery.of(context).,
      padding: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Select a address",
              style: TextStyle(
                  fontFamily: "Halyard",
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
          SizedBox(
            height: 10,
          ),
          Provider.of<CartData>(context, listen: true).profile != null && Provider.of<CartData>(context, listen: true).profile.address != null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1.5,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Color(0xffE3E3E3),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            radius:
                            MediaQuery.of(context).size.width + 10,
                            splashColor: Colors.black,
                            enableFeedback: true,
                            onTap: () {
                              SetSelectedAddress(
                                  Provider.of<CartData>(context,
                                      listen: false)
                                      .profile
                                      .address,
                                  Provider.of<CartData>(context,
                                      listen: false)
                                      .profile
                                      .phone
                                      .toString(),
                                  Provider.of<CartData>(context,
                                      listen: false)
                                      .profile
                                      .pincode
                                      .toString());
                              Navigator.pop(context);
                              ShowPaymentOptions();
                            },
                            child: Container(
                              height: 130,
                              width:
                              MediaQuery.of(context).size.width - 10,
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:EdgeInsets.only(bottom: 85.0,right: 10),
                                    child: Radio(
                                      value: true,
                                      toggleable: true,
                                      onChanged: (vaw){
                                        SetSelectedAddress(
                                            Provider.of<CartData>(context,
                                                listen: false)
                                                .profile
                                                .address,
                                            Provider.of<CartData>(context,
                                                listen: false)
                                                .profile
                                                .phone
                                                .toString(),
                                            Provider.of<CartData>(context,
                                                listen: false)
                                                .profile
                                                .pincode
                                                .toString());
                                        Navigator.pop(context);
                                        ShowPaymentOptions();
                                      }, groupValue: null,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${Provider.of<CartData>(context, listen: true).profile.name}",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: "Halyard",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${Provider.of<CartData>(context, listen: true).profile.address.split(",")[0]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: "Halyard",
                                                  fontSize: 13,
                                                  fontWeight:
                                                  FontWeight.w300,
                                                  color: Colors.black)),
                                          Text(
                                              "${Provider.of<CartData>(context, listen: true).profile.address.split(",")[1]}, Pincode: ${Provider.of<CartData>(context, listen: true).profile.pincode}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: "Halyard",
                                                  fontSize: 13,
                                                  fontWeight:
                                                  FontWeight.w300,
                                                  color: Colors.black)),
                                          Text(
                                              "${Provider.of<CartData>(context, listen: true).profile.address.split(",")[2]}, ${Provider.of<CartData>(context, listen: true).profile.address.split(",")[3]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: "Halyard",
                                                  fontSize: 13,
                                                  fontWeight:
                                                  FontWeight.w300,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Mobile: ",
                                              style: TextStyle(
                                                  fontFamily: "Halyard",
                                                  fontSize: 13,
                                                  fontWeight:
                                                  FontWeight.w300,
                                                  color: Colors.black)),
                                          Text(
                                              "${Provider.of<CartData>(context, listen: true).profile.phone}",
                                              style: TextStyle(
                                                  fontFamily: "Halyard",
                                                  fontSize: 13,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              Text("OR",
                  style: TextStyle(
                      fontFamily: "Halyard",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ],
          )
              : Container(),
          Provider.of<CartData>(context, listen: true).profile == null
              ? Text("No default Addresses",
              style: TextStyle(
                  fontFamily: "Halyard",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black))
              : Container(),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                addNewAddress();
              },
              style: ButtonStyle(
                enableFeedback: true,
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )),
                backgroundColor: MaterialStateProperty.all(Styles.price_color),
                shadowColor: MaterialStateProperty.all(Color(0xffE3E3E3)),
                elevation: MaterialStateProperty.all(4),
                overlayColor: MaterialStateProperty.resolveWith(
                      (states) {
                    return states.contains(MaterialState.pressed)
                        ? Color(0xffE3E3E3)
                        : null;
                  },
                ),
              ),
              child: Container(
                child: Center(
                  child: Text("Add New Address",
                      style: TextStyle(
                          fontFamily: "Halyard",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget allproducts() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: Color(0xffE3E3E3),
            blurRadius: 5.0,
          ),
        ],
      ),
      height: 450,
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 18, right: 37),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Similar products",
                        style: TextStyle(
                            fontFamily: "Halyard",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    TextButton(
                        onPressed: () {
                          Test.fragNavigate.putPosit(key: 'All', force: true);
                        },
                        child: Text("Show all",
                            style: TextStyle(
                                fontFamily: "Halyard",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Styles.price_color)))
                  ],
                ),
              )),
          Expanded(
            flex: 8,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: Provider.of<CartData>(context, listen: true)
                  .allproducts
                  .sublist(
                  0,
                  Provider.of<CartData>(context, listen: false)
                      .allproducts
                      .length ~/
                      3)
                  .length,
              itemBuilder: (BuildContext ctxt, int index) {
                return AllProductsFragmentProductItemView(
                  buttonSize: 20,
                  list: Provider.of<CartData>(context, listen: true)
                      .allproducts
                      .sublist(
                      0,
                      Provider.of<CartData>(context, listen: false)
                          .allproducts
                          .length ~/
                          3),
                  Index: index,
                  OnTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductView(
                                product: Provider.of<CartData>(context,
                                    listen: false)
                                    .allproducts
                                    .sublist(
                                    0,
                                    Provider.of<CartData>(context,
                                        listen: false)
                                        .allproducts
                                        .length ~/
                                        3)[index],
                                fragNav: Test.fragNavigate)));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  getDiscount(context) {
    int post = (Provider.of<CartData>(context).getPrice()).toInt();
    int pre = (Provider.of<CartData>(context).noOfTotalItems * 699);

    return (pre - post) / pre * 100;
  }

  getLabels() {
    return ['1', '2', '3', '4', '5'];
  }

  void SetSelectedAddress(address, phone, pincode) {
    Provider.of<CartData>(context, listen: false)
        .setAddress(Address(address, phone, pincode));
  }

  void ShowPaymentOptions() {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            color: Colors.transparent,
            child: Wrap(
              children: [
                PaymentOptionsMethod(
                    paymentMethod: paymentMethod,
                    onTap: (index) {
                      if (paymentMethod[index] == "COD") {
                        initCOD(buildContext);
                      } else {
                        // makeOtherPayments();
                        OnlinePay();
                      }
                    }),
              ],
            ),
          );
        });
  }

  void initCOD(BuildContext context) async {
    Navigator.pop(context);
    await pr.show();
    UsersModel usersModel = UsersModel();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    // Styles.showWarningToast(Colors.green, "Successful", Colors.white, 15);

    var id = "order_cod_" + getRandomString(5);

    try {
      var a = await usersModel.saveOrderDatabase(
          saveToDatabase(
              id,
              Provider.of<CartData>(context, listen: false).getPrice() * 100,
              "COD",
              context),
          Provider.of<CartData>(context, listen: false).name == null
              ? Provider.of<CartData>(context, listen: false).user.name
              : Provider.of<CartData>(context, listen: false).name);
      if (a != null && a != "Unable to save order") {
        var amount = Provider.of<CartData>(context, listen: false).getPrice();
        Provider.of<CartData>(context, listen: false)
            .removeAll(0, CartData.listLengths);
        setState(() {
          pr.hide().then((isHidden) async{
            var a = await usersModel.triggerResponse(
                id,
                Provider.of<CartData>(context, listen: false)
                    .profile
                    .email);
            if (a == "complete") {
              CartData.RESULT = "SUCCESS";
              CartData.price = amount.toString();
              CartData.id = id.toString();
              CartData.TXT = id.toString();
              Test.fragNavigate.putPosit(key: 'Result');
            } else {
              CartData.RESULT = "SUCCESS";
              CartData.price = amount.toString();
              CartData.id = id.toString();
              CartData.TXT = id.toString();
              Test.fragNavigate.putPosit(key: 'Result');
            }
          });
        });
      } else {
        pr.hide().then((isHidden) {
          CartData.RESULT = "FAILED";
          CartData.price = (Provider.of<CartData>(context, listen: false).getPrice()).toString();
          CartData.id = id.toString();
          CartData.TXT = id.toString();
          Test.fragNavigate.putPosit(key: 'Result');
        });
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print(errorMessage);
      pr.hide().then((isHidden) {
        CartData.RESULT = "FAILED";
        CartData.price = (Provider.of<CartData>(context, listen: false).getPrice()).toString();
        CartData.id = id.toString();
        CartData.TXT = id.toString();
        Test.fragNavigate.putPosit(key: 'Result');
      });
      // CartData.RESULT = "assets/raw/failed.json";
      // CartData.TXT = id;
      // Test.fragNavigate.putPosit(key: 'Result');
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
            .Pictures,
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
        Provider.of<CartData>(context, listen: false)
            .getIndivisualPrice()
    );
  }

  void addNewAddress() {
    Navigator.pop(context);
    showModalBottomSheet<dynamic>(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(child: Container(
              padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(children: [NewAddressPage()])));
        }).whenComplete(() {
      if (Provider.of<CartData>(context, listen: false).getAddress != null) {
        ShowPaymentOptions();
      } else {
        print("We hdda ave the address");
      }
    });
  }

  void showSelectAddress() {
    showModalBottomSheet<dynamic>(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return BottomSheetAddressSelector(context);
        });
  }

  void OnlinePay() async{
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
    CashOrder order = getOrder(amount,context);
    var data = await getTokenData(order);
    if (data !="tryagain" ) {
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
      inputs.putIfAbsent('orderCurrency', () {
        return "INR";
      });
      print("the inputs \n ${inputs}");
      CashfreePGSDK.doPayment(inputs).onError((error, stackTrace) {
        print(error);
        return error;
      }).then((value) {
        value?.forEach((key, val) async {
          print("$key : $val");
          if (key=='txStatus') {
            if (val.toString() == "SUCCESS") {
                        initiateSaving(value);
            }else{
              print("Hq");
              CartData.RESULT = value['txStatus'];
              CartData.price = value['orderAmount'];
              CartData.id = value['orderId'];
              CartData.TXT = value['referenceId'];
              Test.fragNavigate.putPosit(key: 'Result');
            }
          }
        });
      }).whenComplete(() {
        pr.hide().then((isHidden) {});
      });

    }else{
      pr.hide().then((isHidden) {
        Dialogs.materialDialog(
            msg: 'Please try again',
            title: "Oops Something is wrong",
            color: Colors.white,
            context: context,
            actions: [
              IconsButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'close',
                iconData: Icons.delete,
                color: Colors.red,
                textStyle: TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ]);
      }

      );
    }

  }

  void initiateSaving(dynamic value) async {
    try {
      UsersModel usersModel = UsersModel();
      var a = await usersModel.saveOrderDatabase(
          saveToDatabase(
              value['orderId'],
              Provider.of<CartData>(context, listen: false)
                  .getPrice() *
                  100,
              value['referenceId'],
              context,
             ),
          Provider.of<CartData>(context, listen: false)
              .name ==
              null
              ? Provider.of<CartData>(context,
              listen: false)
              .user
              .name
              : Provider.of<CartData>(context,
              listen: false)
              .name);
      if (a != null && a != "Unable to save order") {
        print("Successful ${value['txStatus']}");
        CartData.removeALL(0, CartData.listLengths);
        CartData.RESULT = value['txStatus'];
        CartData.price = value['orderAmount'];
        CartData.id = value['orderId'];
        CartData.TXT = value['referenceId'];
        Test.fragNavigate.putPosit(key: 'Result');
      } else {
        print("Failed ${value['txStatus']}");
        CartData.RESULT = value['txStatus'];
        CartData.price = value['orderAmount'];
        CartData.id = value['orderId'];
        CartData.TXT = value['referenceId'];
        Test.fragNavigate.putPosit(key: 'Result');
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print(errorMessage);

    }
  }


  void makeOtherPayments() async{
    Navigator.pop(context);
    await pr.show();
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
        Provider.of<CartData>(context, listen: false).setOrderId(id);
      } catch (e) {
        print(e);
      }
      Test.currentCartItems =
          Provider.of<CartData>(context, listen: false).list;
      try {
        pr.hide().then((isHidden) async{
          CashOrder order = getOrder(Provider.of<CartData>(context, listen: false).getPrice(),context);
          var data = await getTokenData(order);
          Map<String, String> options = {
            'Token':
            data['body']['cftoken'].toString(),
            'Id':data['id'],
            'stage':'TEST',
            'price': (Provider.of<CartData>(context, listen: false).getPrice())
                .toString(),
            'address': Provider.of<CartData>(context, listen: false).profile.address,
            'phone': Provider.of<CartData>(context, listen: false)
                .profile
                .phone
                .toString(),
            'name':
            Provider.of<CartData>(context, listen: false).profile.name.toString(),
            'email': Provider.of<CartData>(context, listen: false)
                .profile
                .email
                .toString(),
            'order_id':
            order.orderId.toString()
                .substring(1, order.orderId.toString().length - 1),
            'orderNote': 'Crafty',
          };
          Provider.of<CartData>(context, listen: false).paymentdata = options;
          Test.fragNavigate.putPosit(key: 'Payment', force: true,);
        });
      } catch (e) {
        print("VVVV $e");
      }
    } else {
      pr.hide();
      Styles.showWarningToast(
          Colors.red, "Failed Please Log out", Colors.white, 15);
    }
  }
  Future<ServerOrder> getEveryThing(double price) async {
    UsersModel usersModel = UsersModel();
    return await usersModel.getOrder(price);
  }

  specialCard(index) {
    return Card(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              new BoxShadow(
                color: Color(0xffE3E3E3),
                blurRadius: 5.0,
              ),
            ],
          ),
          height: 260,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 16,top: 8.0,bottom: 8.0),
                  child: Row(
                    children: [
                      Icon(MaterialCommunityIcons.shopping,size: 40,),
                      SizedBox(width: 5,),
                      Text("Shopping Bag",
                          style: TextStyle(
                              fontFamily:
                              "Halyard",
                              fontSize:
                              22,
                              fontWeight: FontWeight.w400,
                              color: Colors
                                  .black)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(height: 1,child: Container(color: Colors.grey,),),
              ),
              Expanded(
                  flex: 12,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Container(
                              padding:
                              EdgeInsets.only(
                                  top: 8,
                                  right: 14,
                                  left: 14,
                                  bottom: 8),
                              child:
                              GestureDetector(
                                onTap: ()=>onCartItemTap(index),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: Provider.of<
                                      CartData>(
                                      context)
                                      .list[index]
                                      .picture,
                                  progressIndicatorBuilder:
                                      (context, url,
                                      downloadProgress) =>
                                      SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child:
                                        SpinKitCubeGrid(
                                          color: Styles
                                              .price_color,
                                          size: 50.0,
                                          controller: AnimationController(
                                              vsync: this,
                                              duration: const Duration(
                                                  milliseconds:
                                                  1200)),
                                        ),
                                      ),
                                  errorWidget: (context,
                                      url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child:
                                      Container(
                                        width: 300,
                                        padding:
                                        EdgeInsets
                                            .only(
                                            top: 8,left:22,bottom: 10),
                                        child: Text(
                                          "${Provider.of<CartData>(context).list[index].name}",
                                          style: TextStyle(
                                              fontFamily:
                                              "Halyard",
                                              fontSize:
                                              18,
                                              fontWeight:
                                              FontWeight
                                                  .w400,
                                              color: Colors
                                                  .black),
                                        ),
                                      )),
                                  Expanded(
                                    flex: 8,
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                "Color:",
                                                textAlign:
                                                TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: "Halyard",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w200,
                                                    color: Colors.black45),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 16,
                                                    bottom: 12),
                                                child:
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Size:  ",
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(fontFamily: "Halyard", fontSize: 14, fontWeight: FontWeight.w200, color: Colors.black45),
                                                    ),
                                                    SizedBox(width: 20,),
                                                    Text(
                                                      "${Provider.of<CartData>(context).list[index].size}",
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(fontFamily: "Halyard", fontSize: 14, fontWeight: FontWeight.w200, color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "Price: ",
                                                textAlign:
                                                TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: "Halyard",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w200,
                                                    color: Colors.black45),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .end,
                                            children: [
                                              Text(
                                                "${Provider.of<CartData>(context).list[index].color}",
                                                style: TextStyle(
                                                    fontFamily: "Halyard",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w200,
                                                    color: Colors.black),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Qty:",
                                                    style: TextStyle(fontFamily: "Halyard", fontSize: 14, fontWeight: FontWeight.w200, color: Colors.black45),
                                                  ),
                                                  SizedBox(width: 25,),
                                                  DropdownButton<String>(
                                                    focusColor: Colors.white,
                                                    value: Provider.of<CartData>(context).list[index].quantity.toString(),
                                                    //elevation: 5,
                                                    style: TextStyle(fontFamily: "Halyard", fontSize: 14, fontWeight: FontWeight.w200, color: Colors.black),
                                                    iconEnabledColor: Colors.black,
                                                    items: getLabels().map<DropdownMenuItem<String>>((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(
                                                          "${value}",
                                                          style: TextStyle(color: Colors.black),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    hint: Text(
                                                      "",
                                                      style: TextStyle(fontFamily: "Halyard", fontSize: 14, fontWeight: FontWeight.w200, color: Colors.black),
                                                    ),
                                                    onChanged: (String value) {
                                                      setState(() {
                                                        Provider.of<CartData>(context, listen: false).list[index].setQuantity = int.parse(value.toString());
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "₹ ${int.parse((Provider.of<CartData>(context).list[index].payment).toString())*int.parse((Provider.of<CartData>(context, listen: false).list[index].quantity).toString())}",
                                                    style: TextStyle(
                                                        fontFamily: "Halyard",
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w200,
                                                        color: Styles.price_color),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Text(
                                                    "₹ ${699*int.parse((Provider.of<CartData>(context, listen: false).list[index].quantity).toString())}",
                                                    style: TextStyle(
                                                        decoration: TextDecoration.lineThrough,
                                                        fontFamily: "Halyard",
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w200,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  )),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(
                      top: 1,
                      bottom: 1,
                      left: 8,
                      right: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: .1,
                        color: Color(0xffb2b2b2),
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<CartData>(context,
                          listen: false)
                          .removeProduct(index,Provider.of<CartData>(context,
                          listen: false).list[index].Id);
                      Styles.showWarningToast(
                          Styles.Log_sign,
                          "Item removed",
                          Colors.black,
                          15);
                    },
                    style: ButtonStyle(
                      enableFeedback: true,
                      backgroundColor:
                      MaterialStateProperty.all(
                          Colors.white),
                      shadowColor:
                      MaterialStateProperty.all(
                          Color(0xffE3E3E3)),
                      elevation:
                      MaterialStateProperty.all(
                          2),
                      overlayColor:
                      MaterialStateProperty
                          .resolveWith(
                            (states) {
                          return states.contains(
                              MaterialState
                                  .pressed)
                              ? Color(0xffE3E3E3)
                              : null;
                        },
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context)
                          .size
                          .width -
                          20,
                      child: Center(
                        child: Text("REMOVE",
                            style: TextStyle(
                                fontFamily: "Halyard",
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w200,
                                color: Colors.black45)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
  getTokenData(CashOrder cashOrder) async {
    UsersModel usersModel = new UsersModel();
    return await usersModel.savePayment(cashOrder);
  }
  getOrder(amount,context) {

    var order = CashOrder();
    order.customerName =
        Provider.of<CartData>(context, listen: false).user.name;
    order.customerEmail =  Provider.of<CartData>(context, listen: false).profile.email;
    order.customerPhone = Provider.of<CartData>(context, listen: false).profile.phone;
    order.orderAmount = amount;
    order.stage = "PROD";
    print("SGVAS ${order.stage}");
    return order;
  }

  onCartItemTap(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductView(
                product: getIndex(Provider.of<CartData>(context,
                    listen: false)
                    .list[index].name),
                fragNav: Test.fragNavigate)));
  }

  getIndex(var item) {
    print("Hell ${item}");
    var list = Provider.of<CartData>(context, listen: false).allproducts;
    for(var i in list){
      if(i.Name.toString().trim() == item.toString().trim()){
        print("Hel2l");
        return Provider.of<CartData>(context, listen: false).allproducts[Provider.of<CartData>(context, listen: false).allproducts.indexOf(i)];
      }
    }
  }
}
