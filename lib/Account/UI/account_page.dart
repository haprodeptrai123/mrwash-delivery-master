import 'dart:async';
import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:anywash_delivery/Components/list_tile.dart';
import 'package:anywash_delivery/Locale/locales.dart';
import 'package:anywash_delivery/OrderMapBloc/order_map_bloc.dart';
import 'package:anywash_delivery/OrderMapBloc/order_map_state.dart';
import 'package:anywash_delivery/Routes/routes.dart';
import 'package:anywash_delivery/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../map_utils.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String? number;
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  BannerAd? _anchoredBanner;
  bool _loadingAnchoredBanner = false;

  Future<void> _createAnchoredBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    final BannerAd banner = BannerAd(
      size: size,
      request: request,
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            _anchoredBanner = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _anchoredBanner?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      if (!_loadingAnchoredBanner) {
        _loadingAnchoredBanner = true;
        _createAnchoredBanner(context);
      }
      return FadedSlideAnimation(
        Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                child: UserDetails(),
                height: 160.0,
              ),
              Divider(
                color: Theme.of(context).cardColor,
                thickness: 8.0,
              ),
              BuildListTile(
                  image: 'assets/Account/ic_menu_home.png',
                  text: AppLocalizations.of(context)!.homeText,
                  onTap: () => Navigator.popAndPushNamed(
                      context, PageRoutes.accountPage)),
              BuildListTile(
                  image: 'assets/Account/ic_insightact.png',
                  text: AppLocalizations.of(context)!.insight,
                  onTap: () => Navigator.popAndPushNamed(
                      context, PageRoutes.insightPage)),
              BuildListTile(
                image: 'assets/Account/ic_wallet.png',
                text: AppLocalizations.of(context)!.wallet,
                onTap: () =>
                    Navigator.popAndPushNamed(context, PageRoutes.walletPage),
              ),
              BuildListTile(
                  image: 'assets/Account/ic_menu_tnc.png',
                  text: AppLocalizations.of(context)!.tnc,
                  onTap: () =>
                      Navigator.popAndPushNamed(context, PageRoutes.tncPage)),
              BuildListTile(
                  image: 'assets/Account/ic_menu_support.png',
                  text: AppLocalizations.of(context)!.support,
                  onTap: () => Navigator.popAndPushNamed(
                      context, PageRoutes.supportPage,
                      arguments: number)),
              BuildListTile(
                image: 'assets/Account/ic_setting.png',
                text: AppLocalizations.of(context)!.settings,
                onTap: () =>
                    Navigator.popAndPushNamed(context, PageRoutes.setting),
              ),
              LogoutTile(),
              if (_anchoredBanner != null)
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: _anchoredBanner!.size.width.toDouble(),
                    height: _anchoredBanner!.size.height.toDouble(),
                    child: AdWidget(ad: _anchoredBanner!),
                  ),
                ),
            ],
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      );
    });
  }
}

class DrawerItem {
  String title;
  String image;

  DrawerItem(this.title, this.image);
}

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderMapBloc>(
      create: (context) => OrderMapBloc()..loadMap(),
      child: AccountBody(),
    );
  }
}

class AccountBody extends StatefulWidget {
  @override
  _AccountBodyState createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> {
  bool isoffline = false;
  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? mapStyleController;

  @override
  void initState() {
    rootBundle.loadString('assets/map_style.txt').then((string) {
      mapStyle = string;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: AppBar(
            title: Text(
                isoffline
                    ? AppLocalizations.of(context)!.offlineText!
                    : AppLocalizations.of(context)!.onlineText!,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.w500)),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: isoffline
                    ? FadedScaleAnimation(
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xffff3939))),
                          ),
                          onPressed: () {
                            setState(() {
                              isoffline = false;
                            });
                          },
                          child: Text(
                            AppLocalizations.of(context)!.goOnline!,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.7,
                                    letterSpacing: 0.06),
                          ),
                        ),
                        durationInMilliseconds: 400,
                      )
                    : FadedScaleAnimation(
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xffff3939))),
                            backgroundColor: Color(0xffff3939),
                          ),
                          onPressed: () {
                            setState(() {
                              isoffline = true;
                            });

                            // Navigator.popAndPushNamed(context, PageRoutes.offlinePage);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.goOffline!,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.7,
                                    letterSpacing: 0.06),
                          ),
                        ),
                        durationInMilliseconds: 400,
                      ),
              ),
            ],
          ),
        ),
      ),
      drawer: Account(),
      body: isoffline
          ? Stack(
              children: <Widget>[
                // Container(
                //     decoration: BoxDecoration(
                //         image: DecorationImage(
                //             image: AssetImage("assets/Maps/map_1.jpg"),
                //             fit: BoxFit.cover))),
                BlocBuilder<OrderMapBloc, OrderMapState>(
                    builder: (context, state) {
                  print('polyyyy' + state.polylines.toString());
                  return Expanded(
                    child: GoogleMap(
                      // polylines: state.polylines,
                      mapType: MapType.normal,
                      initialCameraPosition: kGooglePlex,
                      markers: state.markers,
                      onMapCreated: (GoogleMapController controller) async {
                        _mapController.complete(controller);
                        mapStyleController = controller;
                        mapStyleController!.setMapStyle(mapStyle);
                      },
                    ),
                  );
                }),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    margin: EdgeInsets.all(20.0),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              '64',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              AppLocalizations.of(context)!.orders!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff6a6c74)),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              '68 km',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              AppLocalizations.of(context)!.ride!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff6a6c74)),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              '\$302.50',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              AppLocalizations.of(context)!.earnings!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff6a6c74)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : BlocBuilder<OrderMapBloc, OrderMapState>(builder: (context, state) {
              print('polyyyy' + state.polylines.toString());
              return GoogleMap(
                // polylines: state.polylines,
                mapType: MapType.normal,
                initialCameraPosition: kGooglePlex,
                markers: state.markers,
                onMapCreated: (GoogleMapController controller) async {
                  _mapController.complete(controller);
                  mapStyleController = controller;
                  mapStyleController!.setMapStyle(mapStyle);
                },
              );
            }),
      floatingActionButton: isoffline
          ? null
          : FloatingActionButton(
              backgroundColor: kMainColor,
              child: Icon(Icons.list),
              onPressed: () =>
                  Navigator.pushNamed(context, PageRoutes.newDeliveryPage),
            ),
    );
  }
}

class LogoutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BuildListTile(
      image: 'assets/Account/ic_menu_logout.png',
      text: AppLocalizations.of(context)!.logout,
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context)!.loggingOut!),
                content: Text(AppLocalizations.of(context)!.areYouSure!),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      AppLocalizations.of(context)!.no!,
                      style: TextStyle(
                        color: kMainColor,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: kTransparentColor)),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                      child: Text(
                        AppLocalizations.of(context)!.yes!,
                        style: TextStyle(
                          color: kMainColor,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: kTransparentColor)),
                      ),
                      onPressed: () {
                        Phoenix.rebirth(context);
                      })
                ],
              );
            });
      },
    );
  }
}

class UserDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 16),
          child: GestureDetector(
            child: Icon(Icons.close),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                CircleAvatar(
                  radius: 32.0,
                  backgroundImage: AssetImage('assets/img_profile.png'),
                ),
                SizedBox(
                  width: 20.0,
                ),
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, PageRoutes.editProfile),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('\n' + 'George Anderson',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 5,
                      ),
                      Text('+1 987 654 3210',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Color(0xff9a9a9a), fontSize: 14)),
                      Text('deliveryman@mail.com',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Color(0xff9a9a9a), fontSize: 14)),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
