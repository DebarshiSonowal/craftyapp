import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/UI/Activity/Host.dart';
import 'package:crafty/UI/CustomWidgets/CombineRecyclerviewHorizontal.dart';
import 'package:crafty/UI/CustomWidgets/ProductItemView.dart';
import 'package:flutter/material.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'ProductView.dart';

class WomenProducts extends StatefulWidget {

  WomenProducts();

  @override
  _WomenProductsState createState() => _WomenProductsState();
}

class _WomenProductsState extends State<WomenProducts> {
  get buttonSize => 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 50,
              child: Center(
                child: Text(
                  "Women's Products",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Sumana",
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Shirt",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: GridView.count(
                          scrollDirection: Axis.vertical,
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          shrinkWrap: true,
                          children: List.generate(
                              Provider.of<CartData>(context, listen: false)
                                  .women
                                  .length, (index) {
                            return ProductItemVIew(
                                buttonSize: buttonSize,
                                list: Provider.of<CartData>(context,
                                    listen: false)
                                    .women,
                                OnTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: ProductView(
                                            product: Provider.of<CartData>(
                                                context,
                                                listen: false)
                                                .women[index],
                                            fragNav: Test.fragNavigate,
                                          )));
                                },
                                Index: index);
                          })),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
