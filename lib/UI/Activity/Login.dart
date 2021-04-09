import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/LoginData.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Host.dart';
import 'Signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ProgressDialog pr;
  String email, password;
  bool _isHidden = true;
  TextEditingController em, pass;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Material(
          color: Color(0xffEED600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                    height: 150,
                    width: 150,
                    image: AssetImage('assets/images/crafty.png')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  onChanged: (txt) {
                    email = txt;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Email",
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  onChanged: (txt) {
                    password = txt;
                  },
                  style: TextStyle(color: Colors.black),
                  obscureText: _isHidden,
                  decoration: InputDecoration(
                    labelText: "Password",
                    filled: true,
                    suffix: InkWell(
                      onTap: _togglePasswordView,
                      child: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text("Forgot Password",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FlatButton(
                  splashColor: Colors.white,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  padding: EdgeInsets.all(8),
                  height: 50,
                  color: Colors.black,
                  onPressed: () async {
                    pr = ProgressDialog(context,
                        type: ProgressDialogType.Normal,
                        isDismissible: false,
                        showLogs: true);
                    pr.style(
                        message: 'Please Wait....',
                        borderRadius: 10.0,
                        backgroundColor: Colors.white,
                        progressWidget: CircularProgressIndicator(),
                        elevation: 10.0,
                        insetAnimCurve: Curves.easeInOut,
                        progress: 0.0,
                        maxProgress: 100.0,
                        progressTextStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400),
                        messageTextStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 19.0,
                            fontWeight: FontWeight.w600));
                    if (email == null && password == null) {
                      Fluttertoast.showToast(
                          msg: "Please enter required fields",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.black,
                          fontSize: 16.0);
                      print("ADAD");
                      // LogIn(email,password);

                    } else {
                      await pr.show();
                      LogIn(email, password);
                    }
                  },
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Don't have an account?",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, 'SignUp');
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade, child: Signup()));
                    },
                    child: Text("Signup",style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 1,
                    width: MediaQuery.of(context).size.width / 5,
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Other methods",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    width: MediaQuery.of(context).size.width / 5,
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  color: Colors.black,
                  splashColor: Colors.grey,
                  icon: Icon(FontAwesomeIcons.google),
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg: "Coming soon",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.black,
                        fontSize: 16.0);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void LogIn(String email, String password) async {
    UsersModel usersModel = UsersModel();
    var b= LoginData(password, email, null);
    print("${b.email},${b.password}");
    var data = await usersModel.login(b);
    if (data != null && data != "User not found" && data != "Server Error") {
      Test.accessToken = data["accessToken"];
      Test.refreshToken = data["refreshToken"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("access", data["accessToken"]);
      await prefs.setString("refresh", data["refreshToken"]);
      Fluttertoast.showToast(
          msg: "Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.black,
          fontSize: 16.0);
      pr.hide().then((isHidden) {
        print(isHidden);
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(type: PageTransitionType.fade, child: Host()),
                (r) => false);
      });
    } else if(data == "Server Error"){
      pr.hide().then((isHidden) {
        print(isHidden);
        Fluttertoast.showToast(
            msg: "Something is wrong. Please try again later",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: 16.0);
      });
    }else {
      pr.hide().then((isHidden) {
        print(isHidden);
        print("Password or email is wrong");
        Fluttertoast.showToast(
            msg: "Email or password is wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: 16.0);
      });
    }
  }
  void hidePr(){
    pr.hide().then((isHidden) {
      print(isHidden);
      print("Password or email is wrong");
      Fluttertoast.showToast(
          msg: "Email or password is wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.black,
          fontSize: 16.0);
    });
  }
}
