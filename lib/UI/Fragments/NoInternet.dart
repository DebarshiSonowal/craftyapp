import 'package:crafty/UI/Activity/Host.dart';
import 'package:crafty/UI/Activity/Login.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';



class NoInternet extends StatelessWidget {
  bool status;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(
                height: 150,
                width: 150,
                image: AssetImage('assets/images/nointernet.png')),
            Text(
              "No Internet Connection",
              style: TextStyle(
                color: Colors.red,
                fontSize: 21,
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  checkInternet();
                  if(await DataConnectionChecker().hasConnection){
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                        type: PageTransitionType.fade, child: Host()),(r) => false);
                  }else{
                    Fluttertoast.showToast(
                        msg: "Failed",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.black,
                        fontSize: 16.0);
                  }
                },
                child: Text("Refresh")),
          ],
        ),
      ),
    );
  }

  Future<bool> checkInternet() async {
    bool result = await DataConnectionChecker().hasConnection;
    status = result;
    return result;
  }
}
