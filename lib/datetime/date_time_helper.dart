// convert date time object to String yymmdd

String convertDateTimeToString(DateTime dateTime) {
  // year in format yyyy
  String year = dateTime.year.toString();
  // Month in format mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }
  // Day in format dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  //final format -> yyyymmdd
  String yyyymmdd = year + month + day;
  return yyyymmdd;
}
// 20240112; Result of helper;

/*
  DateTime.now -> yyyymmddhhmiss;
*/