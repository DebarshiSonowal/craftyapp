import 'dart:async';

import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/CustomWidgets/LoadingAnimation.dart';
import 'package:crafty/UI/CustomWidgets/ProductItemView.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'ProductView.dart';

class MenProducts extends StatefulWidget {
  @override
  _MenProductsState createState() => _MenProductsState();

  MenProducts();
}

class _MenProductsState extends State<MenProducts> {
  get buttonSize => 20.0;
  bool showError = false;
  EmptyListWidget emptyListWidget;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  BuildContext sysContext;

  @override
  Widget build(BuildContext context) {
    sysContext = context;
    print("Length ${ Provider.of<CartData>(context, listen: true).men.length}");
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
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
        child:
            Provider.of<CartData>(context, listen: true).allproducts.length ==
                        0 &&
                    showError
                ? emptyListWidget
                : getUI(),
      ),
    );
  }

  @override
  void initState() {
    emptyListWidget = Styles.EmptyError;
    super.initState();
    Timer(Duration(seconds: 7), () {
     changevalue();
    });
  }

  getUI() {
    return Provider.of<CartData>(context, listen: true).allproducts.length == 0
        ? LoadingAnimation(
            Provider.of<CartData>(context, listen: true).allproducts.length,
            10,
            null)
        : Container(
            height: MediaQuery.of(context).size.height,
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
                            height: MediaQuery.of(context).size.height -
                                (MediaQuery.of(context).size.width / (2)),
                            child: GridView.count(
                                scrollDirection: Axis.vertical,
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                shrinkWrap: true,
                                children: List.generate(
                                    Provider.of<CartData>(context,
                                            listen: false)
                                        .men
                                        .length, (index) {
                                  return ProductItemVIew(
                                      buttonSize: buttonSize,
                                      list: Provider.of<CartData>(context,
                                              listen: false)
                                          .men,
                                      OnTap: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: ProductView(
                                                  product:
                                                      Provider.of<CartData>(
                                                              context,
                                                              listen: false)
                                                          .men[index],
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
          );
  }

  void _onRefresh() async {
    UsersModel usersModel = UsersModel();
    var Data = await usersModel.getAll();
    if (Data.toString() != "Server Error" ||
        Data.toString() != "Products not found") {
      List<Products> data = Data;
      if (data != null) {
        setState(() {
          new Future.delayed(Duration.zero, () {
            Provider.of<CartData>(context, listen: false).setAllProduct(data);
            Test.addData(data, context);
          });
          Test.bihu = data;
          showError = false;
          _refreshController.refreshCompleted();
        });
      } else {
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

  void changevalue() {
    setState(() {
      showError = true;
    });
  }
}
