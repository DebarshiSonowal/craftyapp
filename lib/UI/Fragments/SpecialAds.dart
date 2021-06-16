import 'dart:async';

import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/CustomWidgets/AllProductsFragmentProductItemview.dart';
import 'package:crafty/UI/CustomWidgets/LoadingAnimation.dart';
import 'package:crafty/UI/CustomWidgets/ProductItemView.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'ProductView.dart';

class SpecialAds extends StatefulWidget {
  @override
  _SpecialAdsState createState() => _SpecialAdsState();
}

class _SpecialAdsState extends State<SpecialAds> {

  get buttonSize => 20.0;
  Widget emptyListWidget;
  bool showError =false;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh(){
    Test.getAllProducts(context);
    List<Products> list = [];
    var tag = Test.specialTag;
    if (tag != null) {
      Provider.of<CartData>(context, listen: false).setSpecialTag(tag);
      var all = Provider.of<CartData>(context, listen: false).allproducts;
      for (var i in all) {
        for (var j in i.Tags.toString().split(',')) {
          if (j.trim().toUpperCase() == tag.toString().trim().toUpperCase()) {
            list.add(i);
            _refreshController.refreshCompleted();
          }
        }
      }

      if (list.isNotEmpty) {
        setState(() {
          Provider.of<CartData>(context, listen: false).setSpecial(list);
          _refreshController.refreshCompleted();
          showError = false;
        });
      } else {
        setState(() {
          Provider.of<CartData>(context, listen: false).setSpecial([]);
        });
        _refreshController.refreshFailed();
      }
    } else {
      _refreshController.refreshFailed();
    }
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();


    Timer(Duration(seconds: 7), () {
        Provider.of<CartData>(context, listen: false)
            .special.length==0?setTrue():null;
    });
  }

  @override
  Widget build(BuildContext context) {
    emptyListWidget = EmptyListWidget(
      title: "Oops!",
      titleTextStyle: TextStyle(color: Styles.price_color,fontSize: 18,fontFamily: 'Halyard'),
      subTitle: "Please Swipe down to refresh.",
      subtitleTextStyle: TextStyle(color: Styles.price_color,fontSize: 16,fontFamily: 'Halyard'),
    );
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 75.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: Container(
            child:showError?emptyListWidget:everything(context, buttonSize)
        ),
      ),
    );
  }

  setTrue() {
    setState(() {
      showError = true;
    });
  }
}
Widget everything(BuildContext context,buttonSize){
  return  Provider.of<CartData>(context, listen: false).special == null ||
      Provider.of<CartData>(context, listen: false).special.length == 0
      ? LoadingAnimation(
      Provider.of<CartData>(context, listen: false).special.length,
      10,
      null)
      : Padding(
    padding: EdgeInsets.only(top: 10,bottom: 10),
        child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height-(MediaQuery.of(context).size.height/8),
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            childAspectRatio: (MediaQuery.of(context).size.width) /
                (MediaQuery.of(context).size.height + 30),
            mainAxisSpacing: 5,
            primary: true,
            // shrinkWrap: true,
            semanticChildCount: 2,
            children: List.generate(
                Provider.of<CartData>(context, listen: false)
                    .special
                    .length, (index) {
              return AllProductsFragmentProductItemView(
                  buttonSize: buttonSize,
                  list:
                  Provider.of<CartData>(context, listen: false)
                      .special,
                  OnTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductView(
                              product: Provider.of<CartData>(context,
                                  listen: false)
                                  .special[index],
                              fragNav: Test.fragNavigate,
                            )));
                  },
                  Index: index);
            }))),
      );
}
