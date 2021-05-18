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
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: IconButton(
                        icon: Icon(FontAwesomeIcons.backward),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )),
                  Flexible(
                    flex: 10,
                    child: PhotoView(
                      loadingBuilder: (context, event) => SizedBox(
                        width: 100.0,
                        height: 100.0,
                        child: Shimmer.fromColors(
                          baseColor: Colors.red,
                          highlightColor: Colors.yellow,
                          child: Center(
                            child: Text(
                              'Please Wait',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      backgroundDecoration:
                          BoxDecoration(color: Colors.transparent),
                      imageProvider: url == null
                          ? AssetImage(
                              "assets/images/404.png",
                            )
                          : NetworkImage(url),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
