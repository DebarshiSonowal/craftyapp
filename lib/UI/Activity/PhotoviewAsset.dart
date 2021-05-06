import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoviewAsset extends StatelessWidget {
  String url;

  PhotoviewAsset(this.url);

  @override
  Widget build(BuildContext context) {
    print("Gender $url");
    return Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PhotoView(
            imageProvider:url == "Men"?AssetImage("assets/images/men.jpg",):AssetImage('assets/images/women.jpg',) ,
          ),
        )
    );
  }
}
