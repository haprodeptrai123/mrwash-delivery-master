import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:anywash_delivery/Locale/locales.dart';
import 'package:anywash_delivery/Routes/routes.dart';
import 'package:anywash_delivery/Themes/colors.dart';
import 'package:anywash_delivery/Themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.wallet!,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.w500)),
        titleSpacing: 0.0,
      ),
      body: FadedSlideAnimation(
        Wallet(),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}

class WalletItems {
  final String title;
  final String subtitle;
  final String money;
  final String numberOfItems;

  WalletItems(this.title, this.subtitle, this.money, this.numberOfItems);
}

class Wallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<WalletItems> _walletItems = [
      WalletItems('Quickwashers', '3 items | 30 June 2018, 11.59 am', '21.00',
          '3 ' + locale.items!),
      WalletItems('Laundry 24x7', '3 items | 30 June 2018, 11.59 am', '15.50',
          '2 ' + locale.items!),
      WalletItems('Sent to Bank', '30 June 2018, 11.59 am', '     -\$100.00',
          '  ' + 'Sent to Bank'),
      WalletItems('Joseph Wash Point', '3 items | 30 June 2018, 11.59 am',
          '10.50', '1 item'),
      WalletItems('Quickwashers', '3 items | 30 June 2018, 11.59 am', '24.00',
          '3 ' + locale.items!),
      WalletItems('Laundry Point', '3 items | 30 June 2018, 11.59 am', '13.00',
          '3 ' + locale.items!),
      WalletItems('Joseph Wash Point', '3 items | 30 June 2018, 11.59 am',
          '28.50', '3 ' + locale.items!),
    ];
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context)!.availableBalance!.toUpperCase(),
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      letterSpacing: 0.67,
                      color: kHintColor,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  '\$ 758.50',
                  style: listTitleTextStyle.copyWith(
                      fontSize: 35.0, color: kMainColor, letterSpacing: 0.18),
                ),
              ),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 40.0,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                color: Theme.of(context).cardColor,
                child: Text(
                  AppLocalizations.of(context)!.recent!,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: kTextColor,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.08),
                ),
              ),
              Positioned.directional(
                textDirection: Directionality.of(context),
                bottom: 20.0,
                end: 20.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PageRoutes.addToBank);
                  },
                  child: Container(
                    height: 46.0,
                    width: 134.0,
                    color: kMainColor,
                    child: Center(
                      child: Text(
                        locale.sendToBank!,
                        style: bottomBarTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: kWhiteColor,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _walletItems.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10.0),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(_walletItems[index].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              SizedBox(height: 10.0),
                              Text(_walletItems[index].subtitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          color: kTextColor, fontSize: 11.7)),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              index == 2
                                  ? SizedBox.shrink()
                                  : Text(
                                      '\$80.00',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                              SizedBox(height: 10.0),
                              index == 2
                                  ? SizedBox.shrink()
                                  : Text(AppLocalizations.of(context)!.online!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              color: kTextColor,
                                              fontSize: 11.7)),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                _walletItems[index].money,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10.0),
                              Text(AppLocalizations.of(context)!.earnings!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          color: kTextColor, fontSize: 11.7)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).cardColor,
                      thickness: 3.0,
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
