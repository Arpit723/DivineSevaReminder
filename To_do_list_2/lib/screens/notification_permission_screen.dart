import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/notification_service.dart';

class NotificationPermissionScreen extends StatefulWidget {
  final VoidCallback onPermissionGranted;

  const NotificationPermissionScreen({
    super.key,
    required this.onPermissionGranted,
  });

  @override
  State<NotificationPermissionScreen> createState() =>
      _NotificationPermissionScreenState();
}

class _NotificationPermissionScreenState
    extends State<NotificationPermissionScreen> {
  bool _isRequesting = false;

  Future<void> _requestPermission() async {
    setState(() {
      _isRequesting = true;
    });

    try {
      // Request notification permissions - this will show native popup
      await NotificationService.requestPermissions();

      // Check if permissions were granted
      final granted = await NotificationService.checkAndRequestPermissions();

      // Save that permission has been requested
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('notification_permission_requested', true);

      if (granted) {
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Notification permissions granted!'),
              backgroundColor: Colors.green,
            ),
          );

          // Wait a moment for user to see the message
          await Future.delayed(const Duration(milliseconds: 500));

          // Navigate to main screen
          widget.onPermissionGranted();
        }
      } else {
        // Permission denied
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Notifications disabled. You can enable them later in settings.',
              ),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 3),
            ),
          );

          // Still navigate to main screen after a delay
          await Future.delayed(const Duration(seconds: 2));
          widget.onPermissionGranted();
        }
      }
    } catch (e) {
      print('Error requesting notification permission: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isRequesting = false;
        });
      }
    }
  }

  Future<void> _skipForNow() async {
    // Save that permission has been requested (user chose to skip)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification_permission_requested', true);

    // Navigate to main screen
    widget.onPermissionGranted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icon
              Icon(
                Icons.notifications_active,
                size: 120,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 32),

              // Title
              const Text(
                'Stay Updated',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Description
              const Text(
                'Enable notifications to get reminded about your tasks and sevas.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Features list
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FeatureItem(
                    icon: Icons.alarm,
                    text: 'Get reminded when tasks are due',
                  ),
                  SizedBox(height: 12),
                  _FeatureItem(
                    icon: Icons.notifications,
                    text: 'Receive alerts 1 hour before deadline',
                  ),
                  SizedBox(height: 12),
                  _FeatureItem(
                    icon: Icons.wb_sunny,
                    text: 'Daily 9 AM reminder for pending tasks',
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Allow button
              ElevatedButton(
                onPressed: _isRequesting ? null : _requestPermission,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B0000),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isRequesting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Allow Notifications',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              const SizedBox(height: 16),

              // Skip button
              TextButton(
                onPressed: _isRequesting ? null : _skipForNow,
                child: const Text(
                  'Skip for now',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF8B0000),
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
