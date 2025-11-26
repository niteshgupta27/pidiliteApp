import 'package:intl/intl.dart';

class DateConverterHelper {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static String slotDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").parse(dateTime, true);
  }

  // static String localDateToIsoStringAMPM(DateTime dateTime, BuildContext context) {
  //   return DateFormat('${_timeFormatter(context)} | d-MMM-yyyy ').format(dateTime.toLocal());
  // }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('HH:mm').format(isoStringToLocalDate(dateTime));
  }
  static String isoStringToLocalTimeWithAMPMOnly(String dateTime) {
    return DateFormat('hh:mm a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalTimeWithAmPmAndDay(String dateTime) {
    return DateFormat('hh:mm a, EEE').format(isoStringToLocalDate(dateTime));
  }

  // static String stringToStringTime(String dateTime, BuildContext context) {
  //   DateTime inputDate = DateFormat('HH:mm:ss').parse(dateTime);
  //   return DateFormat(_timeFormatter(context)).format(inputDate);
  // }


  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM, yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime.toUtc());
  }
  static String isoDayWithDateString(String dateTime) {
    return DateFormat('EEE, MMM d, yyyy').format(isoStringToLocalDate(dateTime));
  }

  // static String convertTimeRange(String start, String end, BuildContext context) {
  //   DateTime startTime = DateFormat('HH:mm:ss').parse(start);
  //   DateTime endTime = DateFormat('HH:mm:ss').parse(end);
  //   return '${DateFormat(_timeFormatter(context)).format(startTime)} - ${DateFormat(_timeFormatter(context)).format(endTime)}';
  // }

  static DateTime stringTimeToDateTime(String time) {
    return DateFormat('HH:mm:ss').parse(time);
  }
  static String dateMounthformatDate(String dateString) {
    // Parse the date string into a DateTime object
    DateTime date = DateTime.parse(dateString);

    // Format the date with day and abbreviated month name
    return DateFormat('d MMM').format(date);
  }
  static String formatMilliseconds(int milliseconds) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(dateTime);
  }

  // static String _timeFormatter(BuildContext context) {
  //   return Provider.of<SplashProvider>(context, listen: false).configModel!.timeFormat == '24' ? 'HH:mm' : 'hh:mm a';
  // }

  // static String getDateToDateDifference(DateTime dateTime, BuildContext context){
  //   String differenceValue = estimatedDate(dateTime);
  //   int day = DateTime.now().difference(dateTime).inDays;
  //   int month = (day/30).round();
  //   if(day == 0) {
  //     differenceValue = getTranslated('today', context);
  //   }else if(day == -1) {
  //     differenceValue = getTranslated('yesterday', context);
  //
  //   }else if(day < -30) {
  //     differenceValue = '$day ${getTranslated('days', context)} ${getTranslated('ago', context)}';
  //
  //   } else if(month < 12) {
  //     differenceValue = '$month ${getTranslated(month > 1 ?  'months' : 'month', context)} ${getTranslated('ago', context)}';
  //
  //   }
  //
  //   return differenceValue;
  // }

}
