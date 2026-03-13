import 'package:flutter/material.dart';

/// Immutable color palette for the application
class AppColors {
  // Light theme colors
  static const Color primaryLight = Color(0xFF8B0000);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF5F5F5);
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onBackgroundLight = Color(0xFF212121);
  static const Color onSurfaceLight = Color(0xFF424242);
  static const Color errorLight = Color(0xFFB00020);

  // Dark theme colors
  static const Color primaryDark = Color(0xFFA52A2A);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color onPrimaryDark = Color(0xFFFFFFFF);
  static const Color onBackgroundDark = Color(0xFFE0E0E0);
  static const Color onSurfaceDark = Color(0xFFBDBDBD);
  static const Color errorDark = Color(0xFFCF6679);

  // Common colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Opacity variants
  static Color primaryWithOpacity(BuildContext context, double opacity) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final baseColor = isDark ? primaryDark : primaryLight;
    return baseColor.withValues(alpha: opacity);
  }
}

/// Application theme configuration
/// Provides light and dark themes with consistent styling
class AppTheme {
  /// Light theme definition
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryLight,
        onPrimary: AppColors.onPrimaryLight,
        secondary: AppColors.primaryLight,
        onSecondary: AppColors.onPrimaryLight,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.onSurfaceLight,
        error: AppColors.errorLight,
        onError: Colors.white,
        errorContainer: const Color(0xFFFCD8DF),
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceLight,
        foregroundColor: AppColors.primaryLight,
        elevation: 2,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        titleTextStyle: TextStyle(
          color: AppColors.primaryLight,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.onPrimaryLight,
        elevation: 4,
      ),
      cardTheme: const CardThemeData(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.onPrimaryLight,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.surfaceLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.errorLight),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      textTheme: _buildTextTheme(AppColors.onBackgroundLight),
      iconTheme: const IconThemeData(
        color: AppColors.onSurfaceLight,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.surfaceLight,
        thickness: 1,
        space: 1,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.onSurfaceLight,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.primaryLight.withValues(alpha: 0.2),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 12, color: AppColors.primaryLight),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primaryLight);
          }
          return const IconThemeData(color: AppColors.onSurfaceLight);
        }),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.onBackgroundLight,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        elevation: 8,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
    );
  }

  /// Dark theme definition
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryDark,
        onPrimary: AppColors.onPrimaryDark,
        secondary: AppColors.primaryDark,
        onSecondary: AppColors.onPrimaryDark,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.onSurfaceDark,
        error: AppColors.errorDark,
        onError: Colors.black,
        errorContainer: const Color(0xFF662A2E),
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.primaryDark,
        elevation: 2,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.primaryDark),
        titleTextStyle: TextStyle(
          color: AppColors.primaryDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.onPrimaryDark,
        elevation: 4,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.onPrimaryDark,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryDark,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.surfaceDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryDark, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.errorDark),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      textTheme: _buildTextTheme(AppColors.onBackgroundDark),
      iconTheme: const IconThemeData(
        color: AppColors.onSurfaceDark,
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.surfaceDark,
        thickness: 1,
        space: 1,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.primaryDark,
        unselectedItemColor: AppColors.onSurfaceDark,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        indicatorColor: AppColors.primaryDark.withValues(alpha: 0.2),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 12, color: AppColors.primaryDark),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primaryDark);
          }
          return const IconThemeData(color: AppColors.onSurfaceDark);
        }),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.onSurfaceDark,
        contentTextStyle: const TextStyle(color: AppColors.backgroundDark),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceDark,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        elevation: 8,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
    );
  }

  /// Build consistent text theme
  static TextTheme _buildTextTheme(Color primaryColor) {
    return TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      bodyLarge: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
