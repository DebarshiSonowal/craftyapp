import 'dart:async';
import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/Profile.dart';
import 'package:crafty/UI/CustomWidgets/Gender.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  var email, name, pin, phone, address;
  final double paddingNo = 5.0;
  String nm, ids;
  Profile profile;
  var nT = TextEditingController();
  var pinT = TextEditingController();
  var phT = TextEditingController();
  var addT = TextEditingController();
  var o = 0;
  ProgressDialog pr;
  String _gender, def;

  void _onRefresh() async {
    if (Test.accessToken != null && Test.refreshToken != null) {
      await pr.show();
      UsersModel usersModel = UsersModel();
      // Profile profile = Provider.of<CartData>(context, listen: false).profile;
      try {
        profile = await usersModel
            .getProf(Provider.of<CartData>(context, listen: false).user.id);
        print("Address ${profile.address}");
        _refreshController.refreshCompleted();
        pr.hide().then((isHidden) {
          print(isHidden);
        });
      } catch (e) {
        print("error ${e}");
        _refreshController.refreshFailed();
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
      }
      setDataToFields(profile);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please Login first'),
        action: SnackBarAction(
          label: 'Next',
          onPressed: () {
            setState(() {
              Test.fragNavigate.putPosit(key:'Login');
            });
          },
        ),
      ));
      _refreshController.refreshFailed();
    }
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
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

    nT = TextEditingController();
    pinT = TextEditingController();
    phT = TextEditingController();
    addT = TextEditingController();
    Timer(Duration(milliseconds: 500), () {
      if (Provider.of<CartData>(context, listen: false).profile == null) {
        _onRefresh();
      } else {
        setDataToFields(Provider.of<CartData>(context, listen: false).profile);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 75.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: new Container(
                        width: 190.0,
                        height: 190.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: Image.asset("assets/images/user.png")
                                    .image))),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      new Text(
                        nm == null ? "Name" : nm,
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        email == null ? "" : email,
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: nT,
                  onChanged: (text) {
                    name = text;
                  },
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Styles.log_sign_text),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Styles.log_sign_text),
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
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: addT,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black),
                  onChanged: (txt) {
                    address = txt;
                  },
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Styles.log_sign_text),
                    labelText: "Address",
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
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: phT,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Colors.black),
                  onChanged: (txt) {
                    phone = txt;
                  },
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Styles.log_sign_text),
                    labelText: "Phone",
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
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: TextField(
                  controller: pinT,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  style: TextStyle(color: Colors.black),
                  onChanged: (txt) {
                    pin = txt;
                  },
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Styles.log_sign_text),
                    labelText: "Pincode",
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
              TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password",
                  style: TextStyle(color: Styles.log_sign_text),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: GenderField(
                    genderList: ['Male', 'Female'],
                    def: def,
                    callback: (value) {
                      _gender = value;
                      print(value);
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, right: 5.0, bottom: 10.0, top: 5.0),
                child: FlatButton(
                  height: MediaQuery.of(context).size.width / 7,
                  minWidth: MediaQuery.of(context).size.width,
                  splashColor: Colors.white,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(6.0)),
                  padding: EdgeInsets.all(8),
                  color: Styles.button_color,
                  onPressed: () {
                    print(pinT.text);
                    if (nT.text.isNotEmpty &&
                        email != null &&
                        phT.text.isNotEmpty &&
                        pinT.text.isNotEmpty &&
                        addT.text.isNotEmpty) {
                      if (phT.text.length == 10) {
                        if (pinT.text.length == 6) {
                          if (_gender != null) {
                            if (Test.accessToken != null &&
                                Test.refreshToken != null) {
                              saveProfile(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Please Login first'),
                                action: SnackBarAction(
                                  label: 'Next',
                                  onPressed: () {
                                    setState(() {
                                      Test.fragNavigate.putPosit(key:'Login');
                                    });
                                  },
                                ),
                              ));
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please select a gender",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please enter a valid pincode",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Enter a valid phone no",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.black,
                            fontSize: 16.0);
                      }
                    } else {
                      print("DD");
                      Fluttertoast.showToast(
                          msg: "Please enter required fields",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.black,
                          fontSize: 16.0);
                    }
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Styles.button_text_color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nT.dispose();
    pinT.dispose();
    phT.dispose();
    addT.dispose();
  }

  void getProfileDatat(id) async {
    UsersModel usersModel = UsersModel();
    // Profile profile = Provider.of<CartData>(context).profile;
    var data;
    try {
      print("ddd");
      data = await usersModel.getProf(id);
      print(data.address);
    } catch (e) {
      print(e);
    }
    if (data.toString() != "Server Error") {
      print(data.address);
      nT.text = data.name.toString();
      email = data.email.toString();
      nm = data.name.toString();
      print(data.id);
      ids = data.id.toString();
      setState(() {
        def = data.gender;
        _gender = data.gender;
        print(data.gender);
      });
      addT.text = data.address == null ? "" : data.address.toString();
      pinT.text = data.pincode == null ? "" : data.pincode.toString();
      phT.text = data.phone == null ? "" : data.phone.toString();
      Provider.of<CartData>(context, listen: false).updateProfile(data);
      o++;
    } else {
      Fluttertoast.showToast(
          msg: "Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  void saveProfile(BuildContext context) async {
    await pr.show();
    UsersModel usersModel = new UsersModel();
    print(_gender);
    print("CCCcc");
    var data = await usersModel.saveProf(Profile(ids, nT.text, email, addT.text,
        int.parse(phT.text), int.parse(pinT.text), _gender));
    print(data);
    if (data != null) {
      pr.hide().then((isHidden) {
        print(isHidden);
        Fluttertoast.showToast(
            msg: "Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: 16.0);
        Provider.of<CartData>(context, listen: false).updateProfile(Profile(
            ids,
            nT.text,
            email,
            addT.text,
            int.parse(phT.text),
            int.parse(pinT.text),
            _gender));
        print(
            "Vxvz ${Provider.of<CartData>(context, listen: false).profile.address}");
        _onRefresh();
      });
    } else {
      pr.hide().then((isHidden) {
        print(isHidden);
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: 16.0);
      });
    }
  }

  void setDataToFields(Profile profile) {
    nT.text = profile.name.toString();
    email = profile.email.toString();
    nm = profile.name.toString();
    ids = profile.id.toString();
    setState(() {
      def = profile.gender;
      _gender = profile.gender;
    });
    addT.text = profile.address == null ? "" : profile.address.toString();
    pinT.text = profile.pincode == null ? "" : profile.pincode.toString();
    phT.text = profile.phone == null ? "" : profile.phone.toString();
  }
}
