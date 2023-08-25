
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.580071,-7.635136),
    zoom: 7.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      //bearing: 192.8334901395799,
      bearing: 0.8334901395799,
      target: LatLng(33.609033132861605, -7.632687686556796),
      tilt: 60.440717697143555,
      //zoom: 17.151926040649414
      zoom: 17.1
      //zoom: 0.151926040649414
  );

  static final Marker marker1= Marker(
      markerId: MarkerId("markerId"),
    infoWindow: InfoWindow(title: "Globale Performance"),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(33.580071,-7.635136),
  );
  static final Marker marker2= Marker(
      markerId: MarkerId("markerId"),
    infoWindow: InfoWindow(title: "random location"),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(33.680071,-7.435136),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        centerTitle: true,
        title: Image.asset("images/gp.png",height: 40,),
        
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: GoogleMap(
        markers: {marker1,marker2},
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(

        onPressed: _goToTheLake,
        label: const Text('To the mosque'),
        icon: const Icon(Icons.mosque),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}