import 'package:flutter/material.dart';
class ProfileWidget extends StatelessWidget {
  String url,name,designation;

  ProfileWidget(this.url, this.name,this.designation);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: MediaQuery.of(context).size.width / 9,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(
                url)),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(name),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(designation),
        ),
      ],
    );
  }
}