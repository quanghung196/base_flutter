import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String getDayOfWeek(bool isEnglish, {bool isContainYear = true}) {
    if (isEmpty) {
      return '';
    }

    String locale = isEnglish ? 'en_US' : 'ja_JP';

    DateTime date = DateFormat('yyyy/MM/dd').parse(this);
    var dayOfWeek =
        DateFormat(isContainYear ? 'yyyy/MM/dd(E)' : 'MM/dd(E)', locale)
            .format(date);
    return dayOfWeek;
  }

  double toSecond() {
    return double.parse(substring(0, 2)) * 3600 +
        double.parse(substring(3, 5)) * 60;
  }

  TimeOfDay toTimeOfDay() {
    final hour = int.parse(split(':')[0]);
    final minute = int.parse(split(':')[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  String preventBreakWord() {
    String breakWord = '';
    for (var element in runes) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    }
    return breakWord;
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension StringNullSafe on String? {
  bool get isEmptyOrNull => (this ?? '').isEmpty;
}
