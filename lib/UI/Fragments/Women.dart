import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/UI/Activity/Host.dart';
import 'package:crafty/UI/CustomWidgets/CombineRecyclerviewHorizontal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class WomenProducts extends StatefulWidget {
  final HostState parent;

  WomenProducts(this.parent);

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
                    CombinerRecyclerView(buttonSize: buttonSize,name: "Shirt",list: Provider.of<CartData>(context, listen: false).women,parent: widget.parent,),
                    // CombinerRecyclerView(buttonSize: buttonSize,name: "Shirt",list: Test.bihuProducts,),
                    // CombinerRecyclerView(buttonSize: buttonSize,name: "Pant",list: Test.bihuProducts,),
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
