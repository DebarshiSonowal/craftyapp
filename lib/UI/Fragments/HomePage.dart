import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/Ads.dart';
import 'package:crafty/Models/Categories.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/Models/Razorpay.dart';
import 'package:crafty/UI/CustomWidgets/CategoryItemView.dart';
import 'package:crafty/UI/CustomWidgets/ProductItemView.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import 'ProductView.dart';

//Carolina Cajazeira
class HomePage extends StatefulWidget {
  FragNavigate _fragNavigate;

  @override
  _HomePageState createState() => _HomePageState();

  HomePage(fragNavigate);
}

class _HomePageState extends State<HomePage> {
  BuildContext customcontext;
  RefreshController _refreshController;

  get buttonSize => 20.0;

  @override
  void initState() {
    _refreshController = RefreshController(
        initialRefresh:
            Provider.of<CartData>(context, listen: false).getCateg() == null
                ? true
                : false);
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
              addData(data);
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
      UsersModel usersModel = UsersModel();
      var Data = await usersModel.getAll();
      List<Products> data = [];
      if (Data.toString() == "Server Error" ||
          Data.toString() == "Products not found") {
        Dialogs.materialDialog(
            msg: 'Sorry Something is wrong',
            title: "Server Error",
            color: Colors.white,
            context: context,
            actions: [
              IconsButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Accepted',
                iconData: Icons.delete,
                color: Colors.red,
                textStyle: TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ]);
      } else {
        data = Data;
        List<Products> men = [];
        List<Products> women = [];
        if (data != null) {
          for (var i in data) {
            if (i.Gender == "MALE") {
              men.add(i);
            } else {
              women.add(i);
            }
          }
          setState(() {
            Provider.of<CartData>(context, listen: false).setAllProduct(data);
            Provider.of<CartData>(context, listen: false).setMen(men);
            Provider.of<CartData>(context, listen: false).setWomen(women);
          });
        } else {
          print("empty");
        }
      }
    }
    UsersModel usersModel1 = UsersModel();
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
      _refreshController.refreshCompleted();
    });
    Styles.showSnackBar(context, Styles.Log_sign, Duration(seconds: 5),
        'Please Login first', Colors.black, () {
      setState(() {
        Test.fragNavigate.putPosit(key: 'Login');
      });
    });
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
                        if (Provider.of<CartData>(context, listen: false)
                                    .getCateg()[index]
                                    .name
                                    .toString()
                                    .trim() !=
                                'Men' &&
                            Provider.of<CartData>(context, listen: false)
                                    .getCateg()[index]
                                    .name
                                    .toString()
                                    .trim() !=
                                'Women') {
                          List<Products> list = [];
                          for (var i
                              in Provider.of<CartData>(context, listen: false)
                                  .allproducts) {
                            if (i.Gender.toString().trim().toUpperCase() ==
                                Provider.of<CartData>(context, listen: false)
                                    .getCateg()[index]
                                    .name
                                    .toString()
                                    .trim()
                                    .toUpperCase()) {
                              list.add(i);
                            }
                          }
                          setState(() {
                            Provider.of<CartData>(context, listen: false)
                                .setCouple(list);
                          });
                          Test.fragNavigate
                              .putPosit(key: 'Couple', force: true);
                        } else {
                          if (Provider.of<CartData>(context, listen: false)
                                  .getCateg()[index]
                                  .name
                                  .toString()
                                  .trim() ==
                              'Men') {
                            print("BEER");
                            Test.fragNavigate.putPosit(key: 'Men', force: true);
                          } else {
                            Test.fragNavigate
                                .putPosit(key: 'Women', force: true);
                          }
                        }
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
                      print("faf ${i.trim()}");
                      return GestureDetector(
                        onTap: () => showIndex(
                            Provider.of<CartData>(context, listen: false)
                                .getAdImage()
                                .indexOf(i)),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: CachedNetworkImage(
                            imageUrl: i,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.red,
                                    highlightColor: Colors.yellow,
                                    child: Center(
                                      child: Text(
                                        'Please Wait',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
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
                          'Stay Home\n\nStay Safe\n\nAnd order on Crafty 😉',
                          softWrap: true,
                          style: TextStyle(
                              fontFamily: "BEYOND",
                              fontSize: 22,
                              color: Colors.red),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Products:",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          try {
                            Test.fragNavigate.putPosit(key: 'All', force: true);
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text(
                          "Show All",
                          style: TextStyle(fontSize: 18),
                        ))
                  ],
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
                      .sublist(
                          0,
                          Provider.of<CartData>(context, listen: false)
                                  .allproducts
                                  .length ~/
                              3)
                      .length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return ProductItemVIew(
                      buttonSize: buttonSize,
                      list: Provider.of<CartData>(context, listen: true)
                          .allproducts
                          .sublist(
                              0,
                              Provider.of<CartData>(context, listen: false)
                                      .allproducts
                                      .length ~/
                                  3),
                      Index: index,
                      OnTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: ProductView(
                                    product: Provider.of<CartData>(context,
                                            listen: false)
                                        .allproducts
                                        .sublist(
                                            0,
                                            Provider.of<CartData>(context,
                                                        listen: false)
                                                    .allproducts
                                                    .length ~/
                                                3)[index],
                                    fragNav: Test.fragNavigate)));
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Image.asset(
                'assets/images/kk.jpg',
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.width,
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
                          'Craft your own look\n with \nCrafty',
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "EBGaramond",
                              fontSize: 24,
                              color: Colors.black),
                        ))
                      ],
                    ),
                  ),
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
                            fontFamily: "Somana",
                            fontSize: 18,
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

  void addData(List<Products> data) {
    List<Products> men = [];
    List<Products> women = [];
    if (data != null) {
      for (var i in data) {
        if (i.Gender == "MALE") {
          men.add(i);
          print("MEN $i");
        } else {
          women.add(i);
          print("WOMEN $i");
        }
      }
      setState(() {
        Provider.of<CartData>(context, listen: false).setAllProduct(data);
        Provider.of<CartData>(context, listen: false).setMen(men);
        Provider.of<CartData>(context, listen: false).setWomen(women);
      });
    } else {
      print("empty");
    }
  }

  showIndex(int i) {
    List<Products> list = [];
    var tag = Provider.of<CartData>(context, listen: false).getAds()[i].tag;
    Provider.of<CartData>(context, listen: false).setSpecialTag(tag);
    var all = Provider.of<CartData>(context, listen: false).allproducts;
    for (var i in all) {
      for (var j in i.Tags.toString().split(',')) {
        if (j.trim().toUpperCase() == tag.toString().trim().toUpperCase()) {
          list.add(i);
        }
      }
    }

    if (list.isNotEmpty) {
      setState(() {
        Provider.of<CartData>(context, listen: false).setSpecial(list);
      });
    } else {
      setState(() {
        Provider.of<CartData>(context, listen: false).setSpecial([]);
      });
    }
    Test.fragNavigate.putPosit(key: 'Special', force: true);
  }
}
