import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:anywash_delivery/Components/bottom_bar.dart';
import 'package:anywash_delivery/Locale/locales.dart';
import 'package:anywash_delivery/Routes/routes.dart';
import 'package:anywash_delivery/Themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeliverySuccessful extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadedSlideAnimation(
        Column(
          children: <Widget>[
            Spacer(),
            FadedScaleAnimation(
              Image.asset(
                'assets/img_signindelivery.png',
              ),
              durationInMilliseconds: 400,
            ),
            Spacer(),
            Text(
              AppLocalizations.of(context)!.delivered!,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).secondaryHeaderColor,
                  letterSpacing: 0.1),
            ),
            Text(
              '\n' + AppLocalizations.of(context)!.thankYou!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 31.0, right: 31.0),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.youDrived!,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Color(0xff818181)),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '18 min (6.5 km)',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        AppLocalizations.of(context)!.viewOrderInfo!,
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: kMainColor,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.08),
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.yourEarnings!,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Color(0xff818181)),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '\$ 4.50',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        AppLocalizations.of(context)!.viewEarnings!,
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: kMainColor,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.08),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            BottomBar(
              text: AppLocalizations.of(context)!.backToHome,
              onTap: () =>
                  Navigator.popAndPushNamed(context, PageRoutes.accountPage),
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
