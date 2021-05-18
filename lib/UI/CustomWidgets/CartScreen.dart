import 'dart:convert';

import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'CartItems.dart';

class CartScreenn extends StatefulWidget {
  int item;
Function save,onOrderInit;
  CartScreenn({this.item,this.save,this.onOrderInit});

  @override
  _CartScreennState createState() => _CartScreennState();

}

class _CartScreennState extends State<CartScreenn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
                child: Text(
                  "Shopping Cart",
                  style: TextStyle(fontSize: 25),
                )),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17.0),
              ),
              child: IconButton(
                iconSize: 30,
                splashRadius: 30,
                onPressed: () {
                  setState(() {
                    Provider.of<CartData>(context, listen: false)
                        .removeAll(0, widget.item);
                    Styles.showWarningToast(
                        Styles.Log_sign, "All items removed", Colors.black, 15);
                  });
                },
                enableFeedback: true,
                splashColor: Colors.redAccent,
                icon: Icon(
                  FontAwesomeIcons.trash,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Want to add more?',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.plus,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Test.fragNavigate.putPosit(key: 'Home', force: true);
                  })
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width / 1.4,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: Provider.of<CartData>(context).listLength,
            itemBuilder: (BuildContext ctxt, int index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (item) {
                  Styles.showWarningToast(
                      Styles.Log_sign, "Item removed", Colors.black, 15);
                  setState(() {
                    Provider.of<CartData>(context, listen: false)
                        .removeProduct(index);
                    var json = jsonEncode(
                        Provider.of<CartData>(context, listen: false)
                            .list
                            .map((e) => e.toJson())
                            .toList());
                    widget.save("data", json);
                  });
                },
                child: CartItem(
                  index: index,
                  list: Provider.of<CartData>(context).list,
                  callback: () {
                    Styles.showWarningToast(
                        Styles.Log_sign, "Item removed", Colors.black, 15);
                    setState(() {
                      Provider.of<CartData>(context, listen: false)
                          .removeProduct(index);
                      var json = jsonEncode(
                          Provider.of<CartData>(context, listen: false)
                              .list
                              .map((e) => e.toJson())
                              .toList());
                      widget.save("data", json);
                    });
                  },
                  th: false,
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 1,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: Colors.grey,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "${Provider.of<CartData>(context).listLength} Items",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            Text(
              "${Provider.of<CartData>(context).getPrice()}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: FlatButton(
            height: MediaQuery.of(context).size.width / 7,
            minWidth: MediaQuery.of(context).size.width,
            splashColor: Colors.white,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(6.0)),
            padding: EdgeInsets.all(8),
            color: Colors.deepOrangeAccent,
            onPressed:widget.onOrderInit,
            child: Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
