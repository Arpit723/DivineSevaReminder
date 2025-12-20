import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../models/task.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Initialize timezone data
    tz.initializeTimeZones();

    // Android notification settings
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS notification settings - Don't request permissions yet
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      requestCriticalPermission: false,
    );

    // Combined initialization settings
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // Initialize the plugin
    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );

    // Don't request permissions automatically - let user do it via the permission screen
    // await _requestPermissions();

    // Create notification channels for Android
    await _createNotificationChannels();
  }

  // Public method to request permissions - called when user taps "Allow" button
  static Future<void> requestPermissions() async {
    // Request permission on iOS
    await _notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    // Request permission on Android 13+
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> _createNotificationChannels() async {
    // Create Android notification channels
    const AndroidNotificationChannel dueDateChannel = AndroidNotificationChannel(
      'task_due_channel',
      'Task Due Notifications',
      description: 'Notifications for when tasks are due',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    const AndroidNotificationChannel reminderChannel = AndroidNotificationChannel(
      'task_reminder_channel',
      'Task Reminder Notifications',
      description: 'Reminders 1 hour before tasks are due',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    const AndroidNotificationChannel dailyReminderChannel = AndroidNotificationChannel(
      'daily_reminder_channel',
      'Daily Morning Reminders',
      description: 'Daily 9 AM reminders for tasks due today',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    final androidPlugin = _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(dueDateChannel);
      await androidPlugin.createNotificationChannel(reminderChannel);
      await androidPlugin.createNotificationChannel(dailyReminderChannel);
    }
  }

  static void _onNotificationResponse(NotificationResponse response) {
    // Handle notification tap
    // TODO: Navigate to specific task when notification is tapped
    print('Notification tapped: ${response.payload}');
  }

  // Schedule notification for exact due time
  static Future<void> scheduleDueDateNotification(Task task) async {
    if (task.dueDate == null) return;

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'task_due_channel',
      'Task Due Notifications',
      channelDescription: 'Notifications for when tasks are due',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Convert to timezone-aware DateTime
    final scheduledDate = tz.TZDateTime.from(task.dueDate!, tz.local);

    // Only schedule if the due date is in the future
    if (scheduledDate.isAfter(tz.TZDateTime.now(tz.local))) {
      final notificationId = _generateNotificationId(task.id, false);
      print('Scheduling due date notification for task ${task.title} at ${scheduledDate.toString()} with ID: $notificationId');
      
      await _notifications.zonedSchedule(
        notificationId,
        'Task Due Now! ⏰',
        '${task.title} is due now',
        scheduledDate,
        notificationDetails,
        payload: 'due_${task.id}',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
    } else {
      print('Due date ${scheduledDate.toString()} is in the past, not scheduling notification for ${task.title}');
    }
  }

  // Schedule notification 1 hour before due time
  static Future<void> scheduleOneHourBeforeNotification(Task task) async {
    if (task.dueDate == null) return;

    // Calculate 1 hour before due date
    final oneHourBefore = task.dueDate!.subtract(const Duration(hours: 1));

    // Only schedule if 1 hour before is in the future
    if (oneHourBefore.isAfter(DateTime.now())) {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'task_reminder_channel',
        'Task Reminder Notifications',
        channelDescription: 'Reminders 1 hour before tasks are due',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
      );

      const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      // Convert to timezone-aware DateTime
      final scheduledDate = tz.TZDateTime.from(oneHourBefore, tz.local);
      final notificationId = _generateNotificationId(task.id, true);
      print('Scheduling reminder notification for task ${task.title} at ${scheduledDate.toString()} with ID: $notificationId');

      await _notifications.zonedSchedule(
        notificationId,
        'Task Reminder! 📝',
        '${task.title} is due in 1 hour',
        scheduledDate,
        notificationDetails,
        payload: 'reminder_${task.id}',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
    } else {
      print('Reminder time ${oneHourBefore.toString()} is in the past, not scheduling reminder for ${task.title}');
    }
  }

  // Schedule both notifications for a task
  static Future<void> scheduleTaskNotifications(Task task) async {
    if (task.dueDate == null) return;

    // Cancel existing notifications for this task first
    await cancelTaskNotifications(task);

    // Schedule new notifications
    await scheduleDueDateNotification(task);
    await scheduleOneHourBeforeNotification(task);
  }

  // Generate unique notification ID from task ID
  static int _generateNotificationId(String taskId, bool isReminder) {
    // Use hash code of task ID to generate a consistent integer
    int hash = taskId.hashCode.abs();
    // Ensure it's within int32 range and add offset for reminder
    hash = hash % 2000000000; // Keep within reasonable range
    return isReminder ? hash + 1 : hash; // Different ID for reminder
  }

  // Cancel notifications for a specific task
  static Future<void> cancelTaskNotifications(Task task) async {
    // Cancel due date notification
    final dueDateId = _generateNotificationId(task.id, false);
    final reminderId = _generateNotificationId(task.id, true);
    
    print('Cancelling notifications for task ${task.title}: due date ID $dueDateId, reminder ID $reminderId');
    
    await _notifications.cancel(dueDateId);
    await _notifications.cancel(reminderId);
  }

  // Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  // Schedule daily 9 AM reminder for tasks due today or overdue
  static Future<void> scheduleDailyMorningReminder(List<Task> allTasks) async {
    // Cancel existing daily reminder first
    await _notifications.cancel(999999); // Using a fixed ID for daily reminder

    // Calculate next 9 AM
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      9, // 9 AM
      0, // 0 minutes
    );

    // If it's already past 9 AM today, schedule for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    // Filter tasks that are due today or overdue (and not completed)
    final dueTasks = allTasks.where((task) {
      if (task.dueDate == null || task.status == TaskStatus.completed) {
        return false;
      }

      final dueDate = task.dueDate!;
      final today = DateTime.now();

      // Check if task is due today or overdue
      return dueDate.year <= today.year &&
          dueDate.month <= today.month &&
          dueDate.day <= today.day;
    }).toList();

    // Only schedule if there are tasks due
    if (dueTasks.isEmpty) {
      print('No tasks due today or overdue, skipping daily reminder');
      return;
    }

    // Create notification message
    String body;
    if (dueTasks.length == 1) {
      body = 'You have 1 task due: ${dueTasks.first.title}';
    } else {
      body = 'You have ${dueTasks.length} tasks due today';
    }

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'daily_reminder_channel',
      'Daily Morning Reminders',
      channelDescription: 'Daily 9 AM reminders for tasks due today',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      enableLights: true,
      enableVibration: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    print('Scheduling daily morning reminder for ${scheduledDate.toString()}');

    await _notifications.zonedSchedule(
      999999, // Fixed ID for daily reminder
      'Good Morning! 🌅',
      body,
      scheduledDate,
      notificationDetails,
      payload: 'daily_reminder',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // Repeat daily at 9 AM
    );
  }

  // Cancel daily morning reminder
  static Future<void> cancelDailyMorningReminder() async {
    await _notifications.cancel(999999);
  }

  // Get pending notifications (for debugging)
  static Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    final pending = await _notifications.pendingNotificationRequests();
    print('Pending notifications count: ${pending.length}');
    for (var notification in pending) {
      print('Pending notification ID: ${notification.id}, title: ${notification.title}, body: ${notification.body}');
    }
    return pending;
  }

  // Show immediate test notification
  static Future<void> showTestNotification() async {
    print('Attempting to show test notification...');
    
    // Check if notifications are enabled on Android
    final androidPlugin = _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      final areEnabled = await androidPlugin.areNotificationsEnabled();
      print('Android notifications enabled: $areEnabled');
    }

    // Check iOS permissions
    final iosPlugin = _notifications.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    if (iosPlugin != null) {
      print('iOS platform detected');
    }

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'task_due_channel',
      'Task Due Notifications',
      channelDescription: 'Notifications for when tasks are due',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      enableLights: true,
      enableVibration: true,
      playSound: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      presentBanner: true,
      presentList: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    try {
      print('Calling _notifications.show()...');
      await _notifications.show(
        999, // Test notification ID
        'Test Notification ✅',
        'If you see this in notification center, notifications are working!',
        notificationDetails,
        payload: 'test',
      );
      print('_notifications.show() completed successfully');
      
      // Give a small delay then check pending notifications
      await Future.delayed(const Duration(milliseconds: 500));
      final pending = await getPendingNotifications();
      print('Pending notifications after test: ${pending.length}');
      
    } catch (e) {
      print('Error showing test notification: $e');
      rethrow;
    }
  }

  // Check notification permission status without requesting
  static Future<bool> checkPermissionStatus() async {
    print('Checking notification permission status...');

    // Check Android permissions
    final androidPlugin = _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      final areEnabled = await androidPlugin.areNotificationsEnabled();
      print('Android notifications enabled: $areEnabled');
      return areEnabled ?? false;
    }

    // For iOS, we need to check permission status
    // Note: iOS doesn't provide a direct way to check without requesting
    // The permission status is implicit - if notifications were denied,
    // they won't show up. We assume granted for now.
    final iosPlugin = _notifications.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    if (iosPlugin != null) {
      print('iOS platform detected - permission status check not directly available');
      // iOS doesn't expose permission status check in flutter_local_notifications
      // Return true optimistically, or implement platform channel for detailed check
      return true;
    }

    return false;
  }

  // Check and request notification permissions
  static Future<bool> checkAndRequestPermissions() async {
    print('Checking notification permissions...');

    // Check Android permissions
    final androidPlugin = _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      final areEnabled = await androidPlugin.areNotificationsEnabled();
      print('Android notifications currently enabled: $areEnabled');

      if (areEnabled == false) {
        // Request permission
        final granted = await androidPlugin.requestNotificationsPermission();
        print('Android notification permission granted: $granted');
        return granted ?? false;
      }
      return areEnabled ?? false;
    }

    // Check iOS permissions
    final iosPlugin = _notifications.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    if (iosPlugin != null) {
      final granted = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
        critical: true,
      );
      print('iOS notification permissions granted: $granted');
      return granted ?? false;
    }

    return false;
  }

  // Simple notification test without channels (for iOS simulator compatibility)
  static Future<void> showSimpleTestNotification() async {
    print('Showing simple test notification...');
    
    try {
      await _notifications.show(
        998,
        'Simple Test 🔔',
        'Basic notification without platform-specific details',
        const NotificationDetails(),
        payload: 'simple_test',
      );
      print('Simple notification sent');
    } catch (e) {
      print('Error with simple notification: $e');
    }
  }
}