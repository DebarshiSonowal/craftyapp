import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty/Models/Categories.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryItemView extends StatelessWidget {
  const CategoryItemView(
      {Key key,
      @required this.list,
      @required this.OnTap,
      @required this.index})
      : super(key: key);

  final Function OnTap;
  final List<Categories> list;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: Card(
        margin: EdgeInsets.all(9),
        color: Colors.transparent,
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 130,
          width: 150,
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: list[index].image,
                width: 150,
                height: 100,
                fit: BoxFit.fitHeight,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: Shimmer.fromColors(
                        baseColor: Colors.red,
                        highlightColor: Colors.yellow,
                        child: Center(
                          child: Text(
                            'Please Wait',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(
                height: 5,
              ),
              Text(list[index].name)
            ],
          ),
        ),
      ),
    );
  }
}
