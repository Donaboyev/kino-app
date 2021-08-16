import 'package:intl/intl.dart';

class BaseFunctions {
  static getReleaseDate(String release) {
    if (release.isEmpty) return 'No data';
    DateTime parseDate = DateTime.parse(release);
    var newFormat = DateFormat('dd MMM yyyy');
    return newFormat.format(parseDate);
  }

  static String getRuntime(int min) {
    if (min > 59) return '${min ~/ 60}h ${min - (min ~/ 60) * 60}min';
    return '$min min';
  }

  static String getBudget(int budget) {
    if (budget < 1000) return '$budget \$';
    if (budget > 999 && budget < 1000000) return '${budget ~/ 1000}K \$';
    if (budget > 999999 && budget < 1000000000)
      return '${budget ~/ 1000000}M \$';
    return '${budget ~/ 1000000000}B \$';
  }
}
