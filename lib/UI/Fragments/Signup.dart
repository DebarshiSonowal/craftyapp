import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/SignUpData.dart';
import 'package:crafty/UI/CustomWidgets/Gender.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Signup extends StatefulWidget {
  final FragNavigate fragNavigate;

  Signup({this.fragNavigate});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<Signup> {
  ProgressDialog pr;
  String _gender;
  bool _agree = false;
  bool _isHidden = true;
  bool _isHidden1 = true;
  var email, password, name, cnfpass;
  final em = TextEditingController();
  final pass = TextEditingController();
  final nm = TextEditingController();
  final cnf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Material(
          color: Styles.bg_color,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width / 9,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                          color: Styles.log_sign_text,
                          fontWeight: FontWeight.bold,
                          fontSize: 26),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: nm,
                    onChanged: (text) {
                      name = text;
                    },
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Fullname",
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
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: em,
                    onChanged: (text) {
                      email = text;
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
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: pass,
                    keyboardType: TextInputType.text,
                    onChanged: (text) {
                      password = text;
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
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: cnf,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                    onChanged: (text) {
                      cnfpass = text;
                    },
                    obscureText: _isHidden1,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      filled: true,
                      suffix: InkWell(
                        onTap: _togglePasswordView1,
                        child: Icon(
                          _isHidden1 ? Icons.visibility : Icons.visibility_off,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      fillColor: MyColor(),
                      checkColor: Colors.white,
                      activeColor: Colors.red,
                      value: _agree,
                      onChanged: (bool value) {
                        setState(() {
                          print(value);
                          _agree = value;
                        });
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        _launchURL();
                      },
                      child: Text(
                        "Agree to our terms and conditions",
                        style: TextStyle(
                          color: Styles.log_sign_text,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Already have an account?",
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Styles.log_sign_text),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Test.fragNavigate.putPosit(key: 'Login');
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Styles.hyperlink,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: GenderField(
                      genderList: ['Male', 'Female'],
                      callback: (value) {
                        _gender = value;
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FlatButton(
                    splashColor: Colors.white,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    padding: EdgeInsets.all(8),
                    height: 50,
                    color: Styles.button_color,
                    onPressed: () async {
                      initLoader();

                      if (name != null &&
                          password != null &&
                          email != null &&
                          cnfpass != null) {
                        if (password == cnfpass) {
                          if (_agree == true) {
                            if (_gender != null) {
                              if (EmailValidator.validate(email)) {
                                await pr.show();
                                signUp(name, password, email);
                              }else {
                                Styles.showWarningToast(Colors.red,
                                    "Enter a valid Email", Colors.white, 15);
                              }
                            } else {
                              Styles.showWarningToast(Colors.red,
                                  "Select a gender", Colors.white, 15);
                            }
                          } else {
                            Styles.showWarningToast(
                                Colors.red,
                                "Please agree to our terms and conditions",
                                Colors.white,
                                15);
                          }
                        } else {
                          Styles.showWarningToast(
                              Colors.red,
                              "Password and confirm password are not matching",
                              Colors.white,
                              15);
                        }
                      } else {
                        Styles.showWarningToast(
                            Colors.red,
                            "Please fill all the necessary fields",
                            Colors.white,
                            15);
                      }
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 20,
                        color: Styles.button_text_color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
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

  void _togglePasswordView1() {
    setState(() {
      _isHidden1 = !_isHidden1;
    });
  }

  void signUp(name, password, email) async {
    UsersModel usersModel = UsersModel();
    var data = await usersModel
        .signuP(SignUpData(password, email, name, null, _gender));
    if (data != null) {
      if (data != "409") {
        pr.hide().then((isHidden) {
          print(isHidden);
        });
        Styles.showWarningToast(Colors.green,
            "SignUp Successful ${data["name"]}", Colors.white, 15);
        Test.fragNavigate.putPosit(key: 'Login');
      } else {
        pr.hide().then((isHidden) {
          print(isHidden);
        });
        Styles.showWarningToast(
            Colors.red, "User Already Exists", Colors.white, 15);
        clearTexts();
      }
    } else {
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      Styles.showWarningToast(
          Colors.red, "Please Try Again Later", Colors.white, 15);
    }
  }

  Future<void> initLoader() {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
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
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
  }

  @override
  void dispose() {
    nm.dispose();
    em.dispose();
    pass.dispose();
    cnf.dispose();
    super.dispose();
  }

  void clearTexts() {
    nm.clear();
    em.clear();
    pass.clear();
    cnf.clear();
  }

  void _launchURL() async {
    const urls =
        'https://www.freeprivacypolicy.com/live/2bed81fc-8c4f-4fe6-8015-8fcdcb5cc8e0';
    var url = Uri.encodeFull(urls);
    // var url = Uri.encodeComponent(urls);
    try {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false, forceWebView: false);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    }
  }
}

class MyColor extends MaterialStateColor {
  static const _defaultColor = Colors.black;
  static const _pressedColor = Colors.black;

  const MyColor() : super(0);

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return _pressedColor;
    }
    return _defaultColor;
  }
}
