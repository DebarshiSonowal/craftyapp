import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/Ads.dart';
import 'package:crafty/Models/Categories.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/Models/Razorpay.dart';
import 'package:crafty/UI/Activity/Host.dart';
import 'package:crafty/UI/CustomWidgets/CategoryItemView.dart';
import 'package:crafty/UI/CustomWidgets/ProductItemView.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'ProductView.dart';

//Carolina Cajazeira
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  HomePage();
}

class _HomePageState extends State<HomePage> {
  BuildContext customcontext;
  RefreshController _refreshController =
      RefreshController(initialRefresh: Test.bihu == null ? true : false);

  get buttonSize => 20.0;

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      customcontext = context;
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _onRefresh() async {
    if (Test.accessToken != null && Test.refreshToken != null) {
      UsersModel usersModel = UsersModel();
      UsersModel usersModel1 = UsersModel();
      var Data = await usersModel.getAll();
      if (Data.toString() != "Server Error" ||
          Data.toString() != "Products not found") {
        List<Products> data = Data;
        if (data != null) {
          setState(() {
            print("Here");
            new Future.delayed(Duration.zero, () {
              Provider.of<CartData>(customcontext, listen: false)
                  .setAllProduct(data);
            });
            Test.bihu = data;
            _refreshController.refreshCompleted();
          });
        } else {
          print("nkn");
          _refreshController.refreshFailed();
        }
      } else {
        _refreshController.refreshFailed();
      }
      var data = await usersModel1.getRequired();

      var data1 = data['require'] as List;
      List<Categories> categories =
          data1.map((e) => Categories.fromJson(e)).toList();

      var data2 = data['ads'] as List;
      List<Ads> ads = data2.map((e) => Ads.fromJson(e)).toList();
      var data3 = data['razorpay'];

      new Future.delayed(Duration.zero, () {
        Provider.of<CartData>(customcontext, listen: false)
            .setCategory(categories);
        Provider.of<CartData>(customcontext, listen: false).setAds(ads);
        Provider.of<CartData>(customcontext, listen: false)
            .setRazorpay(Razorpay.fromJson(data3));
      });
    } else {
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
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SmartRefresher(
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Categories:",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: Provider.of<CartData>(context, listen: true)
                      .getCateg()
                      .length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return CategoryItemView(
                      list: Provider.of<CartData>(context, listen: true)
                          .getCateg(),
                      index: index,
                      OnTap: () {
                        Test.fragNavigate.putPosit(
                            key: Provider.of<CartData>(context, listen: false)
                                .getCateg()[index]
                                .name
                                .toString(),
                            force: true);
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 300.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  reverse: false,
                ),
                items: Provider.of<CartData>(context, listen: false)
                    .getAdImage()
                    .map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          var index =
                              Provider.of<CartData>(context, listen: false)
                                  .getAdImage()
                                  .indexOf(i);
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration:
                                BoxDecoration(color: Colors.transparent),
                            child: FadeInImage.assetNetwork(
                                placeholder: "assets/images/404.png",
                                image: i)),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Card(
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/raw/safe.json',
                            height: 100, width: 120),
                        Flexible(
                            child: Text(
                          'Stay Home\nStay Safe\nAnd order on Crafty😉',
                          softWrap: true,
                          style: TextStyle(
                              fontFamily: "Shadows",
                              fontSize: 22,
                              color: Colors.black),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Card(
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/raw/shoppingcart.json',
                            height: 100, width: 120),
                        Flexible(
                            child: Text(
                          'Craft your own look\n with \nCrafty\'s personalized goods',
                          softWrap: true,
                          style: TextStyle(
                              fontFamily: "Shadows",
                              fontSize: 22,
                              color: Colors.black),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "All Products:",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 220,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: Provider.of<CartData>(context, listen: true)
                      .allproducts
                      .length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return ProductItemVIew(
                      buttonSize: buttonSize,
                      list: Provider.of<CartData>(context, listen: true)
                          .allproducts,
                      Index: index,
                      OnTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: ProductView(
                                    product: Provider.of<CartData>(context,
                                        listen: false)
                                        .allproducts[index],
                                    fragNav: Test.fragNavigate)));
                      },
                    );
                  },
                ),
              ),
              Card(
                elevation: 1,
                color: Colors.white,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/raw/like.json',
                          height: 100, width: 120),
                      Flexible(
                          child: Text(
                        'Enjoyed shopping with us?\nRate us on playstore',
                        softWrap: true,
                        style: TextStyle(
                            fontFamily: "Shadows",
                            fontSize: 22,
                            color: Colors.black),
                      ))
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
