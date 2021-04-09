import 'dart:async';

import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/Activity/Host.dart';
import 'package:crafty/UI/Fragments/ProductView.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:provider/provider.dart';

import 'CartData.dart';

class DataSearch extends SearchDelegate {
  var name, INDEX = 0;
  var suggestionList;
  final FragNavigate _fragNav;
  final cities = [
    "Kokrajhar",
    "Sivsagar",
    "Jorhat",
    "Nagaon",
    "Mumbai",
    "Delhi",
    "Golaghat"
  ];

  final recentCities = [
    "Jorhat",
    "Nagaon",
    "Mumbai",
  ];

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
    final int searched = int.tryParse(query);
    print(name);
    Products product;
    for(var i in Provider.of<CartData>(context, listen: false).allproducts){
      if(suggestionList[INDEX] == i.Name){
        product = i;
        break;
      }
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(child: ProductView(fragNav: _fragNav,product: product,)),
      // color: Colors.amber,
      // child: Text(Test.bihuProducts[INDEX].Name),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    suggestionList = query.isEmpty
        ? getListOfNames(context)
        : getListOfNames(context)
            .where((element) => element.startsWith(query))
            .toList(growable: true);

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          print("before");
          for(var i in suggestionList){
            print(i);
          }
          print("after ");
          name = suggestionList[index].substring(0, query.length);
          INDEX = index;
          print("on tap");
          print(suggestionList[index]);
          print("''''");
          print(getListOfNames(context)[index]);
          showResults(context);
        },
        leading: Icon(FontAwesomeIcons.search),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }

  List<String> getListOfNames(BuildContext context) {
    List<String> list = [];
    for (int i = 0; i < Provider.of<CartData>(context, listen: false).allproducts.length; i++) {
      list.add(Provider.of<CartData>(context, listen: false).allproducts[i].Name.toString());
    }
    return list;
  }
}
