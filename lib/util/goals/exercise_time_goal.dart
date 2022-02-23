class ExerciseGoal {
  static double totalTimeInMinutes(Map activitySnapshot) {
    Duration sum = Duration.zero;
    activitySnapshot
        .forEach((key, value) => sum += _convertToDuration(value[2]));
    String HHmmss = sum.toString().split('.').first.padLeft(8, "0");
    List<String> HHmmssSplit = HHmmss.split(':');
    return double.parse(HHmmssSplit[0]) * 60 +
        double.parse(HHmmssSplit[1]) +
        double.parse(HHmmssSplit[2]) / 60;
  }

  static Duration _convertToDuration(String activityDurationStr) {
    Duration duration = Duration.zero;
    String value = activityDurationStr.split(' ')[0];
    String unitOfTime = activityDurationStr.split(' ')[1];
    switch (unitOfTime.toUpperCase()) {
      case 'SECONDS':
        duration = Duration(seconds: int.parse(value));
        break;
      case 'MINUTE':
      case 'MINUTES':
        duration = Duration(minutes: int.parse(value));
        break;
      case 'HOUR':
      case 'HOURS':
        duration = Duration(hours: int.parse(value));
        break;
    }
    return duration;
  }
}
