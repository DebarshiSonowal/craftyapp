import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Models/Address.dart';
import 'package:crafty/Models/Profile.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewAddressPage extends StatefulWidget {
  NewAddressPage({Key key}) : super(key: key);

  @override
  _NewAddressPageState createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  var name,
      pin,
      phone,
      address,
      addressline1,
      town_village,
      district,
      state;

  final double paddingNo = 5.0;

  String nm, ids;

  Profile profile;

  bool enabled = false;

  var nT = TextEditingController();

  var pinT = TextEditingController();

  var phT = TextEditingController();

  var addT1 = TextEditingController();

  var addTtown = TextEditingController();

  var addTdis = TextEditingController();

  var addTstate = TextEditingController();

  FocusNode focusNodeFullname= FocusNode();FocusNode focusNodePhone= FocusNode();
  FocusNode focusNodePin= FocusNode();FocusNode focusNodeAdd1= FocusNode();
  FocusNode focusNodeTown= FocusNode();FocusNode focusNodeDis= FocusNode();
  FocusNode focusNodeState= FocusNode();
  @override
  Widget build(BuildContext context) {
    Provider.of<CartData>(context, listen: false).removeAddress();
    return Container(
      color: Color(0xffF2F2F2),
      padding: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "CONTACT DETAILS",
            style: TextStyle(
                fontFamily: "Halyard",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            elevation: 1,
            child: Container(
              decoration: BoxDecoration(
                color:Color(0xffF9F9F9),
                // color: Color(0xffE3E3E3),
                boxShadow: [
                  new BoxShadow(
                    color: Color(0xffE3E3E3),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    focusNode: focusNodeFullname,
                    onTap: (){
                      _requestFoucs(focusNodeFullname);
                    },
                    controller: nT,
                    onChanged: (text) {},
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        fontFamily: "Halyard",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      labelStyle: TextStyle(
                          fontFamily: "Halyard",
                          fontSize: 14,
                          color: focusNodeFullname.hasFocus?Styles.price_color:Colors.black45),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Styles.price_color, width: 1.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                  ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    focusNode: focusNodePhone,
                    onTap: (){
                      _requestFoucs(focusNodePhone);
                    },
                    maxLength: 10,
                    controller: phT,
                    keyboardType: TextInputType.phone,
                    onChanged: (txt) {
                      // enabled = checknull(
                      //     Provider.of<CartData>(context, listen: false)
                      //         .profile);
                      phone = txt;
                    },
                    style: TextStyle(
                        fontFamily: "Halyard",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                      labelText: "Phone",
                      labelStyle: TextStyle(
                          fontFamily: "Halyard",
                          fontSize: 14,
                          color: focusNodePhone.hasFocus?Styles.price_color:Colors.black45),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Styles.price_color, width: 1.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "ADDRESS",
            style: TextStyle(
                fontFamily: "Halyard",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            elevation: 1,
            child: Container(
              decoration: BoxDecoration(
                color:Color(0xffF9F9F9),
                // color: Color(0xffE3E3E3),
                boxShadow: [
                  new BoxShadow(
                    color: Color(0xffE3E3E3),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    focusNode: focusNodeAdd1,
                    onTap: (){
                      _requestFoucs(focusNodeAdd1);
                    },
                    controller: addT1,
                    keyboardType: TextInputType.text,
                    onChanged: (txt) {
                      addressline1 = txt;
                    },
                    style: TextStyle(
                        fontFamily: "Halyard",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                      labelText: "Address (House no,Building,Street,Area)",
                      labelStyle: TextStyle(
                          fontFamily: "Halyard",
                          fontSize: 14,
                          color: focusNodeAdd1.hasFocus?Styles.price_color:Colors.black45),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Styles.price_color, width: 1.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    focusNode: focusNodeTown,
                    onTap: (){
                      _requestFoucs(focusNodeTown);
                    },
                    controller: addTtown,
                    keyboardType: TextInputType.text,
                    onChanged: (txt) {
                      town_village = txt;
                    },
                    style: TextStyle(
                        fontFamily: "Halyard",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                      labelText: "Town/Village",
                      labelStyle: TextStyle(
                          fontFamily: "Halyard",
                          fontSize: 14,
                          color: focusNodeTown.hasFocus?Styles.price_color:Colors.black45),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Styles.price_color, width: 1.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    focusNode: focusNodeDis,
                    onTap: (){
                      _requestFoucs(focusNodeDis);
                    },
                    controller: addTdis,
                    keyboardType: TextInputType.text,
                    onChanged: (txt) {
                      district = txt;
                    },
                    style: TextStyle(
                        fontFamily: "Halyard",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                      labelText: "District",
                      labelStyle: TextStyle(
                          fontFamily: "Halyard",
                          fontSize: 14,
                          color: focusNodeDis.hasFocus?Styles.price_color:Colors.black45),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Styles.price_color, width: 1.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            focusNode: focusNodePin,
                            onTap: (){
                              _requestFoucs(focusNodePin);
                            },
                            controller: pinT,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            onChanged: (txt) {
                              pin = txt;
                            },
                            style: TextStyle(
                                fontFamily: "Halyard",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black
                            ),
                            decoration: InputDecoration(
                              labelText: "Pin code",
                              labelStyle: TextStyle(
                                  fontFamily: "Halyard",
                                  fontSize: 14,
                                  color: focusNodePin.hasFocus?Styles.price_color:Colors.black45),
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Styles.price_color, width: 1.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 22),
                            child: TextFormField(
                              focusNode: focusNodeState,
                              onTap: (){
                                _requestFoucs(focusNodeState);
                              },
                              controller: addTstate,
                              keyboardType: TextInputType.text,
                              onChanged: (txt) {
                                state = txt;
                              },
                              style: TextStyle(
                                  fontFamily: "Halyard",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black
                              ),
                              decoration: InputDecoration(
                                labelText: "State",
                                labelStyle: TextStyle(
                                    fontFamily: "Halyard",
                                    fontSize: 14,
                                    color: focusNodeState.hasFocus?Styles.price_color:Colors.black45),
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Styles.price_color, width: 1.0),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  if (nT.text.isNotEmpty &&
                      addT1.text.isNotEmpty &&
                      addTdis.text.isNotEmpty &&
                      addTstate.text.isNotEmpty &&
                      addTtown.text.isNotEmpty &&
                      phT.text.isNotEmpty &&
                      pinT.text.isNotEmpty) {
                    if (phT.text.toString().length==10) {
                      if (pinT.text.toString().length==6) {
                        if(Provider.of<CartData>(context, listen: false)
                            .profile==null||Provider.of<CartData>(context, listen: false)
                            .profile.address==null){
                          saveProfile(context);
                        }else{
                          print("Here");
                          NewAddress(context);
                        }
                      } else {
                        Styles.showWarningToast(Colors.red,
                            "Please Enter a valid pincode", Colors.white, 17);
                      }
                    } else {
                      Styles.showWarningToast(Colors.red,
                          "Please Enter a valid phone no", Colors.white, 17);
                    }
                  } else {
                    Styles.showWarningToast(Colors.red,
                        "Please Enter all the details", Colors.white, 17);
                  }
                },
                style: ButtonStyle(
                  enableFeedback: true,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  )),
                  backgroundColor: MaterialStateProperty.all(Styles.price_color),
                  shadowColor: MaterialStateProperty.all(Color(0xffE3E3E3)),
                  elevation: MaterialStateProperty.all(4),
                  overlayColor: MaterialStateProperty.resolveWith(
                    (states) {
                      return states.contains(MaterialState.pressed)
                          ? Color(0xffE3E3E3)
                          : null;
                    },
                  ),
                ),
                child: Container(
                  child: Center(
                    child: Text("Proceed",
                        style: TextStyle(
                            fontFamily: "Halyard",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  void SetSelectedAddress(address, phone, pincode, context) {
    Provider.of<CartData>(context, listen: false)
        .setAddress(Address(address, phone, pincode));
    Navigator.pop(context);
  }

  void NewAddress(BuildContext context) {
    print("giot a");
    SetSelectedAddress(getAddress(), phT.text, pinT.text, context);
  }
  void saveProfile(BuildContext context) async {
    UsersModel usersModel = new UsersModel();
    var data = await usersModel.saveProf(Profile(ids, nT.text, Provider.of<CartData>(context, listen: false)
        .user.email,
        getAddress(), int.parse(phT.text), int.parse(pinT.text), null));
    if (data != null) {
      Provider.of<CartData>(context, listen: false).updateProfile(Profile(
          ids,
          nT.text,
          Provider.of<CartData>(context, listen: false)
              .user.email,
          getAddress(),
          int.parse(phT.text),
          int.parse(pinT.text),
          null));
      NewAddress(context);
    } else {
      NewAddress(context);
    }
  }
  String getAddress() {
    return addT1.text.trim() +
        "," +
        addTtown.text.trim() +
        "," +
        addTdis.text.trim() +
        "," +
        addTstate.text.trim();
  }
  void _requestFoucs(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }
}
