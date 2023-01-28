// ignore_for_file: file_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Map extends StatefulWidget {
  const Map({super.key});
  @override
  State<Map> createState() => _MapState();
}

LocationSettings locationSettings = const LocationSettings(
  accuracy: LocationAccuracy.best,
  distanceFilter: 0,
);

class _MapState extends State<Map> {
  static late LatLng currentpos;
  static double zoomrate = 14.5;
  static double bearingrate = 0;
  static double tiltrate = 0;
  static late LatLng screentarget;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const LatLng from = LatLng(24.083465, 120.546334);
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() {
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      setState(() {
        currentpos = LatLng(position!.latitude, position.longitude);
        setCamera();
      });
    });
  }


  void setRate() async {
    zoomrate = 14.5;
    bearingrate = 0;
    tiltrate = 0;
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: screentarget,
      zoom: zoomrate,
      bearing: bearingrate,
      tilt: tiltrate,
    )));
  }

  void setCamera() async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: currentpos,
      zoom: zoomrate,
      bearing: bearingrate,
      tilt: tiltrate,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            compassEnabled: true,
            onCameraMove: (position) {
              screentarget= position.target;
              zoomrate = position.zoom.toDouble();
              bearingrate = position.bearing.toDouble();
              tiltrate = position.tilt.toDouble();
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: CameraPosition(
                target: from,
                zoom: zoomrate,
                bearing: bearingrate,
                tilt: tiltrate)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "left",
              onPressed: () {},
              child: const Icon(Icons.menu),
            ),
            Transform.scale(
              scale: 1.5,
              child: FloatingActionButton(
                heroTag: "mainbtn",
                onPressed: () {
                  setRate();
                },
                child: const Icon(Icons.person_pin_circle_sharp),
              ),
            ),
            FloatingActionButton(
              heroTag: "right",
              onPressed: () {},
              child: const Icon(Icons.menu),
            ),
          ],
        ));
  }
}
