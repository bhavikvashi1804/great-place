import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen(
    {this.initialLocation=const PlaceLocation(latitude: 28.644800, longitude: 77.216721),
    this.isSelecting=false}
  );

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  LatLng _pickedLocation;

  void  selectLocation(LatLng location){
    setState(() {
      _pickedLocation=location;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          if(widget.isSelecting)IconButton(
            icon: Icon(Icons.check), 
            onPressed: _pickedLocation==null?null:(){
              Navigator.of(context).pop(_pickedLocation);
            }
          ),
      
         
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude, 
            widget.initialLocation.longitude
          ),
          zoom: 16,
          
        ),

        onTap: widget.isSelecting?selectLocation:null,

        markers: _pickedLocation==null?null:{
          Marker(
            markerId: MarkerId('m1'), 
            position: _pickedLocation,
          ),
        },
        
      ),
      
    );
  }
}