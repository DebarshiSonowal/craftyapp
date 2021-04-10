import 'package:crafty/UI/CustomWidgets/ProfileWidget.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.bg_color,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Image(
                    image: AssetImage('assets/images/crafty.png')),
              ),
              Flexible(
                flex: 1,
                child: Center(
                    child: Text(
                  "Our Team",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ),
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileWidget('https://firebasestorage.googleapis.com/v0/b/ygbinoo.appspot.com/o/Crafty%2Fprd.jpg?alt=media&token=513a3ef7-908a-46e9-848e-a03016f27799',"Pratap Das","Co-founder"),
                    ProfileWidget( 'https://firebasestorage.googleapis.com/v0/b/ygbinoo.appspot.com/o/Crafty%2Fkd.jpg?alt=media&token=fdac43bc-c21d-472d-a491-7ab18f4e25c3',"Kakoli Buragohain","Co-founder"),
                    ProfileWidget('https://firebasestorage.googleapis.com/v0/b/ygbinoo.appspot.com/o/Crafty%2Fpd.jpg?alt=media&token=9e895b01-a00d-415b-ab9c-9164918b96fc',"Partha Das","Co-founder"),
                  ],
                ),
              ),
              Flexible(
                  flex: 3,
                  child: ProfileWidget('https://firebasestorage.googleapis.com/v0/b/ygbinoo.appspot.com/o/Crafty%2Fccv.jpg?alt=media&token=f99240ca-bd28-4327-99f4-3262e85a3727',"Debarshi Sonowal","Developer")),
              Flexible(
                flex: 1,
                child: Center(
                    child: Text(
                      "Special Thanks to",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ),
              Flexible(
                flex: 1,
                child: Center(
                    child: Text(
                      "Carolina Cajazeira at Lottiefiles.com",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    )),
              ),
              Flexible(
                flex: 1,
                child: Center(
                    child: Text(
                      "Freepik at Flaticon.com",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    )),
              ),
              Flexible(
                flex: 1,
                child: Center(
                    child: Text(
                      "Thank you for checking us out",
                      style: TextStyle(fontSize:18, fontWeight: FontWeight.bold,color: Colors.red),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


