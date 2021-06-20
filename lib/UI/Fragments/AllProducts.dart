import 'dart:async';

import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/CustomWidgets/AllProductsFragmentProductItemview.dart';
import 'package:crafty/UI/CustomWidgets/LoadingAnimation.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'ProductView.dart';

class AllProductsFragment extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProductsFragment> {
  get buttonSize => 20.0;
  bool showError = false;
  Widget emptyListWidget;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  BuildContext sysContext;
  var _selected;

  @override
  Widget build(BuildContext context) {
    sysContext = context;
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
        child: Consumer<CartData>(
            builder: (context, data, child) =>
                data.allproducts.length == 0 && showError
                    ? emptyListWidget
                    : getUI(data)),
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

  getUI(data) {
    return data.allproducts.length == 0
        ? LoadingAnimation(data.allproducts.length, 10, null)
        : Padding(
            padding: EdgeInsets.only(top: 2, bottom: 10),
            child: Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Card(
                    elevation: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          new BoxShadow(
                            color: Color(0xffE3E3E3),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      height: 5.h,
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                              value: _selected,
                              isExpanded: true,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              items: <String>[
                                'Price Low to High',
                                'Price High to Low'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: Text(
                                "Filter",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _selected = value;
                                  if (_selected == 'Price Low to High') {
                                    Provider.of<CartData>(context,
                                            listen: false)
                                        .setSortedList(Provider.of<CartData>(
                                                context,
                                                listen: false)
                                            .allproducts);
                                    Provider.of<CartData>(context,
                                            listen: false)
                                        .sorted
                                        .sort((a, b) => double.parse(a.Price)
                                            .compareTo(double.parse(b.Price)));
                                  } else {
                                    Provider.of<CartData>(context,
                                            listen: false)
                                        .setSortedList(Provider.of<CartData>(
                                                context,
                                                listen: false)
                                            .allproducts);
                                    Provider.of<CartData>(context,
                                            listen: false)
                                        .sorted
                                        .sort((a, b) => double.parse(b.Price)
                                            .compareTo(double.parse(a.Price)));
                                  }
                                });
                              }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Expanded(
                    child: Container(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: (MediaQuery.of(context)
                                          .size
                                          .width) /
                                      (MediaQuery.of(context).size.height + 30),
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 5,
                                  crossAxisCount: 2),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              AllProductsFragmentProductItemView(
                                  buttonSize: buttonSize,
                                  list: data.allproducts,
                                  OnTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductView(
                                                  product:
                                                      data.allproducts[index],
                                                  fragNav: Test.fragNavigate,
                                                )));
                                  },
                                  Index: index)),
                    ),
                  ),
                ],
              ),
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
    if (mounted) {
      setState(() {
        showError = true;
      });
    }
  }
}

// DropdownButtonHideUnderline(
// child: ButtonTheme(
// alignedDropdown: true,
// child: DropdownButton<String>(
// value: _selected,
// isExpanded: true,
// style: TextStyle(color: Colors.black, fontSize: 18),
// items: <String>[
// 'Price Low to High',
// 'Price High to Low'
// ].map<DropdownMenuItem<String>>((String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value),
// );
// }).toList(),
// hint: Text(
// "Filter",
// style: TextStyle(
// color: Colors.black,
// fontSize: 18,
// fontWeight: FontWeight.w600),
// ),
// onChanged: (String value) {
// setState(() {
// _selected = value;
// if (_selected == 'Price Low to High') {
// Provider.of<CartData>(context, listen: false)
//     .setSortedList(Provider.of<CartData>(
// context,
// listen: false)
//     .allproducts);
// Provider.of<CartData>(context, listen: false)
//     .sorted
//     .sort((a, b) => double.parse(a.Price)
//     .compareTo(double.parse(b.Price)));
// } else {
// Provider.of<CartData>(context, listen: false)
//     .setSortedList(Provider.of<CartData>(
// context,
// listen: false)
//     .allproducts);
// Provider.of<CartData>(context, listen: false)
//     .sorted
//     .sort((a, b) => double.parse(b.Price)
//     .compareTo(double.parse(a.Price)));
// }
// });
// }),
// ),
// ),
