import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Styles {
  static const Log_sign = Color(0xffFFD819);
  static const bg_color = Color(0xffF4F3F3);
  static const log_sign_text = Colors.black;
  static const button_color = Colors.black;
  static const button_text_color = Colors.white;
  static const hyperlink = Colors.black;
  static const url = "https://officialcraftybackend.herokuapp.com/users/";
// static const url = "http://10.0.2.2:3000/users/";
//static const url = "http://localhost:3000/users/";
  static void showWarningToast(
      Color colors, String txt, Color txtcolor, double size) {
    Fluttertoast.showToast(
        msg: txt,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colors,
        textColor: txtcolor,
        fontSize: size == null ? 16.0 : size);
  }

  static void showSnackBar(BuildContext context, Color background,
      Duration duration, String txt, Color textcolor, Function onTap) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: background == null ? Styles.Log_sign : background,
      duration: duration == null ? Duration(seconds: 5) : duration,
      content: Text(
        txt,
        style: TextStyle(color: textcolor),
      ),
      action: SnackBarAction(
        textColor: textcolor,
        label: 'Next',
        onPressed: onTap,
      ),
    ));
  }

  static void showBottomSheet(BuildContext context,Function child){
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return child(context);
        });
  }
}
