import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/UI/CustomWidgets/CartItems.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  OrderDetails({Key key});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int amount = 0, items = 0;

  @override
  Widget build(BuildContext context) {
    print(
        "The li asg ${Provider.of<CartData>(context).orderSelected.products.toString().split(",").length}");
    return Container(
      color: Color(0xffe3e3e6),
      height: MediaQuery.of(context).size.height -
          (MediaQuery.of(context).size.width / 4),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 3,
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
                                fontSize: 12, color: Colors.black, fontFamily: 'Halyard',),
                            ),
                            Text(
                              "Tracking ID:",
                              style: TextStyle(
                                fontSize: 12, color: Colors.black, fontFamily: 'Halyard',),
                            ),
                            Text(
                              "Date:",
                              style: TextStyle(
                                fontSize: 12, color: Colors.black, fontFamily: 'Halyard',),
                            ),
                            Text(
                              "Status:",
                              style: TextStyle(
                                fontSize: 12, color: Colors.black, fontFamily: 'Halyard',),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${Provider.of<CartData>(context, listen: false).orderSelected.orderId}",
                              style: TextStyle(
                                fontSize: 12, color: Colors.black,fontWeight: FontWeight.w600, fontFamily: 'Halyard',),
                            ),
                            Text(
                              "${Provider.of<CartData>(context, listen: false).orderSelected.trackingId}",
                              style: TextStyle(
                                fontSize: 12, color: Colors.black,fontWeight: FontWeight.w600, fontFamily: 'Halyard',),
                            ),
                            Text(
                              "${Provider.of<CartData>(context, listen: false).orderSelected.date.toString().substring(3,5)}/${Provider.of<CartData>(context, listen: false).orderSelected.date.toString().substring(0,2)}/${Provider.of<CartData>(context, listen: false).orderSelected.date.toString().substring(6)}",
                              style: TextStyle(
                                fontSize: 12, color: Colors.black,fontWeight: FontWeight.w600, fontFamily: 'Halyard',),
                            ),
                            Text(
                              "${Provider.of<CartData>(context, listen: false).orderSelected.status}",
                              style: TextStyle(
                                fontSize: 12, color: Colors.black,fontWeight: FontWeight.w600, fontFamily: 'Halyard',),
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
            height: 5,
          ),
          Expanded(
            flex:10,
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
                        Flexible(
                          flex: 1,
                          child: Text(
                            "Order Items",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Flexible(
                          flex: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  "${Provider.of<CartData>(context).orderSelected.color.toString().split(",").length} items",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              // Flexible(
                              //     flex: 10,
                              //     child: ListView.builder(
                              //       shrinkWrap: true,
                              //       scrollDirection: Axis.vertical,
                              //       itemCount: Provider.of<CartData>(context)
                              //           .orderSelected
                              //           .products
                              //           .toString()
                              //           .split(",")
                              //           .length,
                              //       itemBuilder: (BuildContext ctxt, int index) {
                              //         return Card(
                              //           child: Container(
                              //             child:
                              //
                              //             ,
                              //           ),
                              //         );
                              //       },
                              //     )),
                            ],
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
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 10,
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
                                  Text("Shipping address:",
                                    style: TextStyle(
                                      fontSize: 12, color: Colors.black, fontFamily: 'Halyard',),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Total price:", style: TextStyle(
                                    fontSize: 12, color: Colors.black, fontFamily: 'Halyard',),),
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
                                      fontSize: 12, color: Colors.black,fontWeight: FontWeight.w600, fontFamily: 'Halyard',),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "₹ ${Provider.of<CartData>(context, listen: false).orderSelected.price}",
                                    style: TextStyle(
                                      fontSize: 12, color: Styles.price_color,fontWeight: FontWeight.w600, fontFamily: 'Halyard',),
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
              decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Color(0xffE3E3E3),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              // child:  Card(
              //   elevation: 1.5,
              //   child: Container(
              //     height: 50,
              //     width: MediaQuery.of(context).size.width,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       boxShadow: [
              //         new BoxShadow(
              //           color: Color(0xffE3E3E3),
              //           blurRadius: 5.0,
              //         ),
              //       ],
              //     ),
              //     child: ElevatedButton(
              //       style: ButtonStyle(
              //         backgroundColor: MaterialStateProperty.all(Colors.red),
              //       ),
              //       child: Text(
              //         'Proceed',
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 17,
              //             fontFamily: Styles.font,
              //             fontWeight: FontWeight.bold),
              //       ),
              //       onPressed: () {
              //
              //       },
              //     ),
              //   ),
              // ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed:  () => cancelOrder(
                          Provider.of<CartData>(context,
                              listen: false)
                              .orderSelected
                              .orderId,
                          context),
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
                      onPressed:() {
                        Test.fragNavigate
                            .putPosit(key: 'Contact Us');
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
