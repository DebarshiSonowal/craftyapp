import 'package:flutter/material.dart';

class AddressOption extends StatelessWidget {
  String name, phone, pincode, address;

  AddressOption(this.name, this.phone, this.pincode, this.address);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Name:'),
                Text('Phone:'),
                Text('Address:'),
                Text('Pin:'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(name),
                Text(phone),
                Text(address),
                Text(pincode),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
