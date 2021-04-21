import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/UI/CustomWidgets/ProductItemView.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'ProductView.dart';

class SpecialAds extends StatefulWidget {

  @override
  _SpecialAdsState createState() => _SpecialAdsState();
}

class _SpecialAdsState extends State<SpecialAds> {
  get buttonSize => 20.0;
  EmptyListWidget emptyListWidget;
  @override
  Widget build(BuildContext context) {
    emptyListWidget = EmptyListWidget(
        title: 'Oops',
        subTitle: 'No Items in this category',
        image: 'assets/images/404.png',
        titleTextStyle: Theme.of(context)
            .typography
            .dense
            .headline4
            .copyWith(color: Color(0xff9da9c7)),
        subtitleTextStyle: Theme.of(context)
            .typography
            .dense
            .bodyText1
            .copyWith(color: Color(0xffabb8d6)));
    return Container(
      child: Provider.of<CartData>(context, listen: false).special == null || Provider.of<CartData>(context, listen: false).special
          .length == 0? emptyListWidget:Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.width/(2.5)),
                          child: GridView.count(
                              scrollDirection: Axis.vertical,
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              shrinkWrap: true,
                              children: List.generate(
                                  Provider.of<CartData>(context, listen: false).special
                                      .length, (index) {
                                return ProductItemVIew(
                                    buttonSize: buttonSize,
                                    list: Provider.of<CartData>(context, listen: false).special,
                                    OnTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              child: ProductView(
                                                product: Provider.of<CartData>(context, listen: false).special[index],
                                                fragNav: Test.fragNavigate,
                                              )));
                                    },
                                    Index: index);
                              })),
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
    );
  }
}
