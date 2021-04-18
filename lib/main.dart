import 'package:crafty/UI/Activity/Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Helper/CartData.dart';
import 'UI/Activity/SplashScreen.dart';
import 'UI/Styling/Styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CartData(),
      child: MaterialApp(
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
      ),
    );
  }
}


