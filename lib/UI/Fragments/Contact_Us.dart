import 'package:crafty/UI/Activity/T&C.dart';
import 'package:crafty/UI/CustomWidgets/ContactIconButton.dart';
import 'package:crafty/UI/Styling/Styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sizer/sizer.dart';
class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            fit: BoxFit.fitWidth,
              height: 17.h,
              width:  17.w,
              image: AssetImage('assets/images/crafty.png')),
          Padding(
            padding: EdgeInsets.only(left: 2.w,right: 2.w),
            child: Text(
              "We are manufacturer of high quality clothing like hoodie, t-shirts etc.\n"
              "We are committed to satisfaction our customers the best quality of products at reasonable price.\n"
              "Customer satisfaction is our utmost priority.",
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: "Somana",
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Center(
                child: Text(
              "Reach us on",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ContactIconButton(() {
                _makingPhoneCall();
              }, Colors.blueAccent, FontAwesomeIcons.phoneAlt,
                  Color(0xff4867AA)),
              ContactIconButton(() {
                try {
                  _launchURL("https://craftyfashions.com");
                } catch (e) {
                  print(e);
                }
              }, Color(0xffD93084), FontAwesomeIcons.chrome,
                  Color(0xffD64135)),
              ContactIconButton(() {
                try {
                  _launchURL(
                      "https://play.app.goo.gl/?link=https://play.google.com/store/apps/details?id=com.craftyfashion.crafty");
                } catch (e) {
                  print(e);
                }
              }, Color(0xff4EB207), FontAwesomeIcons.googlePlay,
                  Color(0xff4EB207)),
              ContactIconButton(() {
                notavailable();
              }, Color(0xff17B4F3), FontAwesomeIcons.appStore,
                  Color(0xff17B4F3)),
              ContactIconButton(() {
                _sendemail();
              }, Color(0xffBF211E), Icons.email, Color(0xffBF211E))
            ],
          ),
          Center(
              child: Text(
            "Follow Us",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ContactIconButton(() {
                _launchSocial('fb://page/109839907854388',
                    'https://www.facebook.com/Crafty-fashions-109839907854388');
              }, Colors.blueAccent, FontAwesomeIcons.facebookF,
                  Color(0xff4867AA)),
              ContactIconButton(() {
                try {
                  _launchURL("https://www.instagram.com/crafty_fashions_/");
                } catch (e) {
                  print(e);
                }
              }, Color(0xffD93084), FontAwesomeIcons.instagram,
                  Color(0xffD93084)),
              ContactIconButton(() {
                _sendWhatsapp();
              }, Color(0xff00A2F3), FontAwesomeIcons.whatsapp,
                  Color(0xff4ECD5C)),
              ContactIconButton(() {
               _launchURL('https://twitter.com/crafty_fashions?fbclid=IwAR1MwvrWA6Gntr-OfGB25ARExBA90o11zXrjohB3o6acB2H90nV0d-RbIxU');
              }, Color(0xff00A2F3), FontAwesomeIcons.twitter,
                  Color(0xff00A2F3))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 5.h,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: HelpScreen("Return")));
                    },
                    child: Text('Return Policy')),
              ),
              SizedBox(
                height: 5.h,
                child: ElevatedButton(
                    onPressed: _launchPrivacy, child: Text('Privacy Policy')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _makingPhoneCall() async {
    const url = 'tel:8011011178';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void notavailable() {
    Styles.showWarningToast(Colors.deepOrange, "Coming Soon", Colors.white, 15);
  }

  void _sendWhatsapp() async {
    const url = "whatsapp://send?phone=+918011011178";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _sendemail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'info@craftyfashions.com',
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  void _launchURL(String txt) async {
    var url = Uri.encodeFull(txt);
    // var url = Uri.encodeComponent(urls);
    try {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false, forceWebView: false);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    }
  }

  void _launchSocial(String url, String fallbackUrl) async {
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    try {
      bool launched =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }
}

void _launchPrivacy() async {
  const urls =
      'https://www.freeprivacypolicy.com/live/2bed81fc-8c4f-4fe6-8015-8fcdcb5cc8e0';
  var url = Uri.encodeFull(urls);
  // var url = Uri.encodeComponent(urls);
  try {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    await launch(url, forceSafariVC: false, forceWebView: false);
  }
}
