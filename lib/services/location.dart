import 'package:geolocator/geolocator.dart';



class Location {

  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    longitude = position.longitude;
    latitude = position.latitude;
  }

}