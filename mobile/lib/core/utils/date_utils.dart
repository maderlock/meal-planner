/// Extension methods for DateTime to handle week-related calculations
extension WeekDateTime on DateTime {
  /// Returns the start of the week (Monday at 00:00:00) for the current date
  DateTime get startOfWeek {
    // Get the day difference to Monday (weekday 1)
    final daysToSubtract = weekday - 1;
    // Subtract days and set time to midnight
    return DateTime(year, month, day - daysToSubtract);
  }

  /// Returns true if this date is in the same week as [other]
  bool isSameWeek(DateTime other) {
    final thisStart = startOfWeek;
    final otherStart = other.startOfWeek;
    return thisStart.year == otherStart.year &&
        thisStart.month == otherStart.month &&
        thisStart.day == otherStart.day;
  }

  /// Returns true if this date is a valid week start date (Monday at 00:00:00)
  bool isValidWeekStart() {
    // Must be a Monday (weekday == 1)
    if (weekday != 1) return false;
    
    // Must be at midnight (00:00:00.000)
    return hour == 0 && 
           minute == 0 && 
           second == 0 && 
           millisecond == 0 &&
           microsecond == 0;
  }

  /// Formats the date as an ISO string with time set to midnight
  String toMidnightIsoString() {
    return DateTime(year, month, day).toIso8601String();
  }
}
