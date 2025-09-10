import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {

  Future getUserLocation() async {
    //Permission check
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled)
      return null;
    //request permission
    var status = await Permission.location.request();
    if(status.isGranted)
      return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
    else if(status.isDenied)
      return null;
    else if(status.isPermanentlyDenied)
      {
        await openAppSettings();
        return null;
      }
    return null;
  }
}
