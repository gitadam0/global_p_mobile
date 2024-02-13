
import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:global_p/places_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.580071,-7.635136),
    zoom: 7.4746,
  );


List<LatLng> polylineCoordinates=[];


  @override
  void initState() {
    //getpoints();
    super.initState();
    showlocal();

  }

  /*void getpoints() async{
    PolylinePoints polylinePoints=PolylinePoints();
    PolylineResult result=await polylinePoints.
    getRouteBetweenCoordinates(
        "AIzaSyAW7Uirfq-BEAI-RwG0phNquiBfOhzP9EM",
        PointLatLng(33.69560995625174, -7.387742669143332) ,
        PointLatLng(33.580071,-7.635136)
    );
    print("itsssssssssssssss gooood");
    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng element) => polylineCoordinates.add(LatLng(element.latitude, element.longitude))
      );
    }
    setState(() {

    });
  }*/

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
      markerId: MarkerId("markerId2"),
    infoWindow: InfoWindow(title: "random location"),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(33.680071,-7.435136),
  );

  static final Marker gare= Marker(
    markerId: MarkerId("gare"),
    infoWindow: InfoWindow(title: "gare de train"),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(33.69560995625174, -7.387742669143332),
  );

  var markers={marker1,marker2,gare};

  TextEditingController t1=TextEditingController();
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
      body: Column(
        children: [
          //
          //converting json didint work i think its outdated
          //
          /*Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: t1,
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: (){
                      Locationservice().getPlaceId(t1.text);
                    },
                      child: Icon(Icons.search)
                  ),
                  labelText: "Search by name"),
            ),
          ),*/
          Expanded(
            child: GoogleMap(
              markers: markers,
              /*polylines: {
                Polyline(
                  polylineId: PolylineId("route"),
                  points: polylineCoordinates,
              )
              },*/
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () async {

          showlocal();
        },
        child: Icon(Icons.my_location_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));

    //_determinePosition();
  }
  showlocal() async {
    Position a= await _determinePosition();

    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(a.latitude, a.longitude), zoom: 16)));

    markers.add(Marker(markerId: const MarkerId('currentLocation'),infoWindow: InfoWindow(title: "Your location"),position: LatLng(a.latitude, a.longitude),icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)));
    setState(() {

    });
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      
      return Future.error('Location services are disabled');

    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }


}