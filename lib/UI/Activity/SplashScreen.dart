import 'dart:async';
import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/Ads.dart';
import 'package:crafty/Models/Categories.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/Activity/Host.dart';
import 'package:crafty/UI/Fragments/NoInternet.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  bool status;
  String access, refresh;
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  static BuildContext syscontext;

  @override
  void initState() {
    // this.initDynamicLinks();
    checkInternet();
    // getLoginData();

    syscontext=context;
    getEverything(_scaffoldKey.currentContext);
    super.initState();
    // checkPrev();

    Timer(Duration(seconds: 3), () => checkPrev());
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 3),
    );
    animationController.repeat();
    // ;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    } catch (e) {
      print(e);
    }
    return Scaffold(
      key: _scaffoldKey,
      body: Consumer<CartData>(
        builder: (context,CartData,child){
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Styles.Log_sign),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new AnimatedBuilder(
                          animation: animationController,
                          child: new Container(
                            height: 200.0,
                            width: 200.0,
                            child: new Image.asset('assets/images/logo.png'),
                          ),
                          builder: (BuildContext context, Widget _widget) {
                            return new Transform.rotate(
                              angle: animationController.value * 6.3,
                              child: _widget,
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 100.0,
                          child: Image(
                              height: 100.0,
                              width: 100.0,
                              image: AssetImage('assets/images/crafty.png')),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Future<bool> checkInternet() async {
    bool result;
    if (kIsWeb) {
      print("Here");
      status = true;
      result = true;
    } else {
      result = await DataConnectionChecker().hasConnection;
      status = result;
    }
    return result;
  }

  void checkPrev() async {
    status == true
        ? Navigator.pushAndRemoveUntil(
            context,
            PageTransition(type: PageTransitionType.fade, child: Host()),
            (r) => false)
        : Navigator.pushAndRemoveUntil(
            context,
            PageTransition(type: PageTransitionType.fade, child: NoInternet()),
            (r) => false);
  }

  void getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var acc = prefs.get('access');
    var ref = prefs.get('refresh');
    if (acc != null && ref != null) {
   setState(() {
     Test.accessToken = acc;
     Test.refreshToken = ref;
   });
    }
  }

  void getEverything(BuildContext context) async {
    Test.getAllProducts(_scaffoldKey.currentContext);
    getLoginData();
    UsersModel usersModel1 = UsersModel();
    UsersModel usersModel3 = UsersModel();
    UsersModel usersModel4 = UsersModel();
    var data = await usersModel1.getRequired();
    if (data != "Server Error") {
      var data1 = data['require'] as List;
      List<Categories> categories =
          data1.map((e) => Categories.fromJson(e)).toList();
      try {
        Provider.of<CartData>(context, listen: false).setCategory(categories);
      } catch (e) {
        print(e);
      }
      var data2 = data['ads'] as List;
      List<Ads> ads = data2.map((e) => Ads.fromJson(e)).toList();
      try {
        Provider.of<CartData>(context, listen: false).setAds(ads);
      } catch (e) {
        print(e);
      }
    } else {
      UsersModel usersModel1 = UsersModel();
      var data = await usersModel1.getRequired();
      var data1 = data['require'] as List;
      List<Categories> categories =
          data1.map((e) => Categories.fromJson(e)).toList();
      try {
        Provider.of<CartData>(context, listen: false).setCategory(categories);
      } catch (e) {
        print(e);
      }
      var data2 = data['ads'] as List;
      List<Ads> ads = data2.map((e) => Ads.fromJson(e)).toList();
      try {
        Provider.of<CartData>(context, listen: false).setAds(ads);
      } catch (e) {
        print(e);
      }
    }
    var UserData = await usersModel4.getUser();
    if (UserData != "User Not Found") {
      Provider.of<CartData>(context, listen: false).updateUser(UserData);
    }
    if (Test.accessToken!=null) {
      var profile = await usersModel3
              .getProf(Provider.of<CartData>(context, listen: false).user.id);
      if (profile != "Server Error" && profile != null) {
        Provider.of<CartData>(context, listen: false).updateProfile(profile);
      }
    }
  }
  // void initDynamicLinks() async {
  //   FirebaseDynamicLinks.instance.onLink(
  //       onSuccess: (PendingDynamicLinkData dynamicLink) async {
  //         final Uri deepLink = dynamicLink?.link;
  //
  //         if (deepLink != null) {
  //           Navigator.pushNamed(context, deepLink.path);
  //         }
  //       },
  //       onError: (OnLinkErrorException e) async {
  //         print('onLinkError');
  //         print(e.message);
  //       }
  //   );
  //
  //   final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
  //   final Uri deepLink = data?.link;
  //
  //   if (deepLink != null) {
  //     Navigator.pushNamed(context, deepLink.path);
  //   }
  // }
}


