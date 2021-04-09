import 'dart:async';
import 'dart:io';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/UI/Activity/Host.dart';
import 'package:crafty/UI/Fragments/NoInternet.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'Login.dart';




class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool status;
  String access,refresh;

  @override
  void initState() {
    checkInternet();
    super.initState();
    // checkPrev();
    Timer(
        Duration(seconds: 2),
            () => checkPrev());
    // ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Styles.Log_sign),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 150.0,
                        child: Image(
                            height: 150,
                            width: 150,
                            image: AssetImage('assets/images/crafty.png')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      backgroundColor: Styles.button_color,
                      valueColor:AlwaysStoppedAnimation<Color>(Colors.white) ,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Center(
                      child: Text(
                        "With love \n"
                            "from\n"
                            "Crafty",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Styles.log_sign_text),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<bool> checkInternet() async {
    bool result;
    if(kIsWeb){
      print("Here");
      status =true;
      result = true;
    }else{
      result = await DataConnectionChecker().hasConnection;
      status = result;

    }
    return result;
  }

  void checkPrev() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var acc = prefs.get('access');
    var ref = prefs.get('refresh');
    if(acc != null && ref != null){
      Test.accessToken = acc;
      Test.refreshToken = ref;
      status==true?Navigator.pushAndRemoveUntil(context,
          PageTransition(type: PageTransitionType.fade, child: Host()),(r)=>false):Navigator.pushAndRemoveUntil(context,
          PageTransition(type: PageTransitionType.fade, child: NoInternet()),(r)=>false);
    }else{
      print("Here");
      status==true?Navigator.pushAndRemoveUntil(context,
          PageTransition(type: PageTransitionType.fade, child: Login()),(r)=>false):Navigator.pushAndRemoveUntil(context,
          PageTransition(type: PageTransitionType.fade, child: NoInternet()),(r)=>false);
    }
  }
}
