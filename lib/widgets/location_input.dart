import 'package:flutter/material.dart';

import 'package:location/location.dart';


import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;


  Future<void> _getUserCurrentLocation()async{
    
    final locData=await Location().getLocation();
    //print(locData.latitude);
    //print(locData.longitude);
    final staticMapImageUrl=LocationHelper.generateLocationPreviewImage(latitude: locData.latitude,longitude: locData.longitude);

    setState(() {
      _previewImageUrl=staticMapImageUrl;
    });
  }

  Future<void> _selectOnMap()async{
     final selectedLocaion =await Navigator.of(context).push(
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
