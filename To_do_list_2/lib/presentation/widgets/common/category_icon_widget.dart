import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/seva/seva_category.dart';
import '../../providers/category_provider.dart';

/// Simple widget to display a category icon
/// Does not watch the provider - use when you have SevaCategory directly
class CategoryIconWidget extends StatelessWidget {
  final SevaCategory? category;
  final double size;
  final Color? defaultColor;

  const CategoryIconWidget({
    super.key,
    this.category,
    this.size = 24,
    this.defaultColor,
  });

  @override
  Widget build(BuildContext context) {
    if (category == null) {
      return Icon(
        Icons.label,
        color: defaultColor ?? const Color(0xFF8B0000),
        size: size,
      );
    }

    return Icon(
      category!.icon,
      color: category!.color,
      size: size,
    );
  }
}

/// Consumer widget that watches categories and displays the icon
/// Use this when you have categoryId but not the SevaCategory object
class CategoryIconConsumer extends ConsumerWidget {
  final String? categoryId;
  final String? customCategoryId;
  final double size;
  final Color? defaultColor;

  const CategoryIconConsumer({
    super.key,
    this.categoryId,
    this.customCategoryId,
    this.size = 24,
    this.defaultColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(allCategoriesProvider);

    return categoriesAsync.when(
      data: (categories) {
        // Determine which ID to use
        // If customCategoryId is present, use it; otherwise use categoryId
        final idToLookup = customCategoryId ?? categoryId;

        if (idToLookup == null) {
          return Icon(
            Icons.label,
            color: defaultColor ?? const Color(0xFF8B0000),
            size: size,
          );
        }

        final category = categories.getById(idToLookup);

        if (category == null) {
          return Icon(
            Icons.label,
            color: defaultColor ?? const Color(0xFF8B0000),
            size: size,
          );
        }

        return Icon(
          category.icon,
          color: category.color,
          size: size,
        );
      },
      loading: () => Icon(
        Icons.label,
        color: defaultColor ?? const Color(0xFF8B0000),
        size: size,
      ),
      error: (_, __) => Icon(
        Icons.error,
        color: Colors.red,
        size: size,
      ),
    );
  }
}

/// Widget to display category name
/// Watches the provider and displays the category name
class CategoryNameConsumer extends ConsumerWidget {
  final String? categoryId;
  final String? customCategoryId;
  final TextStyle? style;
  final String? fallbackText;

  const CategoryNameConsumer({
    super.key,
    this.categoryId,
    this.customCategoryId,
    this.style,
    this.fallbackText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(allCategoriesProvider);

    return categoriesAsync.when(
      data: (categories) {
        final idToLookup = customCategoryId ?? categoryId;

        if (idToLookup == null) {
          return Text(
            fallbackText ?? 'Unknown',
            style: style,
          );
        }

        final category = categories.getById(idToLookup);

        if (category == null) {
          return Text(
            fallbackText ?? 'Unknown',
            style: style,
          );
        }

        return Text(
          category.displayName,
          style: style,
        );
      },
      loading: () => Text(
        fallbackText ?? '...',
        style: style,
      ),
      error: (_, __) => Text(
        fallbackText ?? 'Error',
        style: style?.copyWith(color: Colors.red) ??
            const TextStyle(color: Colors.red),
      ),
    );
  }
}

/// Combined widget that displays both icon and name
/// Useful for category selection or display
class CategoryIconAndName extends ConsumerWidget {
  final String? categoryId;
  final String? customCategoryId;
  final double iconSize;
  final TextStyle? nameStyle;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const CategoryIconAndName({
    super.key,
    this.categoryId,
    this.customCategoryId,
    this.iconSize = 24,
    this.nameStyle,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(allCategoriesProvider);

    return categoriesAsync.when(
      data: (categories) {
        final idToLookup = customCategoryId ?? categoryId;

        if (idToLookup == null) {
          return Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: [
              Icon(
                Icons.label,
                color: const Color(0xFF8B0000),
                size: iconSize,
              ),
              const SizedBox(width: 8),
              Text('No Category', style: nameStyle),
            ],
          );
        }

        final category = categories.getById(idToLookup);

        if (category == null) {
          return Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: [
              Icon(
                Icons.label,
                color: const Color(0xFF8B0000),
                size: iconSize,
              ),
              const SizedBox(width: 8),
              Text('Unknown', style: nameStyle),
            ],
          );
        }

        return Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Icon(
              category.icon,
              color: category.color,
              size: iconSize,
            ),
            const SizedBox(width: 8),
            Text(
              category.displayName,
              style: nameStyle,
            ),
          ],
        );
      },
      loading: () => Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Icon(
            Icons.label,
            color: const Color(0xFF8B0000),
            size: iconSize,
          ),
          const SizedBox(width: 8),
          Text('...', style: nameStyle),
        ],
      ),
      error: (_, __) => Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
            size: iconSize,
          ),
          const SizedBox(width: 8),
          Text(
            'Error',
            style: nameStyle?.copyWith(color: Colors.red) ??
                const TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
