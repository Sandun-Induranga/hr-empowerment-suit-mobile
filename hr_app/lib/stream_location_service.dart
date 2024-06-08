import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class StreamLocationService {
  static const LocationSettings _locationSettings =
  LocationSettings(distanceFilter: 1);
  static bool _isLocationGranted = false;

  static  Stream<Position>? get onLocationChanged  {
    // askLocationPermission();
    // if (_isLocationGranted) {
      print('Location permission granted');
      print('Location settings: $_locationSettings');
      return Geolocator.getPositionStream(locationSettings: _locationSettings);
    // }
    // print('Location permission not granted');
    // return null;
  }

  static Future<bool> askLocationPermission() async {
    _isLocationGranted = await Permission.location.request().isGranted;
    return _isLocationGranted;
  }
}
