import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seva_category.freezed.dart';
part 'seva_category.g.dart';

/// Seva category types for organizing service/spiritual tasks
enum SevaCategoryType {
  @JsonValue('built_in')
  builtIn,
  @JsonValue('custom')
  custom,
}

/// Built-in Seva categories with predefined icons and colors
enum BuiltInCategory {
  @JsonValue('transportation')
  transportation('Transportation', Icons.directions_car, Colors.blue),
  @JsonValue('food')
  food('Food', Icons.restaurant, Colors.orange),
  @JsonValue('bills')
  bills('Bills', Icons.receipt_long, Colors.purple),
  @JsonValue('bigExpenditure')
  bigExpenditure('Big expenditure', Icons.payments, Colors.red),
  @JsonValue('medicines')
  medicines('Medicines', Icons.medication, Colors.teal),
  @JsonValue('centerSeva')
  centerSeva('Center Seva', Icons.temple_hindu, Color(0xFF8B0000)),

  // Religious/Spiritual categories
  @JsonValue('templeSeva')
  templeSeva('Temple Seva', Icons.temple_buddhist, Color(0xFF8B0000)),
  @JsonValue('pujaRitual')
  pujaRitual('Puja/Ritual', Icons.auto_awesome, Colors.amber),
  @JsonValue('prayerTime')
  prayerTime('Prayer Time', Icons.access_time, Colors.indigo),
  @JsonValue('fasting')
  fasting('Fasting', Icons.no_meals, Colors.green),
  @JsonValue('spiritualStudy')
  spiritualStudy('Spiritual Study', Icons.menu_book, Colors.brown),
  @JsonValue('satsang')
  satsang('Satsang', Icons.groups, Colors.deepOrange),
  @JsonValue('donationService')
  donationService('Donation/Service', Icons.volunteer_activism, Colors.pink),
  @JsonValue('communityService')
  communityService('Community Service', Icons.diversity_3, Colors.cyan),
  @JsonValue('festivalPreparation')
  festivalPreparation('Festival Preparation', Icons.celebration, Colors.deepPurple);

  const BuiltInCategory(this.name, this.icon, this.color);

  final String name;
  final IconData icon;
  final Color color;

  /// Get the JSON value
  String get value {
    switch (this) {
      case BuiltInCategory.transportation:
        return 'transportation';
      case BuiltInCategory.food:
        return 'food';
      case BuiltInCategory.bills:
        return 'bills';
      case BuiltInCategory.bigExpenditure:
        return 'bigExpenditure';
      case BuiltInCategory.medicines:
        return 'medicines';
      case BuiltInCategory.centerSeva:
        return 'centerSeva';
      case BuiltInCategory.templeSeva:
        return 'templeSeva';
      case BuiltInCategory.pujaRitual:
        return 'pujaRitual';
      case BuiltInCategory.prayerTime:
        return 'prayerTime';
      case BuiltInCategory.fasting:
        return 'fasting';
      case BuiltInCategory.spiritualStudy:
        return 'spiritualStudy';
      case BuiltInCategory.satsang:
        return 'satsang';
      case BuiltInCategory.donationService:
        return 'donationService';
      case BuiltInCategory.communityService:
        return 'communityService';
      case BuiltInCategory.festivalPreparation:
        return 'festivalPreparation';
    }
  }

  /// Create from JSON value
  static BuiltInCategory fromValue(String value) {
    return BuiltInCategory.values.firstWhere(
      (cat) => cat.value == value,
      orElse: () => BuiltInCategory.centerSeva,
    );
  }

  /// Get all religious/spiritual categories
  static List<BuiltInCategory> get religiousCategories => [
        templeSeva,
        pujaRitual,
        prayerTime,
        fasting,
        spiritualStudy,
        satsang,
        donationService,
        communityService,
        festivalPreparation,
      ];

  /// Get original categories (from existing app)
  static List<BuiltInCategory> get originalCategories => [
        transportation,
        food,
        bills,
        bigExpenditure,
        medicines,
        centerSeva,
      ];

  /// Get all built-in categories
  static List<BuiltInCategory> get allCategories => [
        ...originalCategories,
        ...religiousCategories,
      ];
}

/// Seva Category entity for task organization
@freezed
class SevaCategory with _$SevaCategory {
  const SevaCategory._();

  const factory SevaCategory.builtIn({
    required String id,
    required BuiltInCategory category,
  }) = SevaCategoryBuiltIn;

  const factory SevaCategory.custom({
    required String id,
    required String name,
    required String iconName,
    required int colorValue,
    DateTime? createdAt,
  }) = SevaCategoryCustom;

  factory SevaCategory.fromJson(Map<String, dynamic> json) =>
      _$SevaCategoryFromJson(json);

  // MARK: - Computed Properties

  /// Get display name
  String get displayName {
    return when(
      builtIn: (id, category) => category.name,
      custom: (id, name, iconName, colorValue, createdAt) => name,
    );
  }

  /// Get icon
  IconData get icon {
    return when(
      builtIn: (id, category) => category.icon,
      custom: (id, name, iconName, colorValue, createdAt) =>
          _getIconFromName(iconName),
    );
  }

  /// Get color
  Color get color {
    return when(
      builtIn: (id, category) => category.color,
      custom: (id, name, iconName, colorValue, createdAt) =>
          Color(colorValue),
    );
  }

  /// Get category type
  SevaCategoryType get type {
    return when(
      builtIn: (_, __) => SevaCategoryType.builtIn,
      custom: (_, __, ___, ____, _____) => SevaCategoryType.custom,
    );
  }

  /// Helper to get icon from string name
  IconData _getIconFromName(String iconName) {
    // Map common icon names to IconData
    final iconMap = {
      'temple_hindu': Icons.temple_hindu,
      'temple_buddhist': Icons.temple_buddhist,
      'auto_awesome': Icons.auto_awesome,
      'access_time': Icons.access_time,
      'no_meals': Icons.no_meals,
      'menu_book': Icons.menu_book,
      'groups': Icons.groups,
      'volunteer_activism': Icons.volunteer_activism,
      'diversity_3': Icons.diversity_3,
      'celebration': Icons.celebration,
      'star': Icons.star,
      'favorite': Icons.favorite,
      'home': Icons.home,
      'work': Icons.work,
      'school': Icons.school,
      'shopping_cart': Icons.shopping_cart,
      'directions_car': Icons.directions_car,
      'restaurant': Icons.restaurant,
    };

    return iconMap[iconName] ?? Icons.label;
  }

  /// Create a built-in category from BuiltInCategory enum
  factory SevaCategory.fromBuiltIn(BuiltInCategory category) {
    return SevaCategory.builtIn(
      id: category.value,
      category: category,
    );
  }

  /// Get all built-in categories as SevaCategory objects
  static List<SevaCategory> getAllBuiltIn() {
    return BuiltInCategory.allCategories
        .map((cat) => SevaCategory.fromBuiltIn(cat))
        .toList();
  }
}
