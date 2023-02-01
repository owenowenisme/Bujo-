// import 'dart:async';
// import 'package:bujo_v0/pages/map.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// int mapValue = 0;
// String mapStyle = '';

// String toggleMapStyle(Completer _controller) {
//   mapStyle = rootBundle.loadString('assets / darkmaptheme.json');
//   _controller.future.then((value) {
//     if (mapValue == 0) {
//       BuildContext.of(context)
//           .loadString('assets/darkmaptheme.json')
//           .then((string) {
//         mapStyle = string;
//         mapValue = 1;
//       });
//     } else {
//       DefaultAssetBundle.loadString('assets/lightmaptheme.json').then((string) {
//         mapStyle = string;
//         mapValue = 0;
//       });
//     }
//     value.setMapStyle(mapStyle);
//   });
//   return mapStyle;
// }
