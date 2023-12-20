import 'package:intl/intl.dart';

class LocalizationHelper {
  static String formatTgl(DateTime date) {
    final formatDate = DateFormat('dd MMMM yyyy', "id_ID");
    final formatedDate = formatDate.format(date);
    return formatedDate;
  }

  static DateTime reversedFormatTgl(String stringDate) {
    final formatDate = DateFormat('dd MMMM yyyy', "id_ID");
    final date = formatDate.parse(stringDate);
    return date;
  }

  static dada() {
    final date = DateTime.now().add(Duration(days: 1));

    print(date.weekday);
  }
}
