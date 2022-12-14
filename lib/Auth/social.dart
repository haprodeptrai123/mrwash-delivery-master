import 'package:anywash_delivery/Components/bottom_bar.dart';
import 'package:anywash_delivery/Components/entry_field.dart';
import 'package:anywash_delivery/Locale/locales.dart';
import 'package:flutter/material.dart';

import 'login_navigator.dart';

class SocialLogIn extends StatefulWidget {
  @override
  _SocialLogInState createState() => _SocialLogInState();
}

class _SocialLogInState extends State<SocialLogIn> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            automaticallyImplyLeading: true,
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.hey!,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: EntryField(
                      controller: _controller,
                      label: AppLocalizations.of(context)!.mobileNumber,
                      image: 'images/icons/ic_phone.png',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 44.0),
                    child: Text(
                      AppLocalizations.of(context)!.verificationText!,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 12.8),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomBar(
                  text: AppLocalizations.of(context)!.continueText,
                  onTap: () {
                    Navigator.pushNamed(context, LoginRoutes.verification);
                  }),
            )
          ],
        ));
  }
}
