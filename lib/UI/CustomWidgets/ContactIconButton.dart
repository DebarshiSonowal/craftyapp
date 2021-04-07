import 'package:flutter/material.dart';

class ContactIconButton extends StatelessWidget {
  const ContactIconButton(
      this.OnTap, this.splash, this.iconData, this.iconColor);

  final Function OnTap;
  final splash;
  final IconData iconData;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: IconButton(
          iconSize: 28,
          splashRadius: 28,
          onPressed: OnTap,
          enableFeedback: true,
          splashColor: splash,
          icon: Icon(
            iconData,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
