import 'package:flutter/material.dart';
import 'services/notification_service.dart';
import 'screens/task_list_screen.dart';

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
      home: const TodoListScreen(),
    );
  }
}
