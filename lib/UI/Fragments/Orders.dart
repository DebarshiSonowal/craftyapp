import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'OrderItem.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  UsersModel usersModel = new UsersModel();
  RefreshController _refreshController;


  @override
  void initState() {
    super.initState();
    _refreshController =
        RefreshController(initialRefresh:Provider.of<CartData>(context, listen: false).order.length==0?true:false);
  }

  var s = null;

  void _onRefresh() async {
    if (Test.accessToken != null && Test.refreshToken != null) {
      s = await usersModel.getOrdersforUser(
              Provider.of<CartData>(context, listen: false).user.id);

      if (s != null) {
       setState(() {
         Provider.of<CartData>(context, listen: false).orders(s);
       });
            _refreshController.refreshCompleted();
          }
    }else {
      Styles.showSnackBar(context, Styles.Log_sign, Duration(seconds: 5),
          'Please Login first', Colors.black, () {
            setState(() {
              Test.fragNavigate.putPosit(key: 'Login');
            });
          });
      _refreshController.refreshFailed();
    }
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Provider.of<CartData>(context, listen: false).order.length==0
              ? EmptyListWidget(
            title: "Oops!",
            titleTextStyle: TextStyle(color: Styles.price_color,fontSize: 18,fontFamily: 'Halyard'),
            subTitle: "Please swipe down to reload",
            subtitleTextStyle: TextStyle(color:  Styles.price_color,fontSize: 14,fontFamily: 'Halyard'),
          )
              : OrderItem(),
        ),
      ),
    );
  }
}
