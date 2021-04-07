
import 'package:crafty/Models/Products.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
class ProductItemVIew extends StatelessWidget {
  const ProductItemVIew(
      {Key key,
      @required this.buttonSize,
      @required this.list,
      @required this.OnTap,
      @required this.Index})
      : super(key: key);

  final List<Products> list;
  final double buttonSize;
  final Function OnTap;
  final int Index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: Card(
        margin: EdgeInsets.all(10),
        color: Colors.transparent,
        elevation: 3,
        child: Container(
          width: 155,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
                height: 4,
              ),
              FadeInImage.assetNetwork(
                placeholder: "assets/images/404.png",
                image: list[Index].Image.toString().split(",")[0],
                fit: BoxFit.fitHeight,
                height: 100,
                width: 120,
              ),
              SizedBox(
                height: 3,
              ),
              Flexible(
                child: Text(
                  list[Index].Name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 30),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Flexible(
                child: Text(
                  "₹ ${list[Index].Price}",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
