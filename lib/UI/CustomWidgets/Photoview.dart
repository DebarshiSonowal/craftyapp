import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Photoview extends StatelessWidget {
  String url;

  Photoview(this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PhotoView(
            imageProvider:url == null?AssetImage("assets/images/404.png",): NetworkImage(url),
          ),
        )
    );
  }
}
