import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/notification_service.dart';
import 'screens/task_list_screen.dart';
import 'screens/notification_permission_screen.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notification service
  await NotificationService.initialize();

  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Divine To Do List',
      theme: ThemeData(
        primarySwatch: Colors.red,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B0000), // Dark red
          primary: const Color(0xFF8B0000), // Dark red
          onPrimary: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF8B0000), // Dark red text
          elevation: 2,
          shadowColor: Colors.grey,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(color: Color(0xFF8B0000), fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: Color(0xFF8B0000), fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(color: Color(0xFF8B0000), fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: Color(0xFF8B0000), fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: Color(0xFF8B0000), fontWeight: FontWeight.bold),
          titleSmall: TextStyle(color: Color(0xFF8B0000), fontWeight: FontWeight.bold),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF8B0000),
          foregroundColor: Colors.white,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async {
    // Check if user is logged in
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    final permissionRequested = prefs.getBool('notification_permission_requested') ?? false;

    // Wait a brief moment for splash effect
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    if (!isLoggedIn) {
      // Not logged in, show login screen
      _navigateToLoginScreen();
    } else if (permissionRequested) {
      // Logged in and permission already handled, go to main screen
      _navigateToMainScreen();
    } else {
      // Logged in but first time, show permission screen
      _navigateToPermissionScreen();
    }
  }

  void _navigateToLoginScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(
          onLoginSuccess: () async {
            // Save login status
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('is_logged_in', true);

            // Check if permission was requested
            final permissionRequested = prefs.getBool('notification_permission_requested') ?? false;

            if (!mounted) return;

            if (permissionRequested) {
              // Permission already handled, go to main screen
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const TodoListScreen(),
                ),
              );
            } else {
              // First time, show permission screen
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => NotificationPermissionScreen(
                    onPermissionGranted: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const TodoListScreen(),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _navigateToMainScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const TodoListScreen(),
      ),
    );
  }

  void _navigateToPermissionScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => NotificationPermissionScreen(
          onPermissionGranted: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const TodoListScreen(),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF8B0000),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 24),
            Text(
              'Divine To-Do List',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
