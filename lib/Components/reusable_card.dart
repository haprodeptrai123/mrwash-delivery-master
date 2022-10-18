import 'package:anywash_delivery/Themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Widget? cardChild;
  final Function? onPress;

  ReusableCard({this.cardChild, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress as void Function()?,
      child: Container(
        child: cardChild,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: kCardBackgroundColor,
        ),
      ),
    );
  }
}
