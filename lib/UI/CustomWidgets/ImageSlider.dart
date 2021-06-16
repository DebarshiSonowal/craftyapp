import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragment_navigate/navigate-bloc.dart';

class CarouselWithIndicatorDemo<T> extends StatefulWidget {
  Products item;
  FragNavigate _fragNavigate;
  var colors;
  Function(int) onTap;
  dynamic controller;
  final void Function(T) value;
  CarouselWithIndicatorDemo(this.item, this._fragNavigate,this.onTap,this.value,this.colors,this.controller);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> with TickerProviderStateMixin {
  int _current = 0;

  int get current => _current;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.colors,
      height: MediaQuery.of(context).size.height/(1.28),
      child: Center(
        child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CarouselSlider(
                carouselController: widget.controller,
                items: widget.item.Image.toString().split(',').map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap:()=> widget.onTap(_current),
                        child: Container(
                          height: MediaQuery.of(context).size.height/(2),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Color(0xffe3e3e6)),
                          child:
                          CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: i.trim(),
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: SpinKitCubeGrid(
                                    color: Styles.price_color,
                                    size: 50.0,
                                    controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
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
                    height: MediaQuery.of(context).size.height/(1.3),
                    viewportFraction: 1,
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
                    width: 5.0,
                    height: 5.0,
                    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
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

