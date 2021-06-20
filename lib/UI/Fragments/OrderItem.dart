import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatelessWidget {
   OrderItem({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // gsg = Provider.of<CartData>(context, listen: false).order

    return Container(
      height: MediaQuery.of(context).size.height ,
      child: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: Provider.of<CartData>(context, listen: false).order.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Order No:  ",
                                        style: TextStyle(
                                          fontSize: 12, color: Colors.black45, fontFamily: 'Halyard',),
                                      ), Text(
                                        "${Provider.of<CartData>(context, listen: false).order.reversed.toList()[index].orderId}",
                                        style: TextStyle(
                                          fontSize: 14, color: Colors.black, fontFamily: 'Halyard',),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${Provider.of<CartData>(context, listen: false).order.reversed.toList()[index].date.toString().substring(3,5)}/${Provider.of<CartData>(context, listen: false).order.reversed.toList()[index].date.toString().substring(0,2)}/${Provider.of<CartData>(context, listen: false).order.reversed.toList()[index].date.toString().substring(6)}",
                                    style: TextStyle(
                                      fontSize: 14, color: Colors.black, fontFamily: 'Halyard',),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Tracking Number:",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black45, fontFamily: 'Halyard',),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    "${Provider.of<CartData>(context, listen: false).order.reversed.toList()[index].trackingId}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 14),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Quantity:",
                                        style: TextStyle(
                                          fontSize: 12, color: Colors.black45, fontFamily: 'Halyard',),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        "${Provider.of<CartData>(context, listen: false).order.reversed.toList()[index].quantity}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Total Amount:",
                                        style: TextStyle(
                                          fontSize: 12, color: Colors.black45, fontFamily: 'Halyard',),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        "${Provider.of<CartData>(context, listen: false).order.reversed.toList()[index].price}",
                                        style: TextStyle(
                                          fontSize: 14, color: Colors.black, fontFamily: 'Halyard',),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Provider.of<CartData>(context, listen: false).order.reversed.toList()[index].status.toString().trim()=="Delivered"?Row(
                                children: [
                                  Text(
                                    "Delivered",
                                    style: TextStyle(
                                      fontSize: 16, color: Styles.price_color,fontWeight: FontWeight.w600, fontFamily: 'Halyard',),
                                  )
                                ],
                              ):Provider.of<CartData>(context, listen: false).order.reversed.toList()[index].status.toString().trim()!="Cancelled"?Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Details"),
                                          ),
                                          onTap: () {
                                           // Styles.showWarningToast(Styles.price_color, 'Coming soon', Colors.white, 12);
                                            Provider.of<CartData>(context,listen: false).setOrderSelected(Provider.of<CartData>(context, listen: false).order.reversed.toList()[index]);
                                            Test.fragNavigate.putPosit(key: 'Details', force: true);
                                          },
                                          splashColor: Colors.black45,
                                          radius: MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                      Card(
                                        color: Provider.of<CartData>(context, listen: false).order.reversed.toList()[index].status.toString().trim()=="Cancelled"?Colors.black12:Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Cancel",style:Provider.of<CartData>(context, listen: false).order.reversed.toList()[index].status.toString().trim()!="Cancelled"||Provider.of<CartData>(context, listen: false).order.reversed.toList()[index].status.toString().trim()!="Delivered"?TextStyle():TextStyle(decoration: TextDecoration.lineThrough,color: Colors.red),),
                                          ),
                                          onTap:Provider.of<CartData>(context, listen: false).order.reversed.toList()[index].status.toString().trim()=="Cancelled"?null:() {
                                            print('Cancelled');
                                            cancelOrder(Provider.of<CartData>(context, listen: false).order.reversed.toList()[index]
                                                .orderId,context);
                                          },
                                          splashColor: Colors.black45,
                                          radius: MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${Provider.of<CartData>(context, listen: false).order.reversed.toList()[index].status}",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ):Row(
                                children: [
                                  Text(
                                    "Cancelled",
                                    style: TextStyle(
                                      fontSize: 16, color: Colors.red,fontWeight: FontWeight.w600, fontFamily: 'Halyard',),
                                  )
                                ],
                              ),
                            ],
                          ),
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
    );
  }

  void cancelOrder(orderId,context) async {
    UsersModel usersModel = UsersModel();
    var txt = await usersModel.cancel(orderId,Provider.of<CartData>(context, listen: false).profile.email);
    Styles.showWarningToast(Colors.green, txt.toString(), Colors.black, 15);
  }

   int foo() {
    return 1;
   }

  getThem(context,index) {
    return Provider.of<CartData>(context, listen: false).order.reversed.toList()[index].status.toString().trim()!="Delivered"?Row(
      children: [
        Text(
          "Canceled",
          style: TextStyle(
            fontSize: 16, color: Colors.red,fontWeight: FontWeight.w600, fontFamily: 'Halyard',),
        )
      ],
    ):Row(
      children: [
        Text(
          "Delivered",
          style: TextStyle(
            fontSize: 16, color: Styles.price_color,fontWeight: FontWeight.w600, fontFamily: 'Halyard',),
        )
      ],
    );
  }
}
