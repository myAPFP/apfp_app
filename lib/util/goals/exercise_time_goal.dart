class ExerciseGoal {
  static double totalTimeInMinutes(Map map) {
    Duration sum = Duration.zero;
    map.forEach((key, value) => sum += _convertToDuration(value[2]));
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
      case 'MINUTES':
        duration = Duration(minutes: int.parse(value));
        break;
      case 'SECONDS':
        duration = Duration(seconds: int.parse(value));
        break;
      case 'HOURS':
        duration = Duration(hours: int.parse(value));
        break;
    }
    return duration;
  }
}
