import 'package:anywash_delivery/Locale/locales.dart';
import 'package:anywash_delivery/Themes/colors.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text(AppLocalizations.of(context)!.aboutUs!,
            style: Theme.of(context).textTheme.bodyText1),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(48.0),
                color: kCardBackgroundColor,
                child: Image(
                  image: AssetImage("images/logos/logo_delivery.png"),
                  height: 130.0,
                  width: 99.7,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.aboutDelivoo!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      AppLocalizations.of(context)!.aboutBody!,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      AppLocalizations.of(context)!.ourVision!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      AppLocalizations.of(context)!.aboutBody!,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
