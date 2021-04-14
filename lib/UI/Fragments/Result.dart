
import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/UI/Activity/Host.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../main.dart';


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
   setState(() {
     RESULT =CartData.RESULT;
   });
    print(CartData.RESULT);
    return Material(
      child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width / 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                    flex: 3,
                    child: Lottie.asset(CartData.RESULT)),
                Flexible(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "The Reference ID is ${CartData.TXT}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "Do not close this",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    )),
                Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          ElevatedButton(onPressed: () {
                            if (RESULT!="assets/raw/loading.json") {
                              Test.fragNavigate.putPosit(key: 'Home');
                              RESULT="assets/raw/loading.json";
                            } else {
                              Styles.showWarningToast(Styles.bg_color, "Please Wait", Colors.black, 15);
                            }
                          }, child: Text("Next")),
                    )),
              ],
            ),
          )),
    );
  }

  String getAsset() {
    if(CartData.RESULT == "Successful") {
      setState(() {
        return "assets/raw/successful.json";
      });
    }else if(CartData.RESULT == "Please Wait"){
      setState(() {
        return "assets/raw/failed.json";
      });
    }else{
      return "assets/raw/loading.json";
    }

  }
}
