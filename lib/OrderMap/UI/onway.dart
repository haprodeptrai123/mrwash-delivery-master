import 'dart:async';

import 'package:anywash_delivery/Components/bottom_bar.dart';
import 'package:anywash_delivery/Locale/locales.dart';
import 'package:anywash_delivery/OrderMap/UI/slide_up_panel.dart';
import 'package:anywash_delivery/OrderMapBloc/order_map_bloc.dart';
import 'package:anywash_delivery/OrderMapBloc/order_map_state.dart';
import 'package:anywash_delivery/Routes/routes.dart';
import 'package:anywash_delivery/Themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../map_utils.dart';

class OnWayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderMapBloc>(
      create: (context) => OrderMapBloc()..loadMap(),
      child: OnWayBody(),
    );
  }
}

class OnWayBody extends StatefulWidget {
  @override
  _OnWayBodyState createState() => _OnWayBodyState();
}

class _OnWayBodyState extends State<OnWayBody> {

  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? mapStyleController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    rootBundle.loadString('assets/map_style.txt').then((string) {
      mapStyle = string;
    });
    super.initState();
  }

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    List<String?> itemName = [
      AppLocalizations.of(context)!.shirts,
      AppLocalizations.of(context)!.tShirts,
      AppLocalizations.of(context)!.jeans,
    ];
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: AppBar(
              title: Text(AppLocalizations.of(context)!.newDeliveryTask!,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.w500)),
              actions: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).cardColor,
                    ),
                    icon: Icon(
                      isOpen ? Icons.close : Icons.shopping_basket,
                      color: kMainColor,
                      size: 13.0,
                    ),
                    label: Text(
                        isOpen
                            ? AppLocalizations.of(context)!.close!
                            : AppLocalizations.of(context)!.orderInfo!,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 11.7,
                              fontWeight: FontWeight.bold,
                            )),
                    onPressed: () {
                      setState(() {
                        if (isOpen)
                          isOpen = false;
                        else
                          isOpen = true;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: BlocBuilder<OrderMapBloc, OrderMapState>(
                      builder: (context, state) {
                        print('polyyyy' + state.polylines.toString());
                        return GoogleMap(
                          polylines: state.polylines,
                          mapType: MapType.normal,
                          initialCameraPosition: kGooglePlex,
                          markers: _markers,
                          onMapCreated: (GoogleMapController controller) async {
                            _mapController.complete(controller);
                            mapStyleController = controller;
                            mapStyleController!.setMapStyle(mapStyle);
                            setState(() {
                              _markers.add(
                                Marker(
                                  markerId: MarkerId('mark1'),
                                  position:
                                  LatLng(37.42796133580664, -122.085749655962),
                                  icon: markerss.first,
                                ),
                              );
                              _markers.add(
                                Marker(
                                  markerId: MarkerId('mark2'),
                                  position:
                                  LatLng(37.42496133180663, -122.081743655960),
                                  icon: markerss[1],
                                ),
                              );
                              _markers.add(
                                Marker(
                                  markerId: MarkerId('mark3'),
                                  position:
                                  LatLng(37.42196183580660, -122.089743655967),
                                  icon: markerss[2],
                                ),
                              );
                            });
                          },
                        );
                      }),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 2, right: 16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  AppLocalizations.of(context)!.distance!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          letterSpacing: 0.07,
                                          fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: <Widget>[
                                    Text(
                                      '16.5 km ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              fontSize: 10,
                                              letterSpacing: 0.06,
                                              color: kMainColor,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '(20 min)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              fontSize: 10,
                                              letterSpacing: 0.06,
                                              color: Color(0xffc1c1c1)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context).cardColor,
                              ),
                              onPressed: () {/*...*/},
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.navigation,
                                    color: kMainColor,
                                    size: 14.0,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.direction!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            color: kMainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11.7,
                                            letterSpacing: 0.06),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: kCardBackgroundColor,
                        thickness: 1.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 28.0,
                                  bottom: 6.0,
                                  top: 6.0,
                                  right: 10.0),
                              child: Icon(
                                Icons.location_on,
                                size: 14.0,
                                color: kMainColor,
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Quickwashers',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        letterSpacing: 0.05,
                                        fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                '1024, Union Market, USA',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        fontSize: 11.0, letterSpacing: 0.05),
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.message,
                                      color: kMainColor,
                                      size: 20.0,
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, PageRoutes.chatPage);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.phone,
                                      color: kMainColor,
                                      size: 20.0,
                                    ),
                                    onPressed: () {
                                      /*..........*/
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 28.0,
                                  bottom: 6.0,
                                  top: 6.0,
                                  right: 10.0),
                              child: Icon(
                                Icons.location_on,
                                size: 14.0,
                                color: kMainColor,
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Samantha Smith',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        letterSpacing: 0.05,
                                        fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                '1024, Union Market, USA',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        fontSize: 11.0, letterSpacing: 0.05),
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.message,
                                      color: kMainColor,
                                      size: 20.0,
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, PageRoutes.customerChatPage);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.phone,
                                      color: kMainColor,
                                      size: 20.0,
                                    ),
                                    onPressed: () {
                                      /*..........*/
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      BottomBar(
                          text: AppLocalizations.of(context)!.markPicked,
                          onTap: () => Navigator.popAndPushNamed(
                              context, PageRoutes.deliverySuccessful)),
                    ],
                  ),
                )
              ],
            ),
            isOpen ? OrderInfoContainer(itemName) : SizedBox.shrink(),
          ],
        ));
  }
}
