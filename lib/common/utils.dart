import 'package:intl/intl.dart';

class Utils {
  static String formatDateTimeString(String dateTime,
      {String newPattern = 'HH:mm dd/MM/yyyy'}) {
    DateTime parsedDateTime = DateTime.parse(dateTime);
    final formatter = DateFormat(newPattern);

    return formatter.format(parsedDateTime);
  }
}
