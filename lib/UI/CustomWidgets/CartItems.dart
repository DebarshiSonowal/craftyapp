import 'package:crafty/Models/CartProduct.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartItem extends StatelessWidget {
  Function callback;
  int index;
  List<CartProduct> list;
  CartItem({this.index, this.list,this.callback});




  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.all(10),
      color: Colors.white,
      elevation: 1,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: InkWell(
          radius: MediaQuery.of(context).size.width,
          splashColor: Colors.black54,
          onTap: () {
            print(index);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/404.png",
                    image: list[index].picture.split(",")[0],
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${list[index].name}",
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "₹ ${list[index].payment}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(FontAwesomeIcons.minus,color: Colors.red,),
                      onPressed: callback,
                      iconSize: 15,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color(0xffF5F4F6),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "x${list[index].quantity}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
