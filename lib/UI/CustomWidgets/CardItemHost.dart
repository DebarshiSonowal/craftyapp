import 'package:crafty/Models/Categories.dart';
import 'package:flutter/material.dart';


class CardItemHost extends StatelessWidget {
 CardItemHost({
    Key key,
    @required this.list,
    @required this.Child
  }) : super(key: key);


  final List<Categories> list;
  final Widget Child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Child;
        },
      ),
    );
  }
}
