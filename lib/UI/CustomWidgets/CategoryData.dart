import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';


import 'CategoryItemView.dart';

class CategoryData extends StatefulWidget{
  Function showIndex;
  Function onTap;
  CarouselController controller=CarouselController();
  CategoryData(this.showIndex,this.onTap(T));

  @override
  _CategoryDataState createState() => _CategoryDataState();
}

class _CategoryDataState extends State<CategoryData> with TickerProviderStateMixin {
  var value,_current =0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                    color: Color(0xffE3E3E3),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  CarouselSlider(
                    carouselController: widget.controller,
                    options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 16/10,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.easeIn,
                        enableInfiniteScroll: true,
                        viewportFraction: 1.05,
                        reverse: false,
                        onPageChanged: (index, reason){
                          setState(() {
                            _current = index;
                          });
                        }
                    ),
                    items:
                    Provider.of<CartData>(context, listen: false).getAdImage().map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () => widget.showIndex(
                                Provider.of<CartData>(context, listen: false)
                                    .getAdImage()
                                    .indexOf(i)),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: i,
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
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: Provider.of<CartData>(context, listen: false).getAdImage().map((url) {
                      int index = Provider.of<CartData>(context, listen: false).getAdImage().indexOf(url);
                      return Container(
                        width: 5.0,
                        height: 3.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Color.fromRGBO(0, 0, 0, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 1.5,
          ),
          Card(
            elevation: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                    color: Color(0xffE3E3E3),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              height: 270,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 7,top:7),
                scrollDirection: Axis.horizontal,
                itemCount:
                Provider.of<CartData>(context, listen: true).getCateg().length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return CategoryItemView(
                    list: Provider.of<CartData>(context, listen: true).getCateg(),
                    index: index,
                    OnTap: () => widget.onTap(index),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

