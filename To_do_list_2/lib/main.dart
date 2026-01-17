import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/notification_service.dart';
import 'presentation/navigation/app_router.dart';

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
    const ProviderScope(
      child: TodoApp(),
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

    return MaterialApp.router(
      title: 'Divine To Do List',
      debugShowCheckedModeBanner: false,
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
      routerConfig: router,
    );
  }
}
