import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty/Models/Categories.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
class CategoryItemView extends StatefulWidget {
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
  _CategoryItemViewState createState() => _CategoryItemViewState();
}

class _CategoryItemViewState extends State<CategoryItemView>  with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.OnTap,
      child: Container(
        height: 100.h,
        width: 50.w,
        color: Colors.white,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          alignment:AlignmentDirectional.bottomCenter,
          children: [
            CachedNetworkImage(
              height:  100.h,
              width: 49.w,
              fit: BoxFit.fill,
              imageUrl:  widget.list[widget.index].image,
              progressIndicatorBuilder:
                  (context, url, downloadProgress) => SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child:SpinKitFadingCube(
                    color: Styles.price_color,
                    size: 50.0,
                    controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                  )
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffE3859A),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight:  Radius.circular(5),),
              ),
              padding: EdgeInsets.only(left: 5,right: 5),
              child: Text(widget.list[widget.index].name,
                  style: TextStyle(
                    fontFamily: "Halyard",
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20.sp,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

