import 'package:crafty/UI/Activity/Login.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'Helper/CartData.dart';
import 'UI/Activity/SplashScreen.dart';
import 'UI/Styling/Styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // AppUpdateInfo _updateInfo;
  //
  // GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  //
  // bool _flexibleUpdateAvailable = false;
  // Future<void> checkForUpdate() async {
  //   InAppUpdate.checkForUpdate().then((info) {
  //     setState(() {
  //       _updateInfo = info;
  //     });
  //   }).catchError((e) {
  //     showSnack(e.toString());
  //   });
  // }
  // void showSnack(String text) {
  //   if (_scaffoldKey.currentContext != null) {
  //     ScaffoldMessenger.of(_scaffoldKey.currentContext)
  //         .showSnackBar(SnackBar(content: Text(text)));
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // checkForUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CartData(),
      child: Sizer(builder: (context,orientation,deviceType){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            'login': (context) => Login(),
          },
          title: 'Crafty',
          theme: ThemeData(
            // primarySwatch: Colors.yellow,
            primaryColor: Styles.Log_sign,
            backgroundColor: Styles.bg_color,
            buttonColor: Styles.button_color,
          ),
          home: SplashScreen(),
        );
      }),
    );
  }
}


