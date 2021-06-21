import 'dart:async';

import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/Activity/Host.dart';
import 'package:crafty/UI/Fragments/ProductView.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:provider/provider.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:sizer/sizer.dart';
import 'CartData.dart';

class DataSearch extends SearchDelegate {
  var name, INDEX = 0;
  var suggestionList;
  final FragNavigate _fragNav;

  DataSearch(this._fragNav);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Products product;
    for (var i in Provider.of<CartData>(context, listen: false).allproducts) {
      try {
        if (suggestionList[INDEX].toString().toUpperCase ==
            i.Name.toString().toUpperCase) {
          product = i;
          break;
        } else {
          print("NOP ${i.Name}");
        }
      } catch (e) {
        print(e);
      }
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      child: product == null
          ? EmptyListWidget(
              title: 'No Found',
              subTitle: 'Search with something else',
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
                  .copyWith(color: Color(0xffabb8d6)))
          : Center(
              child: ProductView(
              fragNav: _fragNav,
              product: product,
            )),
      // color: Colors.amber,
      // child: Text(Test.bihuProducts[INDEX].Name),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    suggestionList = query.isEmpty
        ? getListOfNames(context)
        : getListOfNames(context)
            .where((element) => element.contains(query.toUpperCase()))
            .toList(growable: true);

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          name = suggestionList[index].substring(0, query.length);
          INDEX = index;
          print(suggestionList[index]);
          print("''''");
          print(getListOfNames(context)[index]);
          showResults(context);
        },
        leading: Icon(FontAwesomeIcons.search),
        title:SubstringHighlight(
          textStyle: TextStyle(color: Colors.black,fontFamily: 'Halyard',fontSize:12.sp),
          text:  suggestionList[index],     // search result string from database or something
          term: query,       // user typed "et"
        ),
      ),
      itemCount: suggestionList.length,
    );
  }

  List<String> getListOfNames(BuildContext context) {
    List<String> list = [];
    for (int i = 0;
        i < Provider.of<CartData>(context, listen: false).allproducts.length;
        i++) {
      list.add(Provider.of<CartData>(context, listen: false)
          .allproducts[i]
          .Name
          .toString());
    }
    return list;
  }
}
