import 'package:crafty/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';

class AddressOption extends StatelessWidget {
  String name, phone, pincode, address;

  AddressOption(this.name, this.phone, this.pincode, this.address);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color:Styles.Log_sign,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name:',style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),),
                  Text('Phone:',style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
                  Text('Pin:',style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
                  Text('Address:',style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name,style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
                  Text(phone,style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
                  Text(address,style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
                  Text(pincode,style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
