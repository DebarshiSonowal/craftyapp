import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty/Helper/CartData.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Models/CartProduct.dart';
import 'package:crafty/Models/Products.dart';
import 'package:crafty/UI/Activity/PhotoviewAsset.dart';
import 'package:crafty/UI/CustomWidgets/GroupButton.dart';
import 'package:crafty/UI/CustomWidgets/ImageSlider.dart';
import 'package:crafty/UI/CustomWidgets/Photoview.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductView extends StatefulWidget {
  final FragNavigate fragNav;

  ProductView({this.product, this.fragNav});
  int quantity = 1;

  final Products product;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  get buttonSize => 30.0;
  var selectedColor;
  var selectedSize;
  var snackBar;
  var currentIndex = 0;
  int currentPhoto = 0;
  List<int> lst = [1, 22, 3];
  int Index;

  @override
  void initState() {
    selectedColor = widget.product.Color.toString().split(",")[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Styles.bg_color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    color: Colors.white70,
                    child: IconButton(
                      splashColor: Colors.white,
                      icon: Icon(
                        Icons.arrow_back,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Card(
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LikeButton(
                        size: buttonSize,
                        circleColor: CircleColor(
                            start: Color(0xff00ddff), end: Color(0xff0099cc)),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Color(0xff33b5e5),
                          dotSecondaryColor: Color(0xff0099cc),
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            FontAwesomeIcons.heart,
                            color: isLiked ? Colors.red : Colors.grey,
                            size: buttonSize,
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              Flexible(
                flex: 2,
                child: CarouselWithIndicatorDemo(
                    widget.product, Test.fragNavigate, (index)=>onTapeed(index),(t){
                      setState(() {
                        currentIndex = t;
                        print(currentIndex);
                      });
                }),
              ),
              Flexible(
                flex: 2,
                child: Card(
                  color: Colors.white,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                      ),
                      child: CustomScrollView(
                        scrollDirection: Axis.vertical,
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: Text(
                                          widget.product.Name,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
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
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Text("${widget.product.Short}"),
                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Available Colors:",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: GroupButton(
                                    width: 85,
                                    spacing: MediaQuery.of(context).size.height,
                                    elevation: 5,
                                    customShape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    absoluteZeroSpacing: true,
                                    unSelectedColor:
                                        Theme.of(context).canvasColor,
                                    buttonLables:
                                        widget.product.Color.split(","),
                                    buttonValues:
                                        widget.product.Color.split(","),
                                    buttonTextStyle: ButtonTextStyle(
                                        selectedColor: Colors.black,
                                        unSelectedColor: Colors.black,
                                        textStyle: TextStyle(fontSize: 12)),
                                    radioButtonValue: (value) {
                                      setState(() {
                                        selectedColor = value;
                                        print("selected $selectedColor $value");
                                        // selectedSize = null;
                                      });
                                      print("selected $selectedColor");
                                    },
                                    selectedColor: Styles.Log_sign,
                                    defaultSelected:
                                        widget.product.Color.split(",")[currentIndex],
                                  ),
                                ),
                                TextButton(
                                  child: Text("Size Chart",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                  onPressed: (){
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade, child: PhotoviewAsset(checkGender()==true?"Men":"Women")));
                                  },
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: 300, height: 50),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Styles.Log_sign),
                                    ),
                                    child: Text(
                                      'Order',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      print("AS $selectedColor");
                                      showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          isDismissible: true,
                                          isScrollControlled: true,
                                          builder: (BuildContext context) {
                                            return StatefulBuilder(
                                              builder: (BuildContext context,
                                                  StateSetter setModelState) {
                                                return BottomContainer(
                                                    context, setModelState);
                                              },
                                            );
                                          }).whenComplete(() {
                                        setState(() {
                                          selectedSize = null;
                                          widget.quantity = 1;
                                        });
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Card BottomContainer(BuildContext context, StateSetter setModelState) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.width,
          color: Colors.white70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 2,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade, child: Photoview(widget.product.Image
                                .toString()
                                .split(",")[getIndex()]
                                .trim())));
                      },
                      child: CachedNetworkImage(
                        imageUrl:  widget.product.Image
                            .toString()
                            .split(",")[getIndex()]
                            .trim(),
                        height: MediaQuery.of(context).size.width / (2.5),
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: Shimmer.fromColors(
                                baseColor: Colors.red,
                                highlightColor: Colors.yellow,
                                child: Center(
                                  child: Text(
                                    'Please Wait',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.product.Name.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(selectedColor),
                        Text(
                          "₹${widget.product.Price}",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Available Sizes:",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: CustomRadioButton(
                  width: 65,
                  elevation: 5,
                  customShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  absoluteZeroSpacing: true,
                  unSelectedColor: Theme.of(context).canvasColor,
                  buttonLables: getLabels(),
                  buttonValues: getLabels(),
                  buttonTextStyle: ButtonTextStyle(
                      selectedColor: Colors.black,
                      unSelectedColor: Colors.black,
                      textStyle: TextStyle(fontSize: 12)),
                  radioButtonValue: (value) {
                    selectedSize = value;
                    print(value);
                  },
                  selectedColor: Styles.Log_sign,
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
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
                            setModelState(() {
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
                            setModelState(() {
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
                child: Container(
                  width: MediaQuery.of(context).size.width / (1.2),
                  height: MediaQuery.of(context).size.width / 5,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedColor != null && selectedSize != null) {
                        Navigator.pop(context);
                        show();
                      } else {
                        Styles.showWarningToast(Styles.Log_sign,
                            'Please select a size', Colors.black, 16);
                      }
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Styles.Log_sign),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  show() {
    Provider.of<CartData>(context, listen: false).addProduct(CartProduct(
        selectedColor,
        widget.product.Price,
        widget.product.Image.toString().split(",")[getIndex()].trim(),
        widget.quantity,
        selectedSize,
        widget.product.Name,
        widget.product.Id));
    Styles.showSnackBar(context, Colors.green, Duration(seconds: 5),
        'Product Added', Colors.white, () {
      setState(() {
        Navigator.pop(context);
        widget.fragNav.putPosit(key: 'Cart');
      });
    });
  }

  getLabels() {
    var list = widget.product.Color.split(",");
    print(list);
    int i = list.indexOf(
        selectedColor == null ? list[0].toString() : selectedColor.toString());
    print(list
        .indexOf(selectedColor == null ? list[0].toString() : selectedColor)
        .toString());
    var lst = widget.product.Size.split(".");
    return lst[i].toString().split(",");
  }

  getIndex() {
    if (widget.product.Image.toString().split(",").length > -1 &&
        widget.product.Image.toString().split(",").length >
            widget.product.Color.toString().split(",").indexOf(selectedColor)) {
      print(widget.product.Image.toString().split(",").length);
      print(widget.product.Color.toString().split(",").indexOf(selectedColor));
      print(
          "DW ${widget.product.Color.toString().split(",").indexOf(selectedColor)}");
      return widget.product.Color.toString().split(",").indexOf(selectedColor);
    } else {
      print(selectedColor);
      print(widget.product.Image.toString().split(",").length);
      print(widget.product.Color.toString().split(",").indexOf(selectedColor));
      print("DW 0");
      return 0;
    }
  }

  onTapeed(int index) {
    print("Tapped");
    Index = index;
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: Photoview(widget.product.Image
                .toString()
                .split(',')[index]
                .trim())));
  }

  bool checkGender() {
    print(widget.product.Gender.toString());
    return widget.product.Gender.toString().trim() == "MALE";
  }
}
