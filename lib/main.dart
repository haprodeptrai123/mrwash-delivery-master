import 'package:anywash_delivery/Routes/routes.dart';
import 'package:anywash_delivery/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth/login_navigator.dart';
import 'Locale/locales.dart';
import 'language_cubit.dart';
import 'map_utils.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  MapUtils.getMarkerPic();
  MobileAds.instance.initialize();
  String? locale = prefs.getString('locale');
  bool? isDark = prefs.getBool('theme');
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => LanguageCubit(locale)),
    BlocProvider(create: (context) => ThemeCubit(isDark ?? true)),
  ], child: Phoenix(child: AnyWashDelivery())));
}

class AnyWashDelivery extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return BlocBuilder<LanguageCubit, Locale>(builder: (context, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              const AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en'),
              const Locale('ar'),
              const Locale('pt'),
              const Locale('fr'),
              const Locale('id'),
              const Locale('es'),
              const Locale('it'),
              const Locale('tr'),
              const Locale('sw'),
            ],
            locale: locale,
            theme: theme,
            home: LoginNavigator(),
            routes: PageRoutes().routes(),
          );
        });
      },
    );
  }
}
