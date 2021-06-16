import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/CartProduct.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
class ProductSummary extends StatefulWidget {
  var quantity;
  int getIndex;
  var product;
  Function onTap;
  var selectedColor,selectedSize;


  ProductSummary(this.getIndex, this.quantity, this.product,
      this.onTap, this.selectedColor, this.selectedSize);

  @override
  _ProductSummaryyState createState() => _ProductSummaryyState();
}

class _ProductSummaryyState extends State<ProductSummary> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                left: 10, right: 10),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                Text(
                  "Product Summary",
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Halyard",
                      fontWeight:
                      FontWeight.w700,
                      fontSize: 18.sp),
                ),
                Padding(
                  padding:
                  EdgeInsets.only(
                      top: 1.h,
                      bottom: 1.h),
                  child: SizedBox(
                    child: Container(
                      color:
                      Color(0xffE4E4E7),
                    ),
                    height: 1.5,
                  ),
                ),
                Container(
                  height: 35.h,
                  margin: EdgeInsets.only(bottom: 1.h,left: 0.2.h),
                  alignment: AlignmentDirectional.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 30.h,
                          child: GestureDetector(
                            onTap: ()=>widget.onTap,
                            child:
                            CachedNetworkImage(
                              imageUrl: widget
                                  .product.Image
                                  .toString()
                                  .split(",")[
                              widget.getIndex]
                                  .trim(),
                              fit: BoxFit.fill,
                              progressIndicatorBuilder: (context,
                                  url,
                                  downloadProgress) =>
                                  SizedBox(
                                      width:
                                      50.0,
                                      height:
                                      50.0,
                                      child:
                                      SpinKitCubeGrid(
                                        color: Styles
                                            .price_color,
                                        size:
                                        50.0,
                                        controller: AnimationController(
                                            vsync:
                                            this,
                                            duration:
                                            const Duration(milliseconds: 1200)),
                                      )),
                              errorWidget: (context,
                                  url,
                                  error) =>
                                  Icon(Icons
                                      .error),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 40.h,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(

                                  alignment: AlignmentDirectional.center,
                                  padding: EdgeInsets.only(top: 2.h,bottom: 2.h),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .stretch,
                                    children: [
                                      Container(

                                        padding:
                                        EdgeInsets.only(left: 35),
                                        child:
                                        Text(
                                          widget
                                              .product
                                              .Name
                                              .toString(),
                                          maxLines:
                                          1,
                                          textAlign:
                                          TextAlign.start,
                                          overflow:
                                          TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: "Halyard",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(right: 10),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Quantity",
                                                    style: TextStyle(fontFamily: "Halyard", fontWeight: FontWeight.w400, fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 2.5.h,
                                                  ),
                                                  Text(
                                                    "Size",
                                                    style: TextStyle(fontFamily: "Halyard", fontWeight: FontWeight.w400, fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 2.5.h,
                                                  ),
                                                  Text(
                                                    "Price",
                                                    style: TextStyle(fontFamily: "Halyard", fontWeight: FontWeight.w400, fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 2.5.h,
                                                  ),
                                                  Text(
                                                    "Color",
                                                    style: TextStyle(fontFamily: "Halyard", fontWeight: FontWeight.w400, fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${widget.quantity}",
                                                  style: TextStyle(fontFamily: "Halyard", fontWeight: FontWeight.w600, fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 2.5.h,
                                                ),
                                                Text(
                                                  "${widget.selectedSize}",
                                                  style: TextStyle(fontFamily: "Halyard", fontWeight: FontWeight.w600, fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 2.5.h,
                                                ),
                                                Text(
                                                  "₹${widget.product.Price}",
                                                  style: TextStyle(fontFamily: "Halyard", fontWeight: FontWeight.w600, color: Styles.price_color, fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 2.5.h,
                                                ),
                                                Text(
                                                  widget.selectedColor,
                                                  style: TextStyle(fontFamily: "Halyard", fontWeight: FontWeight.w600, fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 7.h,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<CartData>(
                          context,
                          listen: false)
                          .addProduct(CartProduct(
                          widget.selectedColor,
                          widget.product
                              .Price,
                          widget.product
                              .Image
                              .toString()
                              .split(",")[
                          widget.getIndex]
                              .trim(),
                          widget.quantity,
                          widget.selectedSize,
                          widget.product
                              .Name,
                          widget
                              .product.Id,
                          UniqueKey()));
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Test.fragNavigate
                          .putPosit(
                        key: 'Cart',
                      );
                    },
                    style: ButtonStyle(
                      enableFeedback: true,
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.zero,
                          )),
                      backgroundColor:
                      MaterialStateProperty
                          .all(Color(
                          0xffE3E3E3)),
                      shadowColor:
                      MaterialStateProperty
                          .all(Color(
                          0xffE3E3E3)),
                      elevation:
                      MaterialStateProperty
                          .all(4),
                      overlayColor:
                      MaterialStateProperty
                          .resolveWith(
                            (states) {
                          return states.contains(
                              MaterialState
                                  .pressed)
                              ? Color(
                              0xffE3E3E3)
                              : null;
                        },
                      ),
                    ),
                    child: Container(
                      child: Center(
                        child: Text('Add',
                            style: TextStyle(
                                fontFamily:
                                "Halyard",
                                fontSize: 14.sp,
                                fontWeight:
                                FontWeight
                                    .w600,
                                color: Colors
                                    .black)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                  width: .2.h,
                  child: Container(
                    margin: EdgeInsets.all(2),
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<CartData>(
                          context,
                          listen: false)
                          .addProduct(CartProduct(
                          widget.selectedColor,
                          widget.product
                              .Price,
                          widget.product
                              .Image
                              .toString()
                              .split(",")[
                          widget.getIndex]
                              .trim(),
                          widget.quantity,
                          widget.selectedSize,
                          widget.product
                              .Name,
                          widget
                              .product.Id,
                          UniqueKey().toString()));
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Test.fragNavigate
                          .putPosit(
                        key: 'Cart',
                      );
                    },
                    style: ButtonStyle(
                      enableFeedback: true,
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.zero,
                          )),
                      backgroundColor:
                      MaterialStateProperty
                          .all(Styles
                          .price_color),
                      shadowColor:
                      MaterialStateProperty
                          .all(Color(
                          0xffE3E3E3)),
                      elevation:
                      MaterialStateProperty
                          .all(4),
                      overlayColor:
                      MaterialStateProperty
                          .resolveWith(
                            (states) {
                          return states.contains(
                              MaterialState
                                  .pressed)
                              ? Color(
                              0xffE3E3E3)
                              : null;
                        },
                      ),
                    ),
                    child: Container(
                      child: Center(
                        child: Text(
                            'Go to Cart',
                            style: TextStyle(
                                fontFamily:
                                "Halyard",
                                fontSize: 14.sp,
                                fontWeight:
                                FontWeight
                                    .w600,
                                color: Colors
                                    .white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
