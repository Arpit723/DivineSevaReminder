import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../screens/task_list_screen.dart';
import '../../screens/task_detail_screen.dart';
import '../../screens/category_list_screen.dart';
import '../../screens/settings_screen.dart';
import '../../screens/profile_screen.dart';
import '../../screens/login_screen.dart';
import '../../screens/notification_permission_screen.dart';
import '../../models/task.dart';

part 'app_router.g.dart';

/// Router configuration provider
@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/splash',
    routes: [
      // Splash Screen
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),

      // Authentication Routes
      GoRoute(
        path: '/auth/login',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: LoginScreen(
            onLoginSuccess: () {
              // Navigation handled by auth state change
            },
          ),
        ),
      ),

      // Permission Screen
      GoRoute(
        path: '/permission',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: NotificationPermissionScreen(
            onPermissionGranted: () {
              // Navigate to home after permission granted
              context.go('/');
            },
          ),
        ),
      ),

      // Main App - Task List
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const TodoListScreen(),
        ),
      ),

      // Task Detail
      GoRoute(
        path: '/task/new',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: TaskDetailScreen(
            isNewTask: true,
            task: Task(
              id: '',
              title: '',
              description: '',
              status: TaskStatus.assigned,
              createdAt: DateTime.now(),
            ),
            onEditTask: (id, title) {},
            onDeleteTask: (id) {},
            onToggleCompletion: (id) {},
          ),
        ),
      ),

      // Categories
      GoRoute(
        path: '/categories',
        pageBuilder: (context, state) => const MaterialPage(
          key: ValueKey('categories'),
          child: CategoryListScreen(),
        ),
      ),

      // Profile
      GoRoute(
        path: '/profile',
        pageBuilder: (context, state) => const MaterialPage(
          key: ValueKey('profile'),
          child: ProfileScreen(),
        ),
      ),

      // Settings
      GoRoute(
        path: '/settings',
        pageBuilder: (context, state) => const MaterialPage(
          key: ValueKey('settings'),
          child: SettingsScreen(),
        ),
      ),
    ],

    // Error Page
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(state.uri.toString()),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Splash screen widget that checks auth state and navigates
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Wait a bit for the app to fully initialize
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    try {
      // Check if Firebase is initialized
      final firebaseApps = Firebase.apps;
      print('Firebase apps count: ${firebaseApps.length}');

      if (firebaseApps.isEmpty) {
        // Firebase not initialized, navigate to login
        if (mounted) {
          print('Firebase not initialized, navigating to /auth/login');
          context.go('/auth/login');
        }
        return;
      }

      // Check if user is already logged in
      final auth = FirebaseAuth.instance;
      final currentUser = auth.currentUser;

      if (mounted) {
        if (currentUser != null) {
          // User is logged in, navigate to seva list screen
          print('User already logged in: ${currentUser.email}, navigating to /');
          context.go('/');
        } else {
          // User not logged in, navigate to login screen
          print('No user logged in, navigating to /auth/login');
          context.go('/auth/login');
        }
      }
    } catch (e, stackTrace) {
      // Firebase not available or not initialized, navigate to login
      print('Error checking Firebase state: $e');
      print('Stack trace: $stackTrace');
      if (mounted) {
        print('Navigating to /auth/login (due to error)');
        context.go('/auth/login');
      }
    }
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
