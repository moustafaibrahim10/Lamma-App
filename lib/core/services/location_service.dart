import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<Position?> getUserLocation() async {
    //check service is enabled
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) return null;
    //request Permission
    var status = await Permission.location.request();
    if (status.isGranted) {
      return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } else if (status.isDenied)
      return null;
    else if (status.isPermanentlyDenied)
      {
        await openAppSettings();
        return null;
      }
    return null;
  }
}
