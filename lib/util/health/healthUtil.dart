import 'package:health/health.dart';

class HealthUtil {
  /// Calulates health data sums.
  ///
  /// On Android, a given [HealthDataType]'s returned data is divided
  /// into multiple entries.
  ///
  /// For example, if a user has burned 250 calories, 3 entries
  /// will appear, and the sum of the 3 entries will equal 250.
  ///
  /// As a result, we must loop through the entries, add all values,
  /// and return the sum.
  static double getHealthSums(Set dataSet) {
    double sum = 0;
    dataSet.forEach((element) {
      var valueRE = RegExp(r"HealthDataPoint - value: (.*?),");
      // Extracts the 'HealthDataPoint - value' field
      var valueStr = valueRE.stringMatch(element.toString())!;
      // Removes trailing comma
      valueStr = valueStr.substring(0, valueStr.length - 1);
      // Removes 'HealthDataPoint - value: ' fieldname, leaving only the value
      valueStr = valueStr.replaceAll(RegExp(r'HealthDataPoint - value: '), "");
      sum += double.parse(double.parse(valueStr).toStringAsFixed(2));
    });
    return sum;
  }
}