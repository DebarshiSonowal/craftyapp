
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
      color: Styles.bg_color,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MediaQuery.of(context).size.width / 5,
            color: Colors.white,
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
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                            color: Provider.of<CartData>(context, listen: false)
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
          Container(
            height: MediaQuery.of(context).size.width / 1.2,
            color: Colors.white70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      "Order Items",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                                return CartItem(
                                  index: index,
                                  list: Provider.of<CartData>(context)
                                      .orderSelected,
                                  callback: null,
                                  th: true,
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
          Container(
            height: MediaQuery.of(context).size.width / 3,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Information",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Shipping address:"),
                            SizedBox(
                              height: 30,
                            ),
                            Text("Total price:"),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${Provider.of<CartData>(context, listen: false).orderSelected.address}",
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
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
                ],
              ),
            ),
          ),
          Provider.of<CartData>(context, listen: false)
                      .orderSelected
                      .status
                      .toString()
                      .trim() ==
                  "Cancelled"
              ? ElevatedButton(
                  onPressed: () {
                    Test.fragNavigate.putPosit(key: 'Contact Us');
                  },
                  child: Text("Help"))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () => cancelOrder(
                            Provider.of<CartData>(context, listen: false)
                                .orderSelected
                                .orderId,
                            context),
                        child: Text("Cancel")),
                    ElevatedButton(
                        onPressed: () {
                          Test.fragNavigate.putPosit(key: 'Contact Us');
                        },
                        child: Text("Help"))
                  ],
                )
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
