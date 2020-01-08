import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  bool mapToggle = false;
  var currentLoction;
  List<Marker> marker=[];
  GoogleMapController mapController;
  BitmapDescriptor myIcon;

  void initState() {
    super.initState();
    
    Geolocator().getCurrentPosition().then((currloc){
      setState(() {
        currentLoction=currloc;
        mapToggle=true;
      });
      marker.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: false,
        onTap: (){
        },
        position: LatLng(currentLoction.latitude, currentLoction.longitude), 
        ));
       
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Instagram',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Billabong',
            fontSize: 35.0,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                 height: MediaQuery.of(context).size.height - 130.0,
                    width: double.infinity,
                    child: mapToggle ?
                    GoogleMap(
                      onMapCreated: onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(currentLoction.latitude, currentLoction.longitude),
                        zoom: 18.0
                      ),
                      markers: Set.from(marker),
                    ):
                    Center(child: 
                    Text('En cours ...\nAttendez-vous s\'il vous plait',style: TextStyle(fontSize: 20.0)),
                    )
              )
            ],
          )
        ],
      ),
    );
  }

void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}