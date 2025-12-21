import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/notification_service.dart';
import 'login_screen.dart';
import 'task_list_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with WidgetsBindingObserver {
  bool _notificationsEnabled = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkNotificationPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // When app comes back from background, refresh permission status
    if (state == AppLifecycleState.resumed) {
      _checkNotificationPermission();
    }
  }

  Future<void> _checkNotificationPermission() async {
    setState(() {
      _isLoading = true;
    });

    final enabled = await NotificationService.checkAndRequestPermissions();

    setState(() {
      _notificationsEnabled = enabled;
      _isLoading = false;
    });
  }

  Future<void> _showEnablePermissionDialog() async {
    if (!mounted) return;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enable Notifications'),
        content: const Text(
          'Notification permission is required to receive reminders about your tasks. Please enable it in your device settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B0000),
              foregroundColor: Colors.white,
            ),
            child: const Text('Settings'),
          ),
        ],
      ),
    );

    if (result == true) {
      // Open app settings
      // Permission will be automatically rechecked when app resumes
      await openAppSettings();
    }
  }

  Future<void> _showDisablePermissionDialog() async {
    if (!mounted) return;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Disable Notifications'),
        content: const Text(
          'You can turn off notifications from your device settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B0000),
              foregroundColor: Colors.white,
            ),
            child: const Text('Settings'),
          ),
        ],
      ),
    );

    if (result == true) {
      // Open app settings
      // Permission will be automatically rechecked when app resumes
      await openAppSettings();
    }
  }

  Future<void> _toggleNotifications(bool value) async {
    if (value) {
      // User wants to enable notifications
      setState(() {
        _isLoading = true;
      });

      // Request permissions
      await NotificationService.requestPermissions();

      // Check if granted
      final granted = await NotificationService.checkAndRequestPermissions();

      setState(() {
        _notificationsEnabled = granted;
        _isLoading = false;
      });

      if (!granted && mounted) {
        // Permission denied - show alert with Settings option
        await _showEnablePermissionDialog();
      }
    } else {
      // User wants to disable notifications
      // Show alert with Settings option
      await _showDisablePermissionDialog();
    }
  }

  Future<void> _handleLogout() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B0000),
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      // Clear login status
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', false);

      if (!mounted) return;

      // Navigate to login screen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(
            onLoginSuccess: () async {
              // Save login status
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('is_logged_in', true);

              if (!mounted) return;

              // Navigate to task list
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const TodoListScreen(),
                ),
                (route) => false,
              );
            },
          ),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF8B0000),
        elevation: 2,
      ),
      body: ListView(
        children: [
          // Notifications Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Notifications',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),

          // Notification Permission Toggle
          Container(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(
                Icons.notifications,
                color: Color(0xFF8B0000),
              ),
              title: const Text('Notification Permission'),
              subtitle: Text(
                _notificationsEnabled
                    ? 'Notifications are enabled'
                    : 'Notifications are disabled',
                style: TextStyle(
                  color: _notificationsEnabled ? Colors.green : Colors.grey,
                  fontSize: 12,
                ),
              ),
              trailing: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : Switch(
                      value: _notificationsEnabled,
                      onChanged: _toggleNotifications,
                      activeColor: const Color(0xFF8B0000),
                    ),
            ),
          ),

          const Divider(height: 1),

          // App Info Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'About',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),

          // App Version
          Container(
            color: Colors.white,
            child: const ListTile(
              leading: Icon(
                Icons.info_outline,
                color: Color(0xFF8B0000),
              ),
              title: Text('App Version'),
              subtitle: Text('1.0.0'),
            ),
          ),

          const Divider(height: 1),

          // App Name
          Container(
            color: Colors.white,
            child: const ListTile(
              leading: Icon(
                Icons.apps,
                color: Color(0xFF8B0000),
              ),
              title: Text('Divine To-Do List'),
              subtitle: Text('Manage your sevas and tasks'),
            ),
          ),

          const SizedBox(height: 24),

          // Account Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Account',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),

          // Logout Button
          Container(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(
                Icons.logout,
                color: Color(0xFF8B0000),
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Color(0xFF8B0000),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: _handleLogout,
            ),
          ),
        ],
      ),
    );
  }
}
