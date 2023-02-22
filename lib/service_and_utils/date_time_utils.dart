
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateTime timeAndDateToDateTime(TimeOfDay timeOfDay, {DateTime? dateTime}) {
    dateTime = dateTime ?? DateTime.now();

    DateTime date = DateTime(dateTime.year, dateTime.month, dateTime.day,
        timeOfDay.hour, timeOfDay.minute, 0, 0, 0);
    return date;
  }

  static const defaultDateFormat = "dd-MM-yyyy";
  static const requiredDateFormat = "MM/dd/yyyy";
  static const ddMMyyyyhhmmaFormat = "dd/MM/yyyy hh:mm a";
  static const ddMMyyyyFormat = "dd/MM/yyyy hh:mm a";
  static const currentDateFormat = "yyyy-MM-dd";
  static const severFormatDateTime = "yyyy-MM-dd HH:mm:ss";
  static const displayDateTimeFeedback = "MMM dd, hh:mm a";

  static String convertToStringFormat(DateTime dateTime,
      {String format = defaultDateFormat}) {
      return  DateFormat(format).format(dateTime);
  }

  String convertTimeOfDayToString({required TimeOfDay timeOfDay}) {
    DateTime dateTime = DateTime.now();

    DateTime date = DateTime(dateTime.year, dateTime.month, dateTime.day,
        timeOfDay.hour, timeOfDay.minute, 0, 0, 0);
    String dateString = DateFormat('hh:mm a').format(date);
    return dateString;
  }


  bool compareTimeOfDays({required TimeOfDay time1, required TimeOfDay time2}) {
    double from = time1.hour + time1.minute / 60.0;
    double to = time2.hour + time2.minute / 60.0;
    return from < to;
  }

  String dateTimeDifChatScreen(String postedTime) {
    var dateTime = DateFormat(severFormatDateTime).parse(postedTime, true);
    // var parsedDate = dateTime.toLocal();
    final startTime = dateTime.toLocal();
    final currentTime = DateTime.now();
    int differ = currentTime.difference(startTime).inHours;
    String diff_dy = "";
    if (differ >= 24) {
      if (differ >= 24 && differ <= 48) {
        diff_dy = "yesterday";
      } else {
        diff_dy = DateTimeUtils.convertToDisplayFeedBackDateTime(postedTime);
      }
    } else if (differ >= 1) {
      diff_dy = "${differ}h ago";
    } else if (currentTime.difference(startTime).inMinutes >= 1 &&
        currentTime.difference(startTime).inMinutes < 60) {
      diff_dy = "${currentTime.difference(startTime).inMinutes}min ago";
    } else {
      diff_dy = "now";
    }
    return diff_dy;
  }

  static String convertToDisplayFeedBackDateTime(String? date,
      {String currentFormat = severFormatDateTime}) {
    if (date?.isNotEmpty == true) {
      var dateTime = DateFormat(severFormatDateTime).parse(date!, true);
      var inputDate = dateTime.toLocal();
      var formatter = DateFormat(displayDateTimeFeedback);
      return formatter.format(inputDate);
    } else {
      return "";
    }
  }
}
