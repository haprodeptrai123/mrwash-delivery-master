import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:anywash_delivery/Locale/locales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mobile_input.dart';

//first page that takes phone number as input for verification
class PhoneNumber extends StatefulWidget {
  static const String id = 'phone_number';

  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.cardColor,
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Spacer(
                  flex: 2,
                ),
                Image.asset(
                  "assets/Logo.png",
                  scale: 3, //delivoo logo
                ),
                Spacer(),
                Text(
                  locale.laundrySolution!,
                  style: theme.textTheme.headline4!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  locale.atDoorstep!,
                  style: theme.textTheme.bodyText1!.copyWith(
                    fontSize: 17,
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                Image.asset(
                  "assets/img_signindelivery.png",
                  fit: BoxFit.fitWidth,
                  scale: 3, //footer image
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: MobileInput(),
                ),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
