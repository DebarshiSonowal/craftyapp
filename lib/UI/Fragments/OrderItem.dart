import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      child: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: Provider.of<CartData>(context, listen: false).order.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
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
                            Text(
                              "Order No:${Provider.of<CartData>(context, listen: false).order[index].orderId}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${Provider.of<CartData>(context, listen: false).order[index].date}",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black45),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Tracking Number:",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black45),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "${Provider.of<CartData>(context, listen: false).order[index].trackingId}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
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
                                      fontSize: 14, color: Colors.black45),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "${Provider.of<CartData>(context, listen: false).order[index].quantity}",
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
                                      fontSize: 14, color: Colors.black45),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "${Provider.of<CartData>(context, listen: false).order[index].price}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
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
                                      Provider.of<CartData>(context,listen: false).orderSelected = Provider.of<CartData>(context,
                                          listen: false)
                                          .order[index];
                                      Test.fragNavigate.putPosit(key: 'Details', force: true);
                                    },
                                    splashColor: Colors.black45,
                                    radius: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                Card(
                                  color: Provider.of<CartData>(context,
                                      listen: false)
                                      .order[index].status.toString().trim()=="Cancelled"?Colors.black12:Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Cancel",style:Provider.of<CartData>(context,
                                          listen: false)
                                          .order[index].status.toString().trim()!="Cancelled"?TextStyle():TextStyle(decoration: TextDecoration.lineThrough,color: Colors.red),),
                                    ),
                                    onTap:Provider.of<CartData>(context,
                                        listen: false)
                                        .order[index].status.toString().trim()=="Cancelled"?null:() {
                                      print('Cancelled');
                                      cancelOrder(Provider.of<CartData>(context,
                                          listen: false)
                                          .order[index]
                                          .orderId,context);
                                    },
                                    splashColor: Colors.black45,
                                    radius: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${Provider.of<CartData>(context, listen: false).order[index].status}",
                              style: TextStyle(color: Colors.green),
                            ),
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
    );
  }

  void cancelOrder(orderId,context) async {
    UsersModel usersModel = UsersModel();
    var txt = await usersModel.cancel(orderId,Provider.of<CartData>(context, listen: false).profile.email);
    Styles.showWarningToast(Colors.green, txt.toString(), Colors.black, 15);
  }
}
