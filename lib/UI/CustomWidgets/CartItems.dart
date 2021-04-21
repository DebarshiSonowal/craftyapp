import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty/Models/CartProduct.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartItem extends StatelessWidget {
  Function callback;
  int index;
  List<CartProduct> list;

  CartItem({this.index, this.list, this.callback});

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
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: list[index].picture,
                    height: 100,
                    width: 100,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Padding(
                      padding: EdgeInsets.only(
                          top: 25.0, bottom: 25.0, left: 20, right: 20),
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text('Price:'),
                            Text('Size:'),
                            Text('Color:'),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "₹ ${list[index].payment}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "${list[index].size}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "${list[index].color}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    TextButton(
                        onPressed: callback,
                        child: Text(
                          'remove',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                          ),
                        )),
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
