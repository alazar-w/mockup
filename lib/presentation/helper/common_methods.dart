import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class CommonMethods {
  CommonMethods._();
  static final Logger _logger = Logger();

  static Future<dynamic> pickDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime min = DateTime(1940);
    DateTime max = DateTime(now.year - 18, now.month, now.day);
    DateTime? dob = await showDatePicker(
      context: context,
      initialDate: max,
      firstDate: min,
      lastDate: max,
    );
    _logger.i("pickDate Response month", dob?.month);
    _logger.i("pickDate Response date", dob?.day);
    if (dob == null) {
      return "display";
    }
    return dob;
  }

  static String formatedDate(DateTime dateTime) {
    var today = dateTime;

    final DateFormat format = DateFormat('MMMM');

    int intDate = today.day;
    String date = intDate.toString();
    // String year = (today.year).toString();
    String month = format.format(today);
    if (intDate < 10) {
      date = "0$date";
    }

    return "$month $date "; // 13 November 2022
  }
}
