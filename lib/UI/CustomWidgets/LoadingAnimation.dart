import 'package:crafty/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingAnimation extends StatefulWidget {
  int length, items;
  double height;

  LoadingAnimation(this.length, this.items, this.height);

  @override
  State<StatefulWidget> createState() {
    return _LoadingAnimationState();
  }


}
class _LoadingAnimationState extends State<LoadingAnimation> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height == null ? MediaQuery.of(context).size.height : widget.height,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child:SpinKitFadingCube(
          color: Styles.price_color,
          size: 50.0,
          controller: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 1200)),

        ));
  }

}