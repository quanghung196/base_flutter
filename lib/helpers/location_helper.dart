import 'dart:developer' as developer;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../core/core.dart';
import 'helpers.dart';

class LocationHelper {
  LocationHelper._();

  static LocationHelper get instance => LocationHelper._();

  void getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Future.error('Location services are disabled.');
    }
    bool isPermissionGranted =
        await PermissionHelper.instance.isLocationPermissionGranted();
    if (isPermissionGranted) {
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).then((position) async {
        final placeMark = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
          localeIdentifier: LocaleHelper.instance.isEnglish()
              ? LocaleConstants.enUS
              : LocaleConstants.jaJP,
        );
      }).catchError((e) {
        developer.log(e.toString());
      });
    } else {
      Future.error('Location permissions are denied');
    }
  }
}
