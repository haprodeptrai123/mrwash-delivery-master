import 'package:anywash_delivery/Auth/social.dart';
import 'package:anywash_delivery/Routes/routes.dart';
import 'package:flutter/material.dart';

import 'MobileNumber/UI/phone_number.dart';
import 'Registration/UI/register_page.dart';
import 'Verification/UI/verification_page.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class LoginRoutes {
  static const String loginRoot = 'login/';
  static const String social = 'login/social';
  static const String registration = 'login/registration';
  static const String verification = 'login/verification';
}

class LoginData {
  final String phoneNumber;
  final String name;
  final String email;

  LoginData(this.phoneNumber, this.name, this.email);
}

class LoginNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var canPop = navigatorKey.currentState!.canPop();
        if (canPop) {
          navigatorKey.currentState!.pop();
        }
        return !canPop;
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: LoginRoutes.loginRoot,
        onGenerateRoute: (RouteSettings settings) {
          late WidgetBuilder builder;
          switch (settings.name) {
            case LoginRoutes.loginRoot:
              builder = (BuildContext _) => PhoneNumber();
              break;
            case LoginRoutes.social:
              builder = (BuildContext _) => SocialLogIn();
              break;
            case LoginRoutes.registration:
              builder = (BuildContext _) => RegisterPage();
              break;
            case LoginRoutes.verification:
              builder = (BuildContext _) => VerificationPage(
                    () {
                      Navigator.popAndPushNamed(
                          context, PageRoutes.accountPage);
                    },
                  );
              break;
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
        onPopPage: (Route<dynamic> route, dynamic result) {
          return route.didPop(result);
        },
      ),
    );
  }
}
