import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shimmer/shimmer.dart';

class Photoview extends StatelessWidget {
  String url;

  Photoview(this.url);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white54,
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                PhotoView(
                  imageProvider:url == null?AssetImage("assets/images/404.png",): NetworkImage(url),
                ),
                IconButton(
                  splashColor: Colors.white,
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
        ),
      ),
    );
  }
}
