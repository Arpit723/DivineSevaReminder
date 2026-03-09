// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseCategoryServiceHash() =>
    r'514d1c0aea57bf2682a7143bbc3cff3e6b4d01c7';

/// Provider for Firebase category service
///
/// Copied from [firebaseCategoryService].
@ProviderFor(firebaseCategoryService)
final firebaseCategoryServiceProvider =
    AutoDisposeProvider<FirebaseCategoryService>.internal(
  firebaseCategoryService,
  name: r'firebaseCategoryServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseCategoryServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirebaseCategoryServiceRef
    = AutoDisposeProviderRef<FirebaseCategoryService>;
String _$categoryRepositoryHash() =>
    r'b1f89c0698ac6984125729dcc1f3e1cd6af7a50f';

/// Provider for category repository
///
/// Copied from [categoryRepository].
@ProviderFor(categoryRepository)
final categoryRepositoryProvider =
    AutoDisposeProvider<CategoryRepository>.internal(
  categoryRepository,
  name: r'categoryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoryRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoryRepositoryRef = AutoDisposeProviderRef<CategoryRepository>;
String _$allCategoriesHash() => r'd005b25f210ca81d8f7bb5acc37060c82b9c0c1e';

/// Provider for all categories (built-in + custom)
///
/// Copied from [allCategories].
@ProviderFor(allCategories)
final allCategoriesProvider =
    AutoDisposeStreamProvider<List<SevaCategory>>.internal(
  allCategories,
  name: r'allCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allCategoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllCategoriesRef = AutoDisposeStreamProviderRef<List<SevaCategory>>;
String _$customCategoriesHash() => r'2097ae4a74c74acc9e15d4515c58a5281a93b834';

/// Provider for custom categories only
///
/// Copied from [customCategories].
@ProviderFor(customCategories)
final customCategoriesProvider =
    AutoDisposeStreamProvider<List<SevaCategory>>.internal(
  customCategories,
  name: r'customCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customCategoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CustomCategoriesRef = AutoDisposeStreamProviderRef<List<SevaCategory>>;
String _$builtInCategoriesHash() => r'23a6ecb16a67e794e2ce4eb673f4012c28ea5c75';

/// Provider for built-in categories (synchronous)
///
/// Copied from [builtInCategories].
@ProviderFor(builtInCategories)
final builtInCategoriesProvider =
    AutoDisposeProvider<List<SevaCategory>>.internal(
  builtInCategories,
  name: r'builtInCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$builtInCategoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BuiltInCategoriesRef = AutoDisposeProviderRef<List<SevaCategory>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
