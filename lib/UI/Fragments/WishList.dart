import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';


class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  get buttonSize => 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: EmptyListWidget(
          title: 'Coming Soon',
          subTitle: 'Be patient we are working on it',
          image: 'assets/images/settings.png',
          titleTextStyle: Theme.of(context).typography.dense.headline4.copyWith(color: Color(0xff9da9c7)),
          subtitleTextStyle: Theme.of(context).typography.dense.bodyText1.copyWith(color: Color(0xffabb8d6))
      ),
    );
  }
}
