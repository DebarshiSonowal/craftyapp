
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty/Models/Products.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class ProductItemVIew extends StatelessWidget {
  const ProductItemVIew(
      {Key key,
      @required this.buttonSize,
      @required this.list,
      @required this.OnTap,
      @required this.Index})
      : super(key: key);

  final List<Products> list;
  final double buttonSize;
  final Function OnTap;
  final int Index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: Card(
        margin: EdgeInsets.all(10),
        color: Colors.transparent,
        elevation: 3,
        child: Container(
          width: 155,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex:5,
                child: CachedNetworkImage(
                  imageUrl: list[Index].Image.toString().split(",")[0],
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
              ),
              SizedBox(
                height: 3,
              ),
              Flexible(
                flex: 1,
                child: Text(
                  list[Index].Name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 30),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Flexible(
                child: Text(
                  "₹ ${list[Index].Price}",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
