import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtility {
  String parse({String? dateTime, String? returnFormat, String? parseFormat}) {
    if (dateTime == null) {
      return "";
    } else if (parseFormat != null) {
      DateTime formattedTime = DateFormat(
        parseFormat,
      ).parse(dateTime);
      DateFormat dateFormat = DateFormat(returnFormat);
      String returnDT = dateFormat.format(formattedTime);
      return returnDT;
    } else {
      DateTime dt = DateTime.parse(dateTime);
      DateFormat dateFormat = DateFormat(returnFormat);
      String returnDT = dateFormat.format(dt);
      return returnDT;
    }
  }

  String parseTime({String? dateTime, String? returnFormat}) {
    DateFormat dtFor = DateFormat("HH:mm:ss");
    DateTime dt = dtFor.parse(dateTime!);
    DateFormat dateFormat = DateFormat(returnFormat);
    String returnDT = dateFormat.format(dt);
    return returnDT;
  }

  DateTime convertDateFromString(String strDate, {String? parseFormat}) {
    if (parseFormat != null) {
      DateFormat dateFormat = DateFormat(parseFormat);
      DateTime todayDate = dateFormat.parse(strDate);
      return todayDate;
    } else {
      DateTime todayDate = DateTime.parse(strDate);
      return todayDate;
    }
  }

  String convertStringFromDatetime(
      {DateTime? date, String returnFormat = "yyyy-MM-dd"}) {
    DateFormat dateFormat = DateFormat(returnFormat);
    String returnDT = dateFormat.format(date!);
    return returnDT;
  }

  String getTimeFromTimeStamp(timeInMillis) {
    //int timeInMillis = 1586348737122;
    debugPrint(timeInMillis);
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    String formattedDate = DateTimeUtility()
        .parse(dateTime: date.toString(), returnFormat: "hh:mm a");
    return formattedDate;
  }

  String getDateFromTimeStamp(timeInMillis) {
    //int timeInMillis = 1586348737122;
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    String formattedDate = DateFormat.yMMMd().format(date);
    return formattedDate;
  }

  String parseToLocal({String? dateTime, String? returnFormat, String? parseFormat}) {
    final dateNow = DateTime.now();
    if (dateTime == null) {
      return "";
    } else if (parseFormat != null) {
      DateTime formattedTime = DateFormat(
        parseFormat,
      ).parse(dateTime);
      formattedTime = formattedTime.add(dateNow.timeZoneOffset);
      debugPrint("formattedTime:$formattedTime");
      DateFormat dateFormat = DateFormat(returnFormat);
      String returnDT = dateFormat.format(formattedTime);
      return returnDT;
    } else {
      DateTime dt = DateTime.parse(dateTime);
      dt = dt.add(dateNow.timeZoneOffset);
      DateFormat dateFormat = DateFormat(returnFormat);
      String returnDT = dateFormat.format(dt);
      return returnDT;
    }
  }
}
