import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/CustomWidgets/GroupButton.dart';
import 'package:crafty/UI/CustomWidgets/ImageSlider.dart';
import 'package:crafty/UI/CustomWidgets/Photoview.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'ProductSummary.dart';

class ProductView extends StatefulWidget {
  final FragNavigate fragNav;

  ProductView({this.product, this.fragNav});

  final Products product;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView>
    with TickerProviderStateMixin {
  get buttonSize => 30.0;
  var selectedColor;
  var selectedSize;
  var snackBar;
  var currentIndex = 0;
  int quantity = 1;
  int currentPhoto = 0;
  List<int> lst = [1, 22, 3];
  int Index;
  final TextStyle lowstyle = TextStyle(
    fontFamily: "Halyard",
    color: Colors.black54,
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
  CarouselController controller = CarouselController();

  @override
  void initState() {
    super.initState();
    try {
      print("Colada  ${widget.product.Color.split(",").length}");
      widget.product.Color.split(",").length == 1 ? setDefaultColor() : null;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Colors ${widget.product.Color
        .split(",")}");
    return Material(
      child: SafeArea(
        child: Container(
          color: Color(0xffe3e3e6),
          child: Column(
            children: [
              Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              child: CarouselWithIndicatorDemo(
                                  widget.product,
                                  Test.fragNavigate,
                                      (index) => onTapeed(index), (t) {
                                setState(() {
                                  currentIndex = t;
                                });
                              }, Color(0xffececec),controller),
                            ),
                            Card(
                              elevation: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Color(0xffE3E3E3),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        widget.product.Name,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Styles.font,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 10, top: 8),
                                      child: Text(
                                        "${widget.product.Short}",
                                        style: TextStyle(
                                          fontFamily: "Halyard",
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 10, top: 8),
                                      child: Row(
                                        children: [
                                          Text(
                                            "₹${widget.product.Price}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: Styles.font,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "₹699",
                                            style: TextStyle(
                                              decoration:
                                              TextDecoration.lineThrough,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: Styles.font,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 10, top: 2),
                                      child: Text(
                                        "inclusive of all taxes",
                                        style: TextStyle(
                                          color: Styles.price_color,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: Styles.font,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      child: Container(
                                        color: Color(0xffE4E4E7),
                                      ),
                                      height: 0.2,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 2, bottom: 5),
                                      child: Text(
                                        "Expected delivery time is 5-7 working days",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontFamily: Styles.font,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Color(0xffE3E3E3),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 5, left: 10),
                                      child: Text(
                                        "Easy 15 days returns and exchanges",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: Styles.font,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 5, left: 10),
                                      child: Text(
                                        "Choose to return or exchange for a  different size (if available) within 15 days of delivery",
                                        style: TextStyle(
                                          fontFamily: "Halyard",
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Color(0xffE3E3E3),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Colors",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: Styles.font,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: GroupButton(
                                          width: 20.w,
                                          height: 5.h,
                                          spacing:
                                          MediaQuery.of(context).size.height,
                                          elevation: 5,
                                          customShape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          absoluteZeroSpacing: true,
                                          unSelectedColor: Colors.white54,
                                          buttonLables:
                                          widget.product.Color.split(","),
                                          buttonValues:
                                          widget.product.Color.split(","),
                                          buttonTextStyle: ButtonTextStyle(
                                              selectedColor: Styles.price_color,
                                              unSelectedColor: Colors.black,
                                              textStyle: TextStyle(fontSize: 7.sp,fontFamily: 'Halyard')),
                                          radioButtonValue: (value) {
                                            setState(() {
                                              selectedColor = value;
                                              // selectedSize = null;
                                              controller.jumpToPage(getIndex());
                                            });
                                            if (!getLabels()
                                                .contains(selectedSize)) {
                                              selectedSize = null;
                                            }
                                          },
                                          selectedColor: Styles.Log_sign,
                                          defaultSelected:widget.product.Color
                                              .split(",").length==1? widget.product.Color
                                              .split(",")[currentIndex]:null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Color(0xffE3E3E3),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Size",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: Styles.font,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Container(
                                          child: DropdownButton<String>(
                                            focusColor: Colors.white,
                                            value: selectedSize,
                                            //elevation: 5,
                                            style: TextStyle(color: Colors.white),
                                            iconEnabledColor: Colors.black,
                                            items: getLabels()
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  );
                                                }).toList(),
                                            hint: Text(
                                              "",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            onChanged: (String value) {
                                              setState(() {
                                                selectedSize = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Quantity:",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: Styles.font,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                FontAwesomeIcons.minus,
                                                color: Colors.black,
                                                size: 2.h,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  quantity == 1
                                                      ? Styles.showWarningToast(
                                                      Colors.yellow,
                                                      "Minimum is one",
                                                      Colors.black,
                                                      15)
                                                      : quantity--;
                                                });
                                              },
                                            ),
                                            Card(
                                                elevation: 0,
                                                color: Styles.bg_color,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(1.0),
                                                  child: Text(
                                                    "${quantity}",
                                                    style: TextStyle(
                                                        fontFamily: "Halyard",
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14.sp),
                                                  ),
                                                )),
                                            IconButton(
                                              icon: Icon(
                                                FontAwesomeIcons.plus,
                                                color: Colors.black,
                                                size: 2.h,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  quantity == 5
                                                      ? Styles.showWarningToast(
                                                      Colors.yellow,
                                                      "Miximum is 5",
                                                      Colors.black,
                                                      15)
                                                      : quantity++;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 0.3.w,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: Container(
                                padding: EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Color(0xffE3E3E3),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "SIZE CHART",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: Styles.font,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Container(
                                      height: 200,
                                      child: PhotoView(
                                        backgroundDecoration: BoxDecoration(
                                          color: Colors.white,
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
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.3.h,
                            ),
                            Card(
                              elevation: 1,
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Color(0xffE3E3E3),
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: new TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Fit : ",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: Styles.font,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Regular Fit\n',
                                          style: TextStyle(
                                            fontFamily: "Halyard",
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Material : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: Styles.font,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                          '100% Cotton, Bio-Washed & Pre-Shrunk\n',
                                          style: TextStyle(
                                            fontFamily: "Halyard",
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Wash Care : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: Styles.font,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                          'Machine wash. Wash in cold water, use mild detergent, dry in shade , do not iron directly on print, do not bleach, do not tumble dry. Dry on flat surface as hanging may cause measurement variations.\n',
                                          style: TextStyle(
                                            fontFamily: "Halyard",
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Sizing : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: Styles.font,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                          'Please refer to the size chart to see which size fits you the best.\n',
                                          style: TextStyle(
                                            fontFamily: "Halyard",
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Please Note : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: Styles.font,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                          'Colors may slightly vary depending upon your screen brightness.',
                                          style: TextStyle(
                                            fontFamily: "Halyard",
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            Card(
                              elevation: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Color(0xffE3E3E3),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(2),
                                child: Image.asset("assets/images/payment.jpg"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: IconButton(
                                splashColor: Colors.white,
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: IconButton(
                                icon: Badge(
                                    showBadge:
                                    Provider.of<CartData>(context).listLength ==
                                        0
                                        ? false
                                        : true,
                                    badgeContent: Text(
                                        "${Provider.of<CartData>(context).listLength}",
                                        style: TextStyle(color: Colors.white)),
                                    animationType: BadgeAnimationType.scale,
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                    )),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Test.fragNavigate
                                      .putPosit(key: 'Cart', force: true);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Card(
                elevation: 1.5,
                child: Container(
                  height: 7.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      new BoxShadow(
                        color: Color(0xffE3E3E3),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    child: Text(
                      'Proceed',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: Styles.font,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (selectedSize != null) {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            isDismissible: true,
                            isScrollControlled: false,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setModelState) {
                                  return Wrap(
                                    children: [
                                      ProductSummary(
                                      getIndex(),
                                  quantity,
                                  widget.product,
                                  () {},
                                  selectedColor,
                                  selectedSize)
                                    ],
                                  );
                                },
                              );
                            }).whenComplete(() {
                          if (mounted) {
                            setState(() {

                            });
                          } else {

                          }
                        });
                      } else {
                        Styles.showWarningToast(Colors.red,
                            "Please select a size", Colors.white, 18);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getLabels() {
    var list = widget.product.Color.split(",");
    int i = list.indexOf(
        selectedColor == null ? list[0].toString() : selectedColor.toString());
    var lst = widget.product.Size.split(".");
    return lst[i].toString().split(",");
  }

  bool checkGender() {
    print(widget.product.Gender.toString());
    return widget.product.Gender.toString().trim() == "MALE" ? true : false;
  }

  onTapeed(int index) {
    print("Tapped");
    Index = index;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Photoview(
                widget.product.Image.toString().split(',')[index].trim())));
  }

  getIndex() {
    if (widget.product.Image.toString().split(",").length > -1 &&
        widget.product.Image.toString().split(",").length >
            widget.product.Color.toString().split(",").indexOf(selectedColor)) {
      return widget.product.Color.toString().split(",").indexOf(selectedColor);
    } else {
      return 0;
    }
  }

  setDefaultColor() {
    selectedColor = widget.product.Color.split(",")[0];
  }
}
