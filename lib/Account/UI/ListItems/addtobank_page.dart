import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:anywash_delivery/Components/bottom_bar.dart';
import 'package:anywash_delivery/Components/entry_field.dart';
import 'package:anywash_delivery/Locale/locales.dart';
import 'package:anywash_delivery/Themes/colors.dart';
import 'package:anywash_delivery/Themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddToBank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.sendToBank!,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.w500)),
        titleSpacing: 0.0,
      ),
      body: FadedSlideAnimation(
        Add(),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          AppLocalizations.of(context)!
                              .availableBalance!
                              .toUpperCase(),
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                              letterSpacing: 0.67,
                              color: kHintColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        '\$ 520.50',
                        style: listTitleTextStyle.copyWith(
                            fontSize: 35.0,
                            color: kMainColor,
                            letterSpacing: 0.18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).cardColor,
              thickness: 8.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      AppLocalizations.of(context)!.bankInfo!.toUpperCase(),
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.67,
                          color: kHintColor),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: EntryField(
                      textCapitalization: TextCapitalization.words,
                      label: AppLocalizations.of(context)!
                          .accountHolderName!
                          .toUpperCase(),
                      isCollapsed: true,
                      initialValue: '\n' + 'Samantha Smith',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: EntryField(
                      textCapitalization: TextCapitalization.words,
                      label:
                          AppLocalizations.of(context)!.bankName!.toUpperCase(),
                      initialValue: '\n' + 'HBNC Bank of New York',
                      isCollapsed: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: EntryField(
                      textCapitalization: TextCapitalization.none,
                      label:
                          AppLocalizations.of(context)!.branchCode!.toUpperCase(),
                      initialValue: '\n' + '+1 987 654 3210',
                      isCollapsed: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: EntryField(
                      textCapitalization: TextCapitalization.none,
                      label: AppLocalizations.of(context)!
                          .accountNumber!
                          .toUpperCase(),
                      initialValue: '\n' + '4321 4567 6789 8901',
                      isCollapsed: true,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).cardColor,
              thickness: 8.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: EntryField(
                textCapitalization: TextCapitalization.words,
                label: AppLocalizations.of(context)!
                    .enterAmountToTransfer!
                    .toUpperCase(),
                initialValue: '\n' + '\$ 500',
                isCollapsed: true,
              ),
            ),
            SizedBox(height: 50,),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BottomBar(
            text: AppLocalizations.of(context)!.sendToBank,
            onTap: () => Navigator.pop(context),
          ),
        )
      ],
    );
  }
}
