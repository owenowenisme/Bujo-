import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({super.key});
  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  //final Completer<GoogleMapController> _completer = Completer();

  static const LatLng from = LatLng(24.083465, 120.546334);
  LocationData? currentlocation;

  // void getCurrentLocation() async {
  //   Location location = Location();
  //   PermissionStatus _permissionGranted;
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   location.getLocation().then((location) {
  //     currentlocation = location;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
      ),
      body: GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          compassEnabled: true,
          // onMapCreated: (GoogleMapController controller) {
          //   getCurrentLocation();
          // },
          initialCameraPosition: CameraPosition(target: from, zoom: 14.5)),
    );
  }
}
