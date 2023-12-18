import 'package:intl/intl.dart';

class LocalizationHelper {
  static String formatTgl(DateTime date) {
    final formatDate = DateFormat('dd MMMM yyyy', "id_ID");
    final formatedDate = formatDate.format(date);
    return formatedDate;
  }
}
