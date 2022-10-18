import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:anywash_delivery/Components/bottom_bar.dart';
import 'package:anywash_delivery/Locale/locales.dart';
import 'package:anywash_delivery/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../language_cubit.dart';
import '../../../theme_cubit.dart';

class ThemeList {
  final String? title;
  final String? subtitle;

  ThemeList({this.title, this.subtitle});
}

class LanguageList {
  final String? title;

  LanguageList({this.title});
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late LanguageCubit _languageCubit;
  late ThemeCubit _themeCubit;
  String? selectedLocal;
  String? selectedTheme;

  @override
  void initState() {
    super.initState();

    _languageCubit = BlocProvider.of<LanguageCubit>(context);
    _themeCubit = BlocProvider.of<ThemeCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final List<LanguageList> language = <LanguageList>[
      LanguageList(
        title: locale.englishh,
      ),
      LanguageList(
        title: locale.arabicc,
      ),
      LanguageList(
        title: locale.frenchh,
      ),
      LanguageList(
        title: locale.indonesiann,
      ),
      LanguageList(
        title: locale.portuguesee,
      ),
      LanguageList(
        title: locale.spanishh,
      ),
      LanguageList(
        title: locale.turkishh,
      ),
      LanguageList(
        title: locale.italiann,
      ),
      LanguageList(
        title: locale.swahilii,
      ),
    ];
    final List<ThemeList> themes = <ThemeList>[
      ThemeList(
        title: AppLocalizations.of(context)!.darkMode,
        subtitle: AppLocalizations.of(context)!.darkText,
      ),
      ThemeList(
        title: AppLocalizations.of(context)!.lightMode,
        subtitle: AppLocalizations.of(context)!.lightText,
      ),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(AppLocalizations.of(context)!.settings!,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.w500)),
        titleSpacing: 0.0,
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            ListView(
              children: [
                Container(
                  height: 57.7,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  //color: kCardBackgroundColor,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.display!,
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: kTextColor,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.08),
                    ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: themes.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      value: themes[index].title,
                      title: Text(
                        themes[index].title!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      subtitle: Text(
                        themes[index].subtitle!,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      groupValue: selectedTheme,
                      onChanged: (dynamic value) {
                        setState(() {
                          selectedTheme = value;
                        });
                      },
                    );
                  },
                ),
                Container(
                  height: 58.0,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.selectLanguage!,
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: kTextColor,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.08),
                    ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: language.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      value: language[index].title,
                      groupValue: selectedLocal,
                      title: Text(
                        language[index].title!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onChanged: (dynamic value) {
                        setState(() {
                          selectedLocal = value;
                        });
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomBar(
                  text: AppLocalizations.of(context)!.continueText,
                  onTap: () {
                    if (selectedLocal == locale.englishh) {
                      _languageCubit.selectEngLanguage();
                    } else if (selectedLocal == locale.arabicc) {
                      _languageCubit.selectArabicLanguage();
                    } else if (selectedLocal == locale.portuguesee) {
                      _languageCubit.selectPortugueseLanguage();
                    } else if (selectedLocal == locale.frenchh) {
                      _languageCubit.selectFrenchLanguage();
                    } else if (selectedLocal == locale.spanishh) {
                      _languageCubit.selectSpanishLanguage();
                    } else if (selectedLocal == locale.indonesiann) {
                      _languageCubit.selectIndonesianLanguage();
                    } else if (selectedLocal == locale.swahilii) {
                      _languageCubit.selectSwahiliLanguage();
                    } else if (selectedLocal == locale.turkishh) {
                      _languageCubit.selectTurkishLanguage();
                    } else if (selectedLocal == locale.italiann) {
                      _languageCubit.selectItalianLanguage();
                    }

                    if (selectedTheme == locale.lightMode) {
                      _themeCubit.selectLightTheme();
                    } else if (selectedTheme == locale.darkMode) {
                      _themeCubit.selectDarkTheme();
                    }

                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
