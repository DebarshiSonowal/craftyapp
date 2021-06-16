
import 'package:crafty/Helper/CartData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
class PaymentOptionsMethod extends StatefulWidget {
  var paymentMethod;
  Function(int) onTap;
  var paymentsub = ['UPI, Card, Net Banking...', 'Cash on delivery'];

  var paymentIcon = [
    MaterialCommunityIcons.contactless_payment,
    MaterialCommunityIcons.cash,
    // MaterialCommunityIcons.bank,
    // FontAwesomeIcons.wallet,
    // FontAwesomeIcons.rupeeSign
  ];

  PaymentOptionsMethod({this.paymentMethod, this.onTap});

  @override
  _PaymentOptionsMethodState createState() => _PaymentOptionsMethodState();
}

class _PaymentOptionsMethodState extends State<PaymentOptionsMethod> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // height: MediaQuery.of(context).,
      padding: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Select a payment method",
              style: TextStyle(
                  fontFamily: "Halyard",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
          SizedBox(
            height: 1.h,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView.builder(
                  itemCount: 2,
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
                            radius: MediaQuery.of(context).size.width + 10,
                            splashColor: Colors.black,
                            enableFeedback: true,
                            // onTap: () => widget.onTap(index),
                            onTap: index == 0
                                ? () => widget.onTap(index)
                                : () {
                                    showPaymentDialog(index);
                                  },
                            child: Container(
                                height: 85,
                                width: MediaQuery.of(context).size.width - 10,
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 32),
                                            child:
                                                Icon(widget.paymentIcon[index],size: 5.h,),
                                          )),
                                      Expanded(
                                        flex: 15,
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${widget.paymentMethod[index]}",
                                                style: TextStyle(
                                                    fontFamily: "Halyard",
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                "${widget.paymentsub[index]}",
                                                style: TextStyle(
                                                    fontFamily: "Halyard",
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black45),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Icon(FontAwesome.angle_right))
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                    );
                  }),
              Card(
                elevation: 1.5,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      new BoxShadow(
                        color: Color(0xffE3E3E3),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      child: Text(
                        "Go for contactless payment for your safety.Cash may not be accepted in COVID restricted areas.",
                        style: TextStyle(
                            fontFamily: "Halyard",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w200,
                            color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showPaymentDialog(index) {
    Dialogs.materialDialog(
        customView: Container(
          padding: EdgeInsets.only(left: 1.h, right: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 2.h,
                width: MediaQuery.of(context).size.width,
              ),
              Text("Please Confirm",
                  style: TextStyle(
                      fontFamily: "Halyard",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              SizedBox(
                height: 1.h,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                child: Container(
                  color: Color(0xffE4E4E7),
                ),
                height: 0.4.h,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 1.h,
                width: MediaQuery.of(context).size.width,
              ),
              Text("You have selected to pay on delivery",
                  style: TextStyle(
                      fontFamily: "Halyard",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w200,
                      color: Colors.black)),
              SizedBox(
                height: 4.h,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: EdgeInsets.only(left:15.w, right: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: MaterialButton(
                        onPressed: () => {
                        Navigator.pop(context),
                          widget.onTap(index)},
                        child: Icon(
                          MaterialCommunityIcons.check,
                          size: 6.h,
                          color: Colors.green,
                        ),
                        shape: CircleBorder(
                          side: BorderSide(color: Colors.green, width: 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                      width:4.w,
                    ),
                    Flexible(
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);

                        },
                        child: Icon(
                          MaterialCommunityIcons.close,
                          size: 6.h,
                          color: Colors.redAccent,
                        ),
                        shape: CircleBorder(
                          side: BorderSide(color: Colors.redAccent, width: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        color: Colors.white,
        context: context,
        actions: []);
  }

  getDiscount(context) {
    int post = (Provider.of<CartData>(context).getPrice()).toInt();
    int pre = (Provider.of<CartData>(context).noOfTotalItems * 699);

    return (pre - post) / pre * 100;
  }
}
