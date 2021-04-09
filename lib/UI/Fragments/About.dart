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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                  height: 140,
                  width: 140,
                  image: AssetImage('assets/images/crafty.png')),
              Center(
                  child: Text(
                "Our Team",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileWidget('https://firebasestorage.googleapis.com/v0/b/ygbinoo.appspot.com/o/Crafty%2Fprd.jpg?alt=media&token=513a3ef7-908a-46e9-848e-a03016f27799',"Pratap Das","Co-founder"),
                  ProfileWidget( 'https://firebasestorage.googleapis.com/v0/b/ygbinoo.appspot.com/o/Crafty%2Fkd.jpg?alt=media&token=fdac43bc-c21d-472d-a491-7ab18f4e25c3',"Kakoli Buragohain","Co-founder"),
                  ProfileWidget('https://firebasestorage.googleapis.com/v0/b/ygbinoo.appspot.com/o/Crafty%2Fpd.jpg?alt=media&token=9e895b01-a00d-415b-ab9c-9164918b96fc',"Partha Das","Co-founder"),
                ],
              ),
              ProfileWidget('https://firebasestorage.googleapis.com/v0/b/ygbinoo.appspot.com/o/Crafty%2Fccv.jpg?alt=media&token=f99240ca-bd28-4327-99f4-3262e85a3727',"Debarshi Sonowal","Developer"),
              SizedBox(height: 20,),
              Center(
                  child: Text(
                    "Special Thanks to",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  )),
              Center(
                  child: Text(
                    "Carolina Cajazeira at Lottiefiles.com",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  )),
              Center(
                  child: Text(
                    "Freepik at Flaticon.com",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 30,),
              Center(
                  child: Text(
                    "Thank you for checking us out",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold,color: Colors.red),
                  )),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}


