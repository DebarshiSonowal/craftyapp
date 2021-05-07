import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class QuoteCard extends StatelessWidget {
  String asset,txt;
  Function function;
  QuoteCard(this.asset, this.txt, this.function);
  @override
  Widget build(BuildContext context) {
   return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width:function()? MediaQuery.of(context).size.width * 1:MediaQuery.of(context).size.width/4,
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(asset, height: 100, width: 120),
            Flexible(
                child: Text(
                  txt,
                  softWrap: true,
                  style: TextStyle(
                      fontFamily: "Shadows", fontSize:function()?19:15, color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }
}