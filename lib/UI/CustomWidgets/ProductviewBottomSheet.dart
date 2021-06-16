
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';

import 'GroupButton.dart';

class ProductviewBottomSheet extends StatefulWidget {
  Function getIndex, getLabels;
  final Function(String, String, int) show;
  var product, selectedSize, selectedColor, currentIndex;
  int quantity=1;
  ProductviewBottomSheet(this.getIndex, this.getLabels, this.show, this.product, this.currentIndex);

  @override
  _ProductviewBottomSheetState createState() => _ProductviewBottomSheetState();
}

class _ProductviewBottomSheetState extends State<ProductviewBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / (1),
      decoration: BoxDecoration(
        color: Color(0xffe3e3e6),
      ),
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          widget.product.Name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: Styles.font,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text(
                        "₹${widget.product.Price}",
                        style: TextStyle(
                          color: Styles.price_color,
                          fontWeight: FontWeight.w500,
                          fontFamily: Styles.font,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Description:",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontFamily: Styles.font,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("${widget.product.Short}"),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Available Colors:",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontFamily: Styles.font,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
                      child: GroupButton(
                        width: 85,
                        spacing: MediaQuery.of(context).size.height,
                        elevation: 5,
                        customShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        absoluteZeroSpacing: true,
                        unSelectedColor: Colors.white54,
                        buttonLables: widget.product.Color.split(","),
                        buttonValues: widget.product.Color.split(","),
                        buttonTextStyle: ButtonTextStyle(
                            selectedColor: Styles.price_color,
                            unSelectedColor: Colors.black,
                            textStyle: TextStyle(fontSize: 12)),
                        radioButtonValue: (value) {
                          setState(() {
                            widget.selectedColor = value;
                            widget.show(value,widget.selectedSize,widget.quantity);
                            // selectedSize = null;
                          });
                        },
                        selectedColor: Styles.Log_sign,
                        defaultSelected: widget.product.Color
                            .split(",")[widget.currentIndex],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Quantity:",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontFamily: Styles.font,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 4,
                        child: Card(
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.minus,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.quantity == 1
                                    ? Styles.showWarningToast(Colors.yellow,
                                        "Minimum is one", Colors.black, 15)
                                    : widget.quantity--;
                              });
                            },
                          ),
                        ),
                      ),
                      Flexible(
                          flex: 4,
                          child: Card(
                              elevation: 0,
                              color: Styles.bg_color,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${widget.quantity}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ))),
                      Flexible(
                        flex: 4,
                        child: Card(
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.plus,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.quantity == 5
                                    ? Styles.showWarningToast(Colors.yellow,
                                        "Miximum is 5", Colors.black, 15)
                                    : widget.quantity++;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Available Sizes:",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontFamily: Styles.font,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: CustomRadioButton(
                        width: 65,
                        elevation: 5,
                        customShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        absoluteZeroSpacing: true,
                        unSelectedColor: Colors.white54,
                        buttonLables: widget.getLabels(),
                        buttonValues: widget.getLabels(),
                        buttonTextStyle: ButtonTextStyle(
                            selectedColor: Styles.price_color,
                            unSelectedColor: Colors.black,
                            textStyle: TextStyle(fontSize: 12)),
                        radioButtonValue: (value) {
                          widget.selectedSize = value;
                          widget.show(widget.selectedColor,value,widget.quantity);
                        },
                        selectedColor: Styles.Log_sign,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 6,
                  child: Container(
                    height: 200,
                    child: PhotoView(
                      backgroundDecoration: BoxDecoration(
                        color: Color(0xffe3e3e6),
                      ),
                      // ignore: unrelated_type_equality_checks
                      imageProvider: checkGender() == true
                          ? AssetImage(
                              "assets/images/men.jpg",
                            )
                          : AssetImage(
                              'assets/images/women.jpg',
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  bool checkGender() {
    return widget.product.Gender.toString().trim() == "MALE" ? true : false;
  }


}
