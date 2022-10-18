import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:anywash_delivery/Locale/locales.dart';
import 'package:flutter/material.dart';

import '../account_page.dart';

class TncPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Account(),
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text(AppLocalizations.of(context)!.tnc!,
            style: Theme.of(context).textTheme.bodyText1),
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(48.0),
                  color: Theme.of(context).cardColor,
                  child: FadedScaleAnimation(
                    Image(
                      image: AssetImage("assets/Logo.png"), //delivoo logo
                      height: 130.0,
                      width: 99.7,
                    ),
                    durationInMilliseconds: 400,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 28.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.termsOfUse!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        '\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque pulvinar porta sagittis. Sed id varius magna. Etiam felis neque, gravida vitae elementum non, consequat eu odio. Mauris cursus commodo nisi sed imperdiet. Fusce vitae vehicula ipsum, ut commodo lorem. Praesent interdum blandit condimentum. Curabitur vel orci vitae odio congue facilisis eget eget diam.\n\nNam a arcu efficitur, ornare leo eu, euismod leo. Vestibulum porttitor varius leo, eget posuere felis congue vel. Sed sit amet erat quam. Mauris et ex sapien. Sed venenatis, felis sed eleifend vulputate, mauris libero pretium urna, non hendrerit urna quam vitae justo. Maecenas rhoncus lectus consectetur eros pretium feugiat.\n',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        AppLocalizations.of(context)!.companyPolicy!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        '\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque pulvinar porta sagittis. Sed id varius magna. Etiam felis neque, gravida vitae elementum non, consequat eu odio. Mauris cursus commodo nisi sed imperdiet. Fusce vitae vehicula ipsum, ut commodo lorem. Praesent interdum blandit condimentum. Curabitur vel orci vitae odio congue facilisis eget eget diam.\n\nNam a arcu efficitur, ornare leo eu, euismod leo. Vestibulum porttitor varius leo, eget posuere felis congue vel. Sed sit amet erat quam. Mauris et ex sapien. Sed venenatis, felis sed eleifend vulputate, mauris libero pretium urna, non hendrerit urna quam vitae justo. Maecenas rhoncus lectus consectetur eros pretium feugiat.\n',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                )
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
