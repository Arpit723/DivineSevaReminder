import 'package:intl/intl.dart';

/// Helper utility class for date operations related to the calendar view
class DateUtils {
  DateUtils._(); // Private constructor to prevent instantiation

  /// Check if two dates are the same day (ignoring time)
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Check if a date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return isSameDay(date, now);
  }

  /// Check if a date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return isSameDay(date, tomorrow);
  }

  /// Check if a date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(date, yesterday);
  }

  /// Get the start of the month (first day at midnight)
  static DateTime getStartOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Get the end of the month (last day at 23:59:59)
  static DateTime getEndOfMonth(DateTime date) {
    final nextMonth = DateTime(date.year, date.month + 1, 1);
    return nextMonth.subtract(const Duration(milliseconds: 1));
  }

  /// Format a date for display in headers
  /// Returns "Today", "Tomorrow", "Yesterday", or formatted date like "Feb 15"
  static String formatDateHeader(DateTime date) {
    if (isToday(date)) {
      return 'Today';
    } else if (isTomorrow(date)) {
      return 'Tomorrow';
    } else if (isYesterday(date)) {
      return 'Yesterday';
    } else {
      // Format as "MMM d" (e.g., "Feb 15")
      return DateFormat('MMM d').format(date);
    }
  }

  /// Format a date with the year
  /// Returns "Feb 15, 2026"
  static String formatDateWithYear(DateTime date) {
    return DateFormat('MMM d, y').format(date);
  }

  /// Format a date as "Monday, February 15"
  static String formatFullDate(DateTime date) {
    return DateFormat('EEEE, MMMM d').format(date);
  }

  /// Format a time as "2:30 PM"
  static String formatTime(DateTime time) {
    return DateFormat('jm').format(time);
  }

  /// Format a date and time as "Feb 15 at 2:30 PM"
  static String formatDateTime(DateTime dateTime) {
    return '${DateFormat('MMM d').format(dateTime)} at ${DateFormat('jm').format(dateTime)}';
  }

  /// Get the number of days in a month
  static int getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  /// Normalize a date to midnight (remove time component)
  static DateTime normalize(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Add days to a date
  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  /// Subtract days from a date
  static DateTime subtractDays(DateTime date, int days) {
    return date.subtract(Duration(days: days));
  }

  /// Get the week number of the year
  static int getWeekNumber(DateTime date) {
    final dayOfYear = int.parse(DateFormat('D').format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  /// Check if a date is in the past (before today)
  static bool isInThePast(DateTime date) {
    final today = normalize(DateTime.now());
    final normalizedDate = normalize(date);
    return normalizedDate.isBefore(today);
  }

  /// Check if a date is in the future (after today)
  static bool isInTheFuture(DateTime date) {
    final today = normalize(DateTime.now());
    final normalizedDate = normalize(date);
    return normalizedDate.isAfter(today);
  }
}
