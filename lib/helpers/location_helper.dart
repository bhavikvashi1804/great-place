import 'package:flutter_config/flutter_config.dart';


class LocationHelper{

  
  static String generateLocationPreviewImage({double latitude,double longitude}){

    String API_KEY=FlutterConfig.get('Google_MAPS_API_KEY');

    return 
    'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$API_KEY';
 


  }
}