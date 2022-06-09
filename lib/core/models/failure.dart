import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final int? code;
  final String? singleMessageCode;
  final Map<String, dynamic>? multiMessageCode;
  String? message;

  Map<String, List<Map<String, String>>?>? messageMap;

  Failure({
    this.code,
    this.singleMessageCode,
    this.multiMessageCode,
  }) {
    convertToMap();
  }

  @override
  List<Object?> get props => [
        code,
        message,
        multiMessageCode,
        singleMessageCode,
      ];

  void convertToMap() {
    if (code == null && multiMessageCode == null && singleMessageCode == null) {
      return;
    }
    if (code == 1000) {
      message = 'Dio Error';
      return;
    }
    if (code == 1500) {
      message = 'Connection timeout';
      return;
    }
    if (code == 2000) {
      message = 'No internet connection';
    }
    if ((singleMessageCode ?? '').isNotEmpty) {
      message = 'err.$singleMessageCode'.tr();
      return;
    }
    if (multiMessageCode != null) {
      multiMessageCode?.forEach((key, value) {
        final newValue = value.map((e) {
          if ((message ?? '').isEmpty) {
            message = 'err.$e'.tr();
          }
          return {e: 'err.$e'.tr()};
        }).toList();
        messageMap?[key] = newValue;
      });
    }
  }
}
