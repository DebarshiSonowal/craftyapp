
import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/Activity/Host.dart';
import 'package:crafty/UI/Fragments/ProductView.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'ProductItemView.dart';



class CombinerRecyclerView extends StatelessWidget {
  const CombinerRecyclerView({
    @required this.buttonSize,
    @required this.list,
    @required this.name, this.parent,
  });
  final HostState parent;
  final double buttonSize;
  final List<Products>list;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$name:",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          color: Colors.transparent,
          height: 220,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return ProductItemVIew(
                buttonSize: buttonSize,
                list: list,
                Index: index,
                OnTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child:
                          ProductView(product: list[index],parent: parent,)));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
