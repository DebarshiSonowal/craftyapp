
import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/User.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
//Zakaria Jawas
//utsav
//Abby Ambrogi
  var RESULT;

  @override
  Widget build(BuildContext context) {
    print("The result is ${CartData.TXT}");
    setState(() {
      RESULT = CartData.RESULT;
    });
    print(CartData.RESULT);
    return Material(
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xffE3E3E6),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color(0xffFAFAFA),
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.1), BlendMode.dstATop),
                      image: AssetImage('assets/images/doodleWall.jpg'),
                    ),
                  ),
                ),
                Wrap(
                  children: [
                    Card(
                      elevation: 1.5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          boxShadow: [
                            new BoxShadow(
                              color: Color(0xffE3E3E3),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width - 40,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 12),
                                child: Icon(
                                  FontAwesomeIcons.smile,
                                  size: 5.h,
                                  color: getColor(),
                                ),
                              ),
                              Text(
                                getMsg(),
                                style: TextStyle(
                                    fontFamily: "Halyard",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: getColor()),
                              ),
                              getSecondMSg(),
                              getEmail(),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                height: 7.h,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    getButton(),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          clearOldData();
                                          Test.fragNavigate.putPosit(key: 'Home');
                                        },
                                        style: ButtonStyle(
                                          enableFeedback: true,
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                              )),
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              Styles.price_color),
                                          shadowColor:
                                          MaterialStateProperty.all(
                                              Color(0xffE3E3E3)),
                                          elevation:
                                          MaterialStateProperty.all(4),
                                          overlayColor:
                                          MaterialStateProperty.resolveWith(
                                                (states) {
                                              return states.contains(
                                                  MaterialState.pressed)
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
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white)),
                                          ),
                                        ),
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
                  ],
                ),
              ],
            ),
          )),
    );
  }

  @override
  void initState() {
    // updateOrder();
    super.initState();
    print("AVAVvv ${getAsset()}");
//
  }

  getAsset() {
    if (CartData.RESULT== "SUCCESS") {
      return FontAwesomeIcons.smile;
    } else {
      return FontAwesomeIcons.sadTear;
    }
  }

  getSecondMSg() {
    if (CartData.RESULT == "SUCCESS") {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Order ID: ",
                style: TextStyle(
                    fontFamily: "Halyard",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
              Text(
                "${CartData.id}",
                style: TextStyle(
                    fontFamily: "Halyard",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Order Amount: ",
                style: TextStyle(
                    fontFamily: "Halyard",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
              Text(
                "${CartData.price}",
                style: TextStyle(
                    fontFamily: "Halyard",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),

        ],
      );
    } else {
      return Column(
        children: [
          Text(
            "We could not process your order.",
            style: TextStyle(
                fontFamily: "Halyard",
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: Colors.black54),
          ),
          Text(
            "We regret the inconvenience",
            style: TextStyle(
                fontFamily: "Halyard",
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: Colors.black54),
          ),
          Text(
            "Please Try Again",
            style: TextStyle(
                fontFamily: "Halyard",
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: Colors.black54),
          ),
        ],
      );
    }
  }

  getColor() {
    if (CartData.RESULT == "SUCCESS") {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  void updateOrder() async {
    UsersModel usersModel = UsersModel();
    var order = await usersModel.getOrdersforUser(
        Provider.of<CartData>(context, listen: false).user.id);
    if (order != null) {
      setState(() {
        Provider.of<CartData>(context, listen: false).orders(order);
      });
    }
  }


  String getMsg() {
    if (CartData.RESULT == "SUCCESS") {
      return "Order placed successfully";
    } else {
      return "Sorry";
    }
  }

  getEmail() {
    if (CartData.RESULT== "SUCCESS") {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: Container(
                color: Color(0xffE4E4E7),
              ),
              height: 1.5,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Text(
            "A confirmation email has been sent to",
            style: TextStyle(
                fontFamily: "Halyard",
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Colors.black54),
          ),
          Text(
            "${Provider.of<CartData>(context).profile.email}",
            style: TextStyle(
                fontFamily: "Halyard",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
        ],
      );
    }else {
      return Container();
    }
  }

  getButton() {
    if (CartData.RESULT== "SUCCESS") {
      return Expanded(
        child: ElevatedButton(
          onPressed: () {
            clearOldData();
            Test.fragNavigate.putPosit(key: 'Orders');
          },
          style: ButtonStyle(
            enableFeedback: true,
            shape: MaterialStateProperty.all<
                RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                )),
            backgroundColor:
            MaterialStateProperty.all(
                Colors.white),
            shadowColor:
            MaterialStateProperty.all(
                Color(0xffE3E3E3)),
            elevation:
            MaterialStateProperty.all(4),
            overlayColor:
            MaterialStateProperty.resolveWith(
                  (states) {
                return states.contains(
                    MaterialState.pressed)
                    ? Color(0xffE3E3E3)
                    : null;
              },
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(
                left: 4,
                right: 4,
                top: 7,
                bottom: 7),
            child: Center(
              child: Text("View Order history",
                  style: TextStyle(
                      fontFamily: "Halyard",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ),
          ),
        ),
      );
    }else {
      return Expanded(
        child: ElevatedButton(
          onPressed: () {
            clearOldData();
            Test.fragNavigate.putPosit(key: 'Cart');
          },
          style: ButtonStyle(
            enableFeedback: true,
            shape: MaterialStateProperty.all<
                RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                )),
            backgroundColor:
            MaterialStateProperty.all(
                Colors.white),
            shadowColor:
            MaterialStateProperty.all(
                Color(0xffE3E3E3)),
            elevation:
            MaterialStateProperty.all(4),
            overlayColor:
            MaterialStateProperty.resolveWith(
                  (states) {
                return states.contains(
                    MaterialState.pressed)
                    ? Color(0xffE3E3E3)
                    : null;
              },
            ),
          ),
          child: Container(
            child: Center(
              child: Text("Go back",
                  style: TextStyle(
                      fontFamily: "Halyard",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ),
          ),
        ),
      );
    }
  }

  void clearOldData() {
    CartData.RESULT = null;
    CartData.price = null;
    CartData.id = null;
    CartData.TXT = null;
  }
}
