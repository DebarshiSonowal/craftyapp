
import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/Activity/Host.dart';
import 'package:crafty/UI/CustomWidgets/CategoryItemView.dart';
import 'package:crafty/UI/CustomWidgets/ProductItemView.dart';
import 'package:crafty/Utility/Users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'ProductView.dart';



//Carolina Cajazeira
class HomePage extends StatefulWidget {
  final HostState parent;
  @override
  _HomePageState createState() => _HomePageState();

  HomePage(this.parent);
}

class _HomePageState extends State<HomePage> {
  RefreshController _refreshController =
  RefreshController(initialRefresh: Test.bihu==null?true:false);
  get buttonSize => 20.0;
  void _onRefresh() async{
    UsersModel usersModel = UsersModel();
    var Data = await usersModel.getAll();
    if(Data.toString()=="Server Error"||Data.toString()=="Products not found"){
      List<Products> data = Data;
      if(data!=null){
        setState(() {
          print("Here");
          Provider.of<CartData>(context, listen: false).setAllProduct(data);
          Test.bihu = data;
          _refreshController.refreshCompleted();
        });
      }else{
        print("nkn");
        _refreshController.refreshFailed();
      }
    }else{
      _refreshController.refreshFailed();
    }

  }

  void _onLoading() async{
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
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
              body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 75.0,
              child: Center(child:body),
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
                  itemCount: Test.list.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return CategoryItemView(
                      list: Test.list,
                      index: index,
                      OnTap: () {
                        Fluttertoast.showToast(
                            msg: "This is Center Short Toast",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.black,
                            fontSize: 16.0);
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
                items: [
                  "https://homepages.cae.wisc.edu/~ece533/images/airplane.png",
                  "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png",
                  "https://homepages.cae.wisc.edu/~ece533/images/baboon.png"
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: FadeInImage.assetNetwork(
                              placeholder: "assets/images/404.png", image: i));
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
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     "Bihu:",
              //     style: TextStyle(fontSize: 18),
              //   ),
              // ),
              // Container(
              //   color: Colors.transparent,
              //   height: 220,
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     itemCount: widget.bihus.length,
              //     itemBuilder: (BuildContext ctxt, int index) {
              //       return ProductItemVIew(
              //         buttonSize: buttonSize,
              //         list: widget.bihus,
              //         Index: index,
              //         OnTap: () {
              //           Navigator.push(
              //               context,
              //               PageTransition(
              //                   type: PageTransitionType.fade,
              //                   child: ProductView(widget.bihus[index])));
              //         },
              //       );
              //     },
              //   ),
              // ),
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
                  itemCount: Provider.of<CartData>(context, listen: false)
                      .allproducts
                      .length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return ProductItemVIew(
                      buttonSize: buttonSize,
                      list: Provider.of<CartData>(context, listen: false)
                          .allproducts,
                      Index: index,
                      OnTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: ProductView(product:
                                    Provider.of<CartData>(context, listen: false)
                                        .allproducts[index],parent: widget.parent)));
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
