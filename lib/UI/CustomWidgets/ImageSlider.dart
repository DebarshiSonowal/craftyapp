import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/CustomWidgets/Photoview.dart';
import 'package:flutter/material.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:page_transition/page_transition.dart';

class CarouselWithIndicatorDemo extends StatefulWidget {
  Products item;
  FragNavigate _fragNavigate;
  Function(int) onTap;
  CarouselWithIndicatorDemo(this.item, this._fragNavigate,this.onTap);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;

  int get current => _current;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width/(1.5),
      child: Center(
        child: Column(
            children: [
          CarouselSlider(
            items: widget.item.Image.toString().split(',').map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    // onTap: () {
                    // setState(() {
                    //   // Test.url =widget.item.Image.toString().split(',')[_current].trim();
                    //   Navigator.push(context, PageTransition(
                    //       type: PageTransitionType.fade, child: Photoview(widget.item.Image.toString().split(',')[_current].trim())));
                    // });
                    // },
                    onTap:()=> widget.onTap(_current),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.transparent),
                        child:
                        CachedNetworkImage(
                          imageUrl: i.trim(),
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 25.0, bottom: 25.0, left: 20, right: 20),
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.width/(1.7),
                autoPlay: false,
                enlargeCenterPage: true,
                aspectRatio: 2.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                    print(index);
                  });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.item.Image.toString().split(',').map((url) {
              int index = widget.item.Image.toString().split(',').indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
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
        ]),
      ),
    );
  }
}
