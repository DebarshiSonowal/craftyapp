import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  String url, name, designation;

  ProfileWidget(this.url, this.name, this.designation);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          // child: CachedNetworkImage(
          //   height: 100,
          //   imageUrl: url,
          //   progressIndicatorBuilder: (context, url, downloadProgress) =>
          //       Padding(
          //     padding:
          //         EdgeInsets.only(top: 25.0, bottom: 25.0, left: 20, right: 20),
          //     child:
          //         CircularProgressIndicator(value: downloadProgress.progress),
          //   ),
          //   errorWidget: (context, url, error) => Icon(Icons.error),
          // ),
          child:  Image.asset("assets/images/user.png",height: 100),
        ),
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
