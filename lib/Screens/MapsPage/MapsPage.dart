import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key key}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _controller = Completer();
  var UserLocationData;
  var UsersLocationsMarkers = <Marker>[
    Marker(
      markerId: MarkerId('marker 1'),
      position: LatLng(41.0598296, 28.83218339999999),
      infoWindow: InfoWindow(
        title: "Mahmoud The Developer",
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Sample App'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        mapType: MapType.normal,
        markers: UsersLocationsMarkers.toSet(),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(41.0598296, 28.83218339999999),
          zoom: 12.0,
        ),
      ),
    );
  }
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _GetUserLocation() async {
    Location location = new Location();
    var UserLocation = await location.getLocation();
    setState(() {
      //local variable
      UserLocationData =  LatLng(UserLocation.latitude, UserLocation.longitude);
    });
    //print("${LocationData.toString()}");
  }

  @override
  void initState() {
    //_GetFriendsPositions();
    _GetUserLocation();
    super.initState();
  }



  /*void _GetFriendsPositions() async {
    var id = 1;
    await FirebaseFirestore.instance.collection('users')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        print("location ${id}: ${element['location'].latitude}, ${element['location'].longitude}");
        setState(() {
          UsersLocationsMarkers.add(
              Marker(
                markerId: MarkerId('marker ${id}'),
                position: LatLng(element['location'].latitude,
                    element['location'].longitude),
                infoWindow: InfoWindow(
                  title: "${element['fullname']}",
                ),
              )
          );
        });
        id++;
      });
    });
    print("user locs ${UsersLocationsMarkers}");
    *//*await FirebaseFirestore.instance.collection('users')
          .snapshots()
          .listen((snapshot) {
            snapshot.docs.forEach((element) {
              var ElementMarker = Marker(
                markerId: MarkerId('marker ${i}'),
                position: LatLng(element['location'].latitude,element['location'].longitude),
                infoWindow: InfoWindow(
                  title: "${element['fullname']}",
                ),
              );
              print("location: ${element['location'].latitude}, ${element['location'].longitude}");
              setState(() {
                UsersLocationsMarkers.add(ElementMarker);
                print("user locs ${UsersLocationsMarkers}");
              });
              i++;
            });
          });*//*
  }*/
}
