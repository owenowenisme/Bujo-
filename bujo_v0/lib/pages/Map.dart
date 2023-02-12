// ignore_for_file: file_names
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  distanceFilter: 2,
);

Marker marker = Marker(markerId: MarkerId('0001'), position: currentpos);
LatLng currentpos = const LatLng(0, 0);
Stream firestore =
    FirebaseFirestore.instance.collection('location').snapshots();

class Locationstate {
  static void getUserLocation(BuildContext context, AsyncSnapshot document) {
    GeoPoint geoPoint = GeoPoint(currentpos.latitude, currentpos.longitude);
    document.data.docs[0].reference.update({'loca': geoPoint});
    marker = Marker(
      markerId: marker.markerId,
      position: currentpos,
    );
  }
}

class _MapState extends State<Map> {
  static double zoomrate = 14.5;
  static double bearingrate = 0;
  static double tiltrate = 0;
  static bool focusOn = true;
  String mapStyle = '';
  LocationPermission locationPermission = LocationPermission.denied;
  Icon fab = const Icon(Icons.my_location);
  static bool darkModeIsOn = false;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    DefaultAssetBundle.of(context)
        .loadString('assets/lightmaptheme.json')
        .then((string) {
      mapStyle = string;
    });
    super.initState();
  }

  Future<void> getPermission() async {
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }
  }

  void getLocation() {
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      setState(() {
        if (focusOn) {
          double tmp = position?.heading.toDouble() ?? 0;
          if ((tmp - bearingrate).abs() > 5) {
            bearingrate = tmp;
          }
          setCamera();
        }
        currentpos = LatLng(position!.latitude, position.longitude);
      });
    });
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

  void changeMapStyle() async {
    await _controller.future.then((value) {
      if (darkModeIsOn == false) {
        DefaultAssetBundle.of(context)
            .loadString('assets/darkmaptheme.json')
            .then((string) {
          value.setMapStyle(string);
        });
      } else {
        DefaultAssetBundle.of(context)
            .loadString('assets/lightmaptheme.json')
            .then((string) {
          value.setMapStyle(string);
        });
      }
      darkModeIsOn = !darkModeIsOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
              body: GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                compassEnabled: true,
                zoomControlsEnabled: false,
                onCameraMove: (position) {
                  zoomrate = position.zoom.toDouble();
                  bearingrate = position.bearing.toDouble();
                  tiltrate = position.tilt.toDouble();
                },
                onMapCreated: (GoogleMapController controller) async {
                  if (locationPermission == LocationPermission.denied) {
                    await getPermission();
                  }
                  getLocation();
                  controller.setMapStyle(mapStyle);
                  _controller.complete(controller);
                },
                initialCameraPosition: CameraPosition(
                    target: currentpos,
                    zoom: zoomrate,
                    bearing: bearingrate,
                    tilt: tiltrate),
                markers: {marker},
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Switch.adaptive(
                        value: darkModeIsOn,
                        onChanged: (value) {
                          setState(() {
                            changeMapStyle();
                          });
                        },
                      ),
                      Transform.scale(
                        scale: 1.5,
                        child: FloatingActionButton(
                          heroTag: "mainbtn",
                          child: fab,
                          onPressed: () {
                            focusOn = !focusOn;
                            setState(() {
                              if (!focusOn) {
                                fab = const Icon(Icons.public);
                              } else {
                                setCamera();
                                fab = const Icon(Icons.my_location);
                              }
                            });
                          },
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: "right",
                        onPressed: () {},
                        child: const Icon(Icons.menu),
                      ),
                    ],
                  )));
        }
        Locationstate.getUserLocation(context, snapshot);
        return Scaffold(
            body: GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              compassEnabled: true,
              zoomControlsEnabled: false,
              onCameraMove: (position) {
                zoomrate = position.zoom.toDouble();
                bearingrate = position.bearing.toDouble();
                tiltrate = position.tilt.toDouble();
              },
              onMapCreated: (GoogleMapController controller) async {
                if (locationPermission == LocationPermission.denied) {
                  await getPermission();
                }
                getLocation();
                controller.setMapStyle(mapStyle);
                _controller.complete(controller);
              },
              initialCameraPosition: CameraPosition(
                  target: currentpos,
                  zoom: zoomrate,
                  bearing: bearingrate,
                  tilt: tiltrate),
              markers: {marker},
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Switch.adaptive(
                      value: darkModeIsOn,
                      onChanged: (value) {
                        setState(() {
                          changeMapStyle();
                        });
                      },
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: FloatingActionButton(
                        heroTag: "mainbtn",
                        child: fab,
                        onPressed: () {
                          focusOn = !focusOn;
                          setState(() {
                            if (!focusOn) {
                              fab = const Icon(Icons.public);
                            } else {
                              setCamera();
                              fab = const Icon(Icons.my_location);
                            }
                          });
                        },
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: "right",
                      onPressed: () {},
                      child: const Icon(Icons.menu),
                    ),
                  ],
                )));
      },
    );
  }
}
