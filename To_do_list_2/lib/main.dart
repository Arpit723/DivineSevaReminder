import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/notification_service.dart';
import 'presentation/navigation/app_router.dart';
import 'presentation/theme/app_theme.dart';
import 'presentation/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (optional - will fail gracefully if not configured)
  bool firebaseInitialized = false;
  try {
    await Firebase.initializeApp();
    firebaseInitialized = true;
    print('Firebase initialized successfully');
  } catch (e) {
    // Firebase not configured, continue without it
    print('Firebase not initialized: $e');
    print('App will continue without Firebase features');
  }

  // Initialize notification service
  await NotificationService.initialize();

  runApp(
    ProviderScope(
      child: TodoApp(key: UniqueKey()),
    ),
  );
}

class TodoApp extends ConsumerStatefulWidget {
  const TodoApp({super.key});

  @override
  ConsumerState<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends ConsumerState<TodoApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Initialize theme from persistent storage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(themeControllerProvider.notifier).initialize();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Email verification feature commented out
    /*
    if (state == AppLifecycleState.resumed) {
      // Check email verification when app resumes
      _checkEmailVerification();
    }
    */
  }

  // Email verification feature commented out
  /*
  Future<void> _checkEmailVerification() async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      final userResult = await authRepository.getCurrentUser();

      userResult.fold(
        (failure) => null,
        (user) {
          if (user != null && !user.emailVerified) {
            // User is logged in but email not verified
            // Check if verification status has changed
            authRepository.checkEmailVerification().then((result) {
              result.fold(
                (failure) => null,
                (isVerified) {
                  if (isVerified) {
                    // Email was verified, refresh the auth state
                    ref.invalidate(getCurrentUserProvider);
                  }
                },
              );
            });
          }
        },
      );
    } catch (e) {
      // Silently fail on lifecycle check
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Divine To Do List',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
