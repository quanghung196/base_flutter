import 'package:shared_preferences/shared_preferences.dart';

import '../core/core.dart';

class SharePrefHelper {
  SharePrefHelper._();

  static SharePrefHelper get instance => SharePrefHelper._();

  Future<bool> _setValue(dynamic value, {required String key}) async {
    if (value == null) {
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      return prefs.setString(key, value);
    } else if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is bool) {
      return prefs.setBool(key, value);
    } else if (value is double) {
      return prefs.setDouble(key, value);
    } else if (value is List<String>) {
      return prefs.setStringList(key, value);
    }
    return false;
  }

  Future _getValue({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  Future reloadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
  }

  Future setLocale(String? locale) =>
      _setValue(locale, key: PrefConstants.locale);

  Future<String?> get getLocale async =>
      await _getValue(key: PrefConstants.locale) as String?;

  Future setCameraPermission(bool hasAskedBefore) => _setValue(hasAskedBefore,
      key: PrefConstants.hasAskCameraPermissionBefore);

  Future<bool?> get getCameraPermission async =>
      await _getValue(key: PrefConstants.hasAskCameraPermissionBefore) as bool?;

  Future setPhotoPermission(bool hasAskedBefore) => _setValue(hasAskedBefore,
      key: PrefConstants.hasAskImageLibPermissionBefore);

  Future<bool?> get getPhotoPermission async =>
      await _getValue(key: PrefConstants.hasAskImageLibPermissionBefore)
          as bool?;

  Future setStoragePermission(bool hasAskedBefore) => _setValue(hasAskedBefore,
      key: PrefConstants.hasAskAccessStoragePermissionBefore);

  Future<bool?> get getStoragePermission async =>
      await _getValue(key: PrefConstants.hasAskAccessStoragePermissionBefore)
          as bool?;

  Future<String?> get getUserInfo async =>
      await _getValue(key: PrefConstants.userInfo) as String?;
}
