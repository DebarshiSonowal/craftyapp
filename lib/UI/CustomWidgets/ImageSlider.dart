import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty/Models/Products.dart';
import 'package:flutter/material.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:shimmer/shimmer.dart';

class CarouselWithIndicatorDemo<T> extends StatefulWidget {
  Products item;
  FragNavigate _fragNavigate;
  Function(int) onTap;
  final void Function(T) value;
  CarouselWithIndicatorDemo(this.item, this._fragNavigate,this.onTap,this.value);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;

  int get current => _current;
  CarouselController controller=CarouselController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width/(1.5),
      child: Center(
        child: Column(
            children: [
          CarouselSlider(
            carouselController: controller,
            items: widget.item.Image.toString().split(',').map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap:()=> widget.onTap(_current),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.transparent),
                        child:
                        CachedNetworkImage(
                          imageUrl: i.trim(),
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
                    widget.value(index);
                    _current = index;
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
