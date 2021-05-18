import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/CustomWidgets/ProductItemView.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'ProductView.dart';

class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();

  AllProducts();
}

class _AllProductsState extends State<AllProducts> {
  get buttonSize => 20.0;
  EmptyListWidget emptyListWidget;
  var _selected = null;

  @override
  Widget build(BuildContext context) {
    return Provider.of<CartData>(context, listen: false).allproducts.length == 0
        ? emptyListWidget
        : Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                          value: _selected,
                          isExpanded: true,
                          style: TextStyle(color: Colors.black, fontSize: 18),
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
                                Provider.of<CartData>(context, listen: false)
                                    .setSortedList(Provider.of<CartData>(
                                            context,
                                            listen: false)
                                        .allproducts);
                                Provider.of<CartData>(context, listen: false)
                                    .sorted
                                    .sort((a, b) => double.parse(a.Price)
                                        .compareTo(double.parse(b.Price)));
                              } else {
                                Provider.of<CartData>(context, listen: false)
                                    .setSortedList(Provider.of<CartData>(
                                            context,
                                            listen: false)
                                        .allproducts);
                                Provider.of<CartData>(context, listen: false)
                                    .sorted
                                    .sort((a, b) => double.parse(b.Price)
                                        .compareTo(double.parse(a.Price)));
                              }
                            });
                          }),
                    ),
                  ),
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height -
                                  (MediaQuery.of(context).size.width / (1.5)),
                              child: GridView.count(
                                  scrollDirection: Axis.vertical,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  shrinkWrap: true,
                                  children: List.generate(getLength(), (index) {
                                    return ProductItemVIew(
                                        buttonSize: buttonSize,
                                        list: getAppropriateList(),
                                        OnTap: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: ProductView(
                                                    product:
                                                        getAppropriateList()[
                                                            index],
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
          );
  }

  @override
  void initState() {
    emptyListWidget = EmptyListWidget(
        title: 'No Items',
        subTitle: 'No Items added to the cart',
        image: 'assets/images/404.png',
        titleTextStyle: TextStyle(
          color: Color(0xff9da9c7),
        ),
        subtitleTextStyle: TextStyle(
          color: Color(0xffabb8d6),
        ));
    super.initState();
  }

  List<Products> getAppropriateList() {
    return _selected != null
        ? Provider.of<CartData>(context, listen: false).sorted
        : Provider.of<CartData>(context, listen: false).allproducts;
  }

  int getLength() {
    return getAppropriateList().length;
  }
}
