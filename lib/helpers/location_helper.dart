import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LocationHelper{

  
  static String generateLocationPreviewImage({double latitude,double longitude}){

    String API_KEY=FlutterConfig.get('Google_MAPS_API_KEY');
    return 
    'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$API_KEY';

  }


  
  static Future<String> getPlaceAddress(double lat, double log) async {
     String API_KEY=FlutterConfig.get('Google_MAPS_API_KEY');
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$log&key=$API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }


}