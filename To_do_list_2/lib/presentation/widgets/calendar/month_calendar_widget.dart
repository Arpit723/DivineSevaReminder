import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../../presentation/providers/calendar_providers.dart';
import 'date_utils.dart' as app_date_utils;

/// A month calendar widget that displays tasks with indicators
/// Shows red dots on dates that have tasks
class MonthCalendarWidget extends ConsumerStatefulWidget {
  const MonthCalendarWidget({super.key});

  @override
  ConsumerState<MonthCalendarWidget> createState() => _MonthCalendarWidgetState();
}

class _MonthCalendarWidgetState extends ConsumerState<MonthCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(calendarSelectedDateProvider);
    final taskCountsAsync = ref.watch(taskCountByMonthProvider(selectedDate));

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: taskCountsAsync.when(
        loading: () => _buildLoadingCalendar(),
        error: (_, __) => _buildCalendar(selectedDate, {}),
        data: (taskCounts) => _buildCalendar(selectedDate, taskCounts),
      ),
    );
  }

  Widget _buildLoadingCalendar() {
    final now = DateTime.now();
    return _buildCalendar(now, {});
  }

  Widget _buildCalendar(DateTime selectedDate, Map<DateTime, int> taskCounts) {
    final now = DateTime.now();
    final focusedDay = selectedDate;

    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: focusedDay,
      currentDay: now,
      selectedDayPredicate: (day) => app_date_utils.DateUtils.isSameDay(day, selectedDate),

      // Handle day selection
      onDaySelected: (selectedDay, focusedDay) {
        ref.read(calendarSelectedDateProvider.notifier).selectDate(selectedDay);
      },

      // Handle page changes (month navigation)
      onPageChanged: (focusedDay) {
        // Don't update the selected date, just update the focused month
      },

      // Calendar format
      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },

      // Custom styling
      calendarStyle: CalendarStyle(
        // Today's appearance
        todayDecoration: BoxDecoration(
          color: const Color(0xFF8B0000).withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        todayTextStyle: const TextStyle(
          color: Color(0xFF8B0000),
          fontWeight: FontWeight.bold,
        ),

        // Selected day appearance
        selectedDecoration: BoxDecoration(
          color: const Color(0xFF8B0000),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8B0000).withValues(alpha: 0.3),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        selectedTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),

        // Default day appearance
        defaultDecoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        defaultTextStyle: TextStyle(
          color: Colors.grey[800],
          fontSize: 14,
        ),

        // Weekend appearance
        weekendDecoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        weekendTextStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),

        // Outside month days
        outsideDecoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle,
        ),
        outsideTextStyle: TextStyle(
          color: Colors.grey[400],
          fontSize: 14,
        ),

        // Padding
        cellPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        cellMargin: const EdgeInsets.all(4),
      ),

      // Header styling
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: Colors.grey[700],
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        weekendStyle: TextStyle(
          color: const Color(0xFF8B0000).withValues(alpha: 0.7),
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        dowTextFormatter: (date, locale) {
          return DateFormat.E(locale).format(date).substring(0, 1);
        },
      ),

      // Header month/year text
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8B0000),
        ),
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: Colors.grey[700],
          size: 28,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: Colors.grey[700],
          size: 28,
        ),
        headerPadding: const EdgeInsets.symmetric(vertical: 8),
      ),

      // Custom builders
      calendarBuilders: CalendarBuilders(
        // Add task count markers on days
        markerBuilder: (context, date, events) {
          final count = taskCounts[DateTime(date.year, date.month, date.day)] ?? 0;
          if (count == 0) return const SizedBox();

          return _buildTaskMarkers(count);
        },
      ),

      // Event loader for table_calendar (we use custom markerBuilder instead)
      eventLoader: (day) {
        final count = taskCounts[DateTime(day.year, day.month, day.day)] ?? 0;
        return List.generate(count.clamp(0, 10), (i) => i);
      },
    );
  }

  /// Build task indicator marker (single dot with matching theme color)
  Widget _buildTaskMarkers(int count) {
    // Use a soft maroon color that matches the app theme (0xFF8B0000)
    // but is more subtle for calendar markers
    return Positioned(
      bottom: 4,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: const Color(0xFFB71C1C), // Softer maroon that matches theme
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFB71C1C).withValues(alpha: 0.3),
                blurRadius: 2,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
