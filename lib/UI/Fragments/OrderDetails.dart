import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/UI/CustomWidgets/CartItems.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OrderDetails extends StatefulWidget {
  OrderDetails({Key key});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails>
    with TickerProviderStateMixin {
  int amount = 0, items = 0;

  @override
  Widget build(BuildContext context) {
    print("ad ${Provider.of<CartData>(context).orderSelected.products}");
    return Consumer<CartData>(
      builder: (context, data, child) => Container(
        color: Color(0xffe3e3e6),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(top: 3, left: 2, right: 2),
                child: Card(
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order No:",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.black,
                                  fontFamily: 'Halyard',
                                ),
                              ),
                              Text(
                                "Tracking ID:",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.black,
                                  fontFamily: 'Halyard',
                                ),
                              ),
                              Text(
                                "Date:",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.black,
                                  fontFamily: 'Halyard',
                                ),
                              ),
                              Text(
                                "Status:",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.black,
                                  fontFamily: 'Halyard',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${data.orderSelected.orderId}",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Halyard',
                                ),
                              ),
                              Text(
                                "${data.orderSelected.trackingId}",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Halyard',
                                ),
                              ),
                              Text(
                                "${data.orderSelected.date.toString().substring(3, 5)}/${data.orderSelected.date.toString().substring(0, 2)}/${data.orderSelected.date.toString().substring(6)}",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Halyard',
                                ),
                              ),
                              Text(
                                "${data.orderSelected.status}",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Halyard',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0.3.h,
            ),
            Expanded(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.only(left: 3, right: 3),
                child: Card(
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
                    height: MediaQuery.of(context).size.width / 1.2,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Order Items",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                    fontFamily: 'Halyard',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "${data.orderSelected.color.toString().split(",").length} items",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'Halyard', fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: data.orderSelected.products
                                  .toString()
                                  .split(",")
                                  .length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return Expanded(
                                  child: Card(
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
                                      height: 18.h,
                                      child: Row(
                                        children: [
                                          CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            imageUrl: data.orderSelected.picture
                                                .trim(),
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: SpinKitCubeGrid(
                                                color: Styles.price_color,
                                                size: 50.0,
                                                controller: AnimationController(
                                                    vsync: this,
                                                    duration: const Duration(
                                                        milliseconds: 1200)),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                          Expanded(
                                              child: Container(
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                          child: Container(
                                                              child: Center(
                                                                  child: Text(
                                                        "orderId: ",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Halyard',
                                                            fontSize: 11.sp),
                                                      )))),
                                                      Expanded(
                                                          child: Container(
                                                              child: Center(
                                                                  child: Text(
                                                                      "${data.orderSelected.products.toString().split(",")[index]}",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontFamily:
                                                                              'Halyard',
                                                                          fontSize:
                                                                              11.sp)))))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                          child: Container(
                                                              child: Center(
                                                                  child: Text(
                                                                      "Color: ",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Halyard',
                                                                          fontSize:
                                                                              11.sp))))),
                                                      Expanded(
                                                          child: Container(
                                                              child: Center(
                                                                  child: Text(
                                                                      "${data.orderSelected.color.toString().split(",")[index]}",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontFamily:
                                                                              'Halyard',
                                                                          fontSize:
                                                                              11.sp)))))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                          child: Container(
                                                              child: Center(
                                                                  child: Text(
                                                                      "Size: ",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Halyard',
                                                                          fontSize:
                                                                              11.sp))))),
                                                      Expanded(
                                                          child: Container(
                                                              child: Center(
                                                                  child: Text(
                                                                      "${data.orderSelected.size.toString().split(",")[index]}",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontFamily:
                                                                              'Halyard',
                                                                          fontSize:
                                                                              11.sp)))))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                          child: Container(
                                                              child: Center(
                                                                  child: Text(
                                                                      "Price: ",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Halyard',
                                                                          fontSize:
                                                                              11.sp))))),
                                                      Expanded(
                                                          child: Container(
                                                              child: Center(
                                                                  child: Text(
                                                                      "${data.orderSelected.indvPrice.toString().split(",")[index]}",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontFamily:
                                                                              'Halyard',
                                                                          fontSize:
                                                                              11.sp))))),

                                                    ],
                                                  ),
                                                ),
                                                
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Card(
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Order Information",
                            style: TextStyle(fontSize: 14.sp,fontFamily: 'Halyard',fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Shipping address:",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Halyard',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "Total price:",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Halyard',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${Provider.of<CartData>(context, listen: false).orderSelected.address}",
                                      softWrap: true,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Halyard',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "₹ ${Provider.of<CartData>(context, listen: false).orderSelected.price}",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Styles.price_color,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Halyard',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 1,
              child: Container(
                height: 5.5.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Color(0xffE3E3E3),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => cancelOrder(
                            Provider.of<CartData>(context, listen: false)
                                .orderSelected
                                .orderId,
                            context),
                        style: ButtonStyle(
                          enableFeedback: true,
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xffE3E3E3)),
                          shadowColor:
                              MaterialStateProperty.all(Color(0xffE3E3E3)),
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
                            child: Text("Cancel",
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
                      width: 2,
                      child: Container(
                        margin: EdgeInsets.all(2),
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Test.fragNavigate.putPosit(key: 'Contact Us');
                        },
                        style: ButtonStyle(
                          enableFeedback: true,
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )),
                          backgroundColor:
                              MaterialStateProperty.all(Styles.price_color),
                          shadowColor:
                              MaterialStateProperty.all(Color(0xffE3E3E3)),
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
                            child: Text("Contact us",
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
          ],
        ),
      ),
    );
  }
}

void cancelOrder(orderId, context) async {
  Styles.showWarningToast(Colors.green, "Order cancelled", Colors.black, 15);
  UsersModel usersModel = UsersModel();
  var txt = await usersModel.cancel(
      orderId, Provider.of<CartData>(context, listen: false).profile.email);
  Styles.showWarningToast(Colors.green, txt.toString(), Colors.black, 15);
}
