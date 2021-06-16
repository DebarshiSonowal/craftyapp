import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/UI/CustomWidgets/CartItems.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsOLd extends StatefulWidget {
  OrderDetailsOLd({Key key});

  @override
  _OrderDetailsOLdState createState() => _OrderDetailsOLdState();
}

class _OrderDetailsOLdState extends State<OrderDetailsOLd> {
  int amount = 0, items = 0;

  @override
  Widget build(BuildContext context) {
    print(
        "The li asg ${Provider.of<CartData>(context).orderSelected.products.toString().split(",").length}");
    return Container(
      color: Color(0xffe3e3e6),
      height: MediaQuery.of(context).size.height -
          (MediaQuery.of(context).size.width / 3),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order No: ${Provider.of<CartData>(context, listen: false).orderSelected.orderId}",
                              style: TextStyle(
                                fontSize: 12, color: Colors.black45, fontFamily: 'Halyard',),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Tracking number: ${Provider.of<CartData>(context, listen: false).orderSelected.trackingId}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${Provider.of<CartData>(context, listen: false).orderSelected.date}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${Provider.of<CartData>(context, listen: false).orderSelected.status}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Provider.of<CartData>(context,
                                      listen: false)
                                      .orderSelected
                                      .status
                                      .toString()
                                      .trim() ==
                                      "Cancelled"
                                      ? Colors.red
                                      : Colors.green),
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
            flex:6,
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
                              Flexible(
                                  flex: 10,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: Provider.of<CartData>(context)
                                        .orderSelected
                                        .products
                                        .toString()
                                        .split(",")
                                        .length,
                                    itemBuilder: (BuildContext ctxt, int index) {
                                      return Card(
                                        child: Container(
                                          // child:,
                                        ),
                                      );
                                    },
                                  )),
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
            flex: 3,
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
                                children: [
                                  Text("Shipping address:"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Total price:"),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  Text(
                                    "${Provider.of<CartData>(context, listen: false).orderSelected.address}",
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "₹ ${Provider.of<CartData>(context, listen: false).orderSelected.price}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Provider.of<CartData>(context, listen: false)
                          .orderSelected
                          .status
                          .toString()
                          .trim() ==
                          "Cancelled"
                          ? Expanded(
                        flex: 2,
                        child: Container(
                          child: ElevatedButton(
                              onPressed: () {
                                Test.fragNavigate
                                    .putPosit(key: 'Contact Us');
                              },
                              child: Text("Help")),
                        ),
                      )
                          : Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  onPressed: () => cancelOrder(
                                      Provider.of<CartData>(context,
                                          listen: false)
                                          .orderSelected
                                          .orderId,
                                      context),
                                  child: Text("Cancel")),
                              ElevatedButton(
                                  onPressed: () {
                                    Test.fragNavigate
                                        .putPosit(key: 'Contact Us');
                                  },
                                  child: Text("Help"))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
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
