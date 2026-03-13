import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fpdart/fpdart.dart' hide State;
import '../services/notification_service.dart';
import '../presentation/providers/auth_providers.dart';
import '../presentation/providers/theme_provider.dart';
import '../domain/entities/user/user.dart';
import '../core/errors/failures.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _SettingsScreenContent(ref: ref);
  }
}

class _SettingsScreenContent extends StatefulWidget {
  final WidgetRef ref;

  const _SettingsScreenContent({required this.ref});

  @override
  State<_SettingsScreenContent> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<_SettingsScreenContent> with WidgetsBindingObserver {
  bool _notificationsEnabled = false;
  bool _isLoading = true;
  bool _isLoggingOut = false;
  User? _currentUser;
  bool _isLoadingUser = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkNotificationPermission();
    _fetchCurrentUser();
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

  Future<void> _fetchCurrentUser() async {
    setState(() {
      _isLoadingUser = true;
    });

    final authRepository = widget.ref.read(authRepositoryProvider);
    final result = await authRepository.getCurrentUser();

    if (mounted) {
      result.fold(
        (failure) {
          setState(() {
            _isLoadingUser = false;
          });
        },
        (user) {
          if (user != null) {
            setState(() {
              _currentUser = user;
              _isLoadingUser = false;
            });
          } else {
            setState(() {
              _isLoadingUser = false;
            });
          }
        },
      );
    }
  }

  Future<void> _checkNotificationPermission() async {
    setState(() {
      _isLoading = true;
    });

    final enabled = await NotificationService.checkAndRequestPermissions();

    if (mounted) {
      setState(() {
        _notificationsEnabled = enabled;
        _isLoading = false;
      });
    }
  }

  Future<void> _showEnablePermissionDialog() async {
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

    if (result == true && mounted) {
      // Open app settings
      await openAppSettings();
    }
  }

  Future<void> _showDisablePermissionDialog() async {
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

    if (result == true && mounted) {
      // Open app settings
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

      if (mounted) {
        setState(() {
          _notificationsEnabled = granted;
          _isLoading = false;
        });
      }

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
            child: _isLoggingOut
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text('Logout'),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      setState(() {
        _isLoggingOut = true;
      });

      // Call Firebase signOut
      final authRepository = widget.ref.read(authRepositoryProvider);
      await authRepository.signOut();

      // Clear only login-related preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('is_logged_in');

      if (mounted) {
        setState(() {
          _isLoggingOut = false;
        });

        // Navigate to login screen using GoRouter
        context.go('/auth/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = widget.ref.watch(themeControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        foregroundColor: isDark ? const Color(0xFFA52A2A) : const Color(0xFF8B0000),
        elevation: 2,
      ),
      body: ListView(
        children: [
          // Appearance Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Appearance',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey.shade400 : Colors.grey,
              ),
            ),
          ),

          // Theme Mode Selector
          Container(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            child: Column(
              children: [
                _ThemeOptionTile(
                  icon: Icons.light_mode,
                  title: 'Light Mode',
                  subtitle: 'Always use light theme',
                  value: ThemeModeOption.light,
                  groupValue: themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      widget.ref.read(themeControllerProvider.notifier).setTheme(value);
                    }
                  },
                ),
                Divider(
                  height: 1,
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                  indent: 16,
                ),
                _ThemeOptionTile(
                  icon: Icons.dark_mode,
                  title: 'Dark Mode',
                  subtitle: 'Always use dark theme',
                  value: ThemeModeOption.dark,
                  groupValue: themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      widget.ref.read(themeControllerProvider.notifier).setTheme(value);
                    }
                  },
                ),
                Divider(
                  height: 1,
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                  indent: 16,
                ),
                _ThemeOptionTile(
                  icon: Icons.brightness_auto,
                  title: 'System Default',
                  subtitle: 'Match your device theme',
                  value: ThemeModeOption.system,
                  groupValue: themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      widget.ref.read(themeControllerProvider.notifier).setTheme(value);
                    }
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Notifications Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Notifications',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey.shade400 : Colors.grey,
              ),
            ),
          ),

          // Notification Permission Toggle
          Container(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            child: ListTile(
              leading: Icon(
                Icons.notifications,
                color: isDark ? const Color(0xFFA52A2A) : const Color(0xFF8B0000),
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
                      activeColor: isDark ? const Color(0xFFA52A2A) : const Color(0xFF8B0000),
                    ),
            ),
          ),

          Divider(
            height: 1,
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          ),

          // App Info Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'About',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey.shade400 : Colors.grey,
              ),
            ),
          ),

          // App Version
          Container(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            child: ListTile(
              leading: Icon(
                Icons.info_outline,
                color: isDark ? const Color(0xFFA52A2A) : const Color(0xFF8B0000),
              ),
              title: const Text('App Version'),
              subtitle: const Text('1.0.0'),
            ),
          ),

          Divider(
            height: 1,
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          ),

          // App Name
          Container(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            child: ListTile(
              leading: Icon(
                Icons.apps,
                color: isDark ? const Color(0xFFA52A2A) : const Color(0xFF8B0000),
              ),
              title: const Text('Divine To-Do List'),
              subtitle: const Text('Manage your sevas and tasks'),
            ),
          ),

          const SizedBox(height: 24),

          // Account Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Account',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey.shade400 : Colors.grey,
              ),
            ),
          ),

          // Profile Cell
          Container(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            child: ListTile(
              leading: Icon(
                Icons.person_outline,
                color: isDark ? const Color(0xFFA52A2A) : const Color(0xFF8B0000),
              ),
              title: const Text('Profile'),
              subtitle: Text(
                _isLoadingUser
                    ? 'Loading...'
                    : (_currentUser?.fullName ?? 'View your profile'),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              trailing: _isLoadingUser
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : Icon(
                      Icons.chevron_right,
                      color: isDark ? Colors.grey.shade400 : Colors.grey,
                    ),
              onTap: () {
                // Navigate to profile screen
                context.push('/profile');
              },
            ),
          ),

          Divider(
            height: 1,
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          ),

          // Logout Button
          Container(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: isDark ? const Color(0xFFA52A2A) : const Color(0xFF8B0000),
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: isDark ? const Color(0xFFA52A2A) : const Color(0xFF8B0000),
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

/// Widget for theme option radio tile
class _ThemeOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final ThemeModeOption value;
  final ThemeModeOption groupValue;
  final ValueChanged<ThemeModeOption?> onChanged;

  const _ThemeOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? const Color(0xFFA52A2A) : const Color(0xFF8B0000);

    return RadioListTile<ThemeModeOption>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: primaryColor,
      title: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? primaryColor : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 32),
        child: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
