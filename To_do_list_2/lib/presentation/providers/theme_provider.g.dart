// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeModeHash() => r'be700af05e005cd3c62924bc934142c887c9d6e1';

/// Provider for Flutter ThemeMode
///
/// Copied from [themeMode].
@ProviderFor(themeMode)
final themeModeProvider = AutoDisposeProvider<ThemeMode>.internal(
  themeMode,
  name: r'themeModeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$themeModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ThemeModeRef = AutoDisposeProviderRef<ThemeMode>;
String _$themeControllerHash() => r'f6316ed649fd839caed4d8632c5ed451dc386bb5';

/// Theme controller provider - manages theme state
///
/// Copied from [ThemeController].
@ProviderFor(ThemeController)
final themeControllerProvider =
    AutoDisposeNotifierProvider<ThemeController, ThemeModeOption>.internal(
  ThemeController.new,
  name: r'themeControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeController = AutoDisposeNotifier<ThemeModeOption>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
