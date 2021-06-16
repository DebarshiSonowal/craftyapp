import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class ContactIconButton extends StatelessWidget {
  const ContactIconButton(
      this.OnTap, this.splash, this.iconData, this.iconColor);

  final Function OnTap;
  final splash;
  final IconData iconData;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: IconButton(
        iconSize: 4.h,
        splashRadius: 5.h,
        onPressed: OnTap,
        enableFeedback: true,
        splashColor: splash,
        icon: Icon(
          iconData,
          color: iconColor,
        ),
      ),
    );
  }
}
