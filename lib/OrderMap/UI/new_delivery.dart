import 'dart:async';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:anywash_delivery/Components/bottom_bar.dart';
import 'package:anywash_delivery/Locale/locales.dart';
import 'package:anywash_delivery/OrderMapBloc/order_map_bloc.dart';
import 'package:anywash_delivery/OrderMapBloc/order_map_state.dart';
import 'package:anywash_delivery/Routes/routes.dart';
import 'package:anywash_delivery/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../map_utils.dart';

class NewDeliveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderMapBloc>(
      create: (context) => OrderMapBloc()..loadMap(),
      child: NewDeliveryBody(),
    );
  }
}

class NewDeliveryBody extends StatefulWidget {
  @override
  _NewDeliveryBodyState createState() => _NewDeliveryBodyState();
}

class _NewDeliveryBodyState extends State<NewDeliveryBody> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Account(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Text(AppLocalizations.of(context)!.newDeliveryTask!,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.w500)),
          ),
        ),
      ),
      body: FadedSlideAnimation(
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
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.distance!,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          letterSpacing: 0.07, fontWeight: FontWeight.w500),
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
                Divider(
                  color: Theme.of(context).cardColor,
                  thickness: 1.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                            left: 28.0, bottom: 6.0, top: 6.0, right: 10.0),
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
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              letterSpacing: 0.05, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          '1024, Hemiltone Street, Union Market, USA',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 11.0, letterSpacing: 0.05),
                        ),
                      ],
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
                            left: 28.0, bottom: 12.0, top: 12.0, right: 10.0),
                        child: Icon(
                          Icons.navigation,
                          size: 14.0,
                          color: kMainColor,
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Samantha Smith',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              letterSpacing: 0.05, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          '1024, Hemiltone Street, Union Market, USA',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 11.0, letterSpacing: 0.05),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                BottomBar(
                  text: AppLocalizations.of(context)!.accept,
                  onTap: () => Navigator.popAndPushNamed(
                      context, PageRoutes.acceptedPage),
                ),
              ],
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
