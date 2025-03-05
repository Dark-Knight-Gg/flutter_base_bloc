import 'package:intl/intl.dart';

import '../logger/app_logger.dart';

class DateTimeUtils {
  static DateTime? fromString(
    String date, {
    String? format,
  }) {
    if (format != null) {
      try {
        return DateFormat(format).parse(date);
      } catch (e) {
        AppLogger.log(e.toString());
      }
    }
    //
    try {
      return DateTime.parse(date);
    } catch (e) {
      AppLogger.log(e.toString());
    }
    //
    return null;
  }

  static String formatLocal(
    DateTime? dateTime, {
    required String format,
  }) {
    try {
      if (dateTime == null) return '';
      return DateFormat(format).format(dateTime.toLocal());
    } catch (e) {
      return '';
    }
  }

  static String formatUtc(
    DateTime? dateTime, {
    required String format,
  }) {
    try {
      if (dateTime == null) return '';
      return DateFormat(format).format(dateTime.toUtc());
    } catch (e) {
      return '';
    }
  }

  static DateTime firstDayOfMonth() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  static DateTime lastDayOfMonth() {
    final now = DateTime.now();
    final date = DateTime(now.year, now.month + 1, 0).day;
    return DateTime(now.year, now.month, date);
  }
}
