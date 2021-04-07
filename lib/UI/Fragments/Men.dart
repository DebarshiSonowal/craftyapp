import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/Activity/Host.dart';
import 'package:crafty/UI/CustomWidgets/CombineRecyclerviewHorizontal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class MenProducts extends StatefulWidget {
  final HostState parent;
  @override
  _MenProductsState createState() => _MenProductsState();

  MenProducts(this.parent);
}

class _MenProductsState extends State<MenProducts> {
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
                  "Men's Products",
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
                    CombinerRecyclerView(buttonSize: buttonSize,name: "Shirt",list: Provider.of<CartData>(context, listen: false).men,parent: widget.parent,),
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

