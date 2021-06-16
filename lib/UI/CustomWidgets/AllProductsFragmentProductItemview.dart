import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
class AllProductsFragmentProductItemView extends StatelessWidget {
  final List<Products> list;
  final double buttonSize;
  final Function OnTap;
  final int Index;

  List<Products> list1 = [
  ];

  AllProductsFragmentProductItemView(
      {Key key,
      @required this.buttonSize,
      @required this.list,
      @required this.OnTap,
      @required this.Index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: Container(
        decoration: BoxDecoration(
          color: Styles.bg_color,
          border: Border(
              bottom: BorderSide(
            color: Colors.black12,
            width: 0.6,
          )),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 28,
              fit: FlexFit.tight,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
                elevation: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: list[Index].Image.toString().split(",")[0],
                   placeholder: (context,s)=>Image.asset("assets/images/404.png"),
                    errorWidget: (context,
                        url, error) =>
                        Icon(Icons.error),
                  ),
                    // FadeInImage.assetNetwork(
                    //   placeholder: "assets/images/404.png",
                    //   image: list[Index].Image.toString().split(",")[0],
                    //   fit: BoxFit.fill,
                    // )
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 5.0, right: 3),
                child: Text(
                  list[Index].Name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Halyard",
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: Styles.getPriceSize(context)),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 2.0, bottom: 2, right: 3),
                child: Text(
                  list[Index].Short,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Halyard",
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 8.sp),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 1.0,bottom: 1.0),
                child:Row(
                  children: [
                    Text(
                      "₹ ${list[Index].Price}",
                      style: TextStyle(
                          fontFamily: "Halyard",
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w200,
                          color: Styles.price_color),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      "₹ 699",
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontFamily: "Halyard",
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w200,
                          color: Colors.black),
                    ),
                  ],
                ),
                // child: Text(
                //   "₹ ${list[Index].Price}",
                //   style: TextStyle(
                //       fontSize: Styles.getPriceSize(context),
                //       color: Styles.price_color,
                //     fontWeight: FontWeight.w400,),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
