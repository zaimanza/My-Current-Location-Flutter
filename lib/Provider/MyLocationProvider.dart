import 'package:flutter/material.dart';
// @dart=2.9
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class MyLocationProvider with ChangeNotifier {
  String latLang = "";
  double latitude = 0.0;
  double longitude = 0.0;
  String myAddress = "";
  bool noLocation = false;

  determinePermissionBeforeGetLocation(context) async {
    LocationPermission permission;

    print("Testing Here");

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //TODO:
        noLocation = true;
        print("noLocation = true");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      //TODO:
      noLocation = true;
      print("noLocationForever = true");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enable location permission."),
          action: SnackBarAction(
            label: 'App Settings',
            onPressed: () async {
              await Geolocator.openAppSettings();
            },
          ),
        ),
      );
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      noLocation = false;
      await getCurrentLocation();
    }

    notifyListeners();
  }

  getCurrentLocation() async {
    try {
      print("getting Location Open");
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print("getting Location Close");

      print("Your Current LatLang");
      print(position.latitude);
      print(position.longitude);
      latLang =
          position.latitude.toString() + "," + position.longitude.toString();
      latitude = position.latitude;
      longitude = position.longitude;
      getAddressFromCoordinates(
          Coordinates(position.latitude, position.latitude));

      notifyListeners();
    } on Exception catch (e) {
      print("There is an Error");
      print(e);

      if (longitude == 0.0) {
        noLocation = true;
      }

      notifyListeners();
    }
  }

  getAddressFromCoordinates(Coordinates coordinates) async {
    final coordinates = new Coordinates(1.10, 45.50);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.addressLine}");
    myAddress = first.addressLine.toString();
    if (myAddress == "") {
      myAddress = "No Address Found";
    }
    notifyListeners();
  }
}
