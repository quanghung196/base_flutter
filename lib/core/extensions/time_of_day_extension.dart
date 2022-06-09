import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String convertToString() {
    final hours = hour.toString().padLeft(2, '0');
    final minutes = minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}
