import 'package:timeago/timeago.dart' as timeago;

class GetFormattedDate {
  static String getFormattedDate(String date) {
    final DateTime dateTime = DateTime.parse(date);
    final formattedDate = timeago.format(dateTime);
    return formattedDate;
  }
}
