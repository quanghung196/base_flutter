import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../app/presentation/widgets/widgets.dart';
import '../core/core.dart';
import '../main.dart';
import 'helpers.dart';

class PermissionHelper {
  PermissionHelper._();

  static PermissionHelper get instance => PermissionHelper._();

  Future<bool> isCameraPermissionGranted() async {
    var status = await Permission.camera.status;
    bool hasAskedBefore =
        await SharePrefHelper.instance.getCameraPermission ?? false;
    if (status.isDenied && hasAskedBefore) {
      AppPopup.showAlertDialog(
          context: navigatorKey.currentContext!,
          title: UIText.titleRequireCamera.tr(),
          message: Platform.isAndroid
              ? UIText.contentRequireCameraAndroid.tr()
              : UIText.contentRequireCameraIOS.tr(),
          positiveButton: UIText.goToSetting.tr(),
          isPositiveRed: false,
          onPositiveButtonClicked: () => AppSettings.openAppSettings());
      return false;
    } else if (status.isDenied) {
      await SharePrefHelper.instance.setCameraPermission(true);
      return false;
    } else {
      return true;
    }
  }

  Future<bool> isPhotoPermissionGranted() async {
    var status = await Permission.photos.status;
    bool hasAskedBefore =
        await SharePrefHelper.instance.getCameraPermission ?? false;
    if (status.isDenied && hasAskedBefore) {
      AppPopup.showAlertDialog(
          context: navigatorKey.currentContext!,
          title: UIText.titleRequirePhoto.tr(),
          message: UIText.contentRequirePhoto.tr(),
          positiveButton: UIText.goToSetting.tr(),
          isPositiveRed: false,
          onPositiveButtonClicked: () => AppSettings.openAppSettings());
      return false;
    } else if (status.isDenied) {
      await SharePrefHelper.instance.setPhotoPermission(true);
      return false;
    } else {
      return true;
    }
  }

  Future<bool> isStoragePermissionGranted() async {
    var status = await Permission.storage.status;
    bool hasAskedBefore =
        await SharePrefHelper.instance.getStoragePermission ?? false;
    if (status.isDenied && hasAskedBefore) {
      AppPopup.showAlertDialog(
          context: navigatorKey.currentContext!,
          title: UIText.titleRequireStorage.tr(),
          message: UIText.contentRequireStorage.tr(),
          positiveButton: UIText.goToSetting.tr(),
          isPositiveRed: false,
          onPositiveButtonClicked: () => AppSettings.openAppSettings());
      return false;
    } else if (status.isDenied) {
      await SharePrefHelper.instance.setStoragePermission(true);
      return false;
    } else {
      return true;
    }
  }

  Future<bool> isLocationPermissionGranted() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
}
