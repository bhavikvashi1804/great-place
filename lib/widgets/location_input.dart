import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;


  void _showPreview(double lat,double lon){
    final staticMapImageUrl=LocationHelper.generateLocationPreviewImage(latitude: lat,longitude: lon);
    setState(() {
      _previewImageUrl=staticMapImageUrl;
    });
  }

  Future<void> _getUserCurrentLocation()async{
    
    
    try{
      final locData=await Location().getLocation();
      //print(locData.latitude);
      //print(locData.longitude);
      _showPreview(locData.latitude, locData.longitude);
      widget.onSelectPlace(locData.latitude,locData.longitude);

    }
    catch(error){
      print(error);
    }
   

    
  }

  Future<void> _selectOnMap()async{
     final selectedLocaion =await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx)=>MapScreen(
          isSelecting: true,

        ),
      ),
    );

    if(selectedLocaion==null){
      return;
    }
    //else use that location and store it
    //print(selectedLocaion.latitude);
    //print(selectedLocaion.longitude);
    _showPreview(selectedLocaion.latitude,selectedLocaion.longitude);
    widget.onSelectPlace(selectedLocaion.latitude,selectedLocaion.longitude);

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.location_on,
              ),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getUserCurrentLocation,
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.map,
              ),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
