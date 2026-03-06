// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seva_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SevaCategoryBuiltInImpl _$$SevaCategoryBuiltInImplFromJson(
        Map<String, dynamic> json) =>
    _$SevaCategoryBuiltInImpl(
      id: json['id'] as String,
      category: $enumDecode(_$BuiltInCategoryEnumMap, json['category']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SevaCategoryBuiltInImplToJson(
        _$SevaCategoryBuiltInImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': _$BuiltInCategoryEnumMap[instance.category]!,
      'runtimeType': instance.$type,
    };

const _$BuiltInCategoryEnumMap = {
  BuiltInCategory.transportation: 'transportation',
  BuiltInCategory.food: 'food',
  BuiltInCategory.bills: 'bills',
  BuiltInCategory.bigExpenditure: 'bigExpenditure',
  BuiltInCategory.medicines: 'medicines',
  BuiltInCategory.centerSeva: 'centerSeva',
  BuiltInCategory.templeSeva: 'templeSeva',
  BuiltInCategory.pujaRitual: 'pujaRitual',
  BuiltInCategory.prayerTime: 'prayerTime',
  BuiltInCategory.fasting: 'fasting',
  BuiltInCategory.spiritualStudy: 'spiritualStudy',
  BuiltInCategory.satsang: 'satsang',
  BuiltInCategory.donationService: 'donationService',
  BuiltInCategory.communityService: 'communityService',
  BuiltInCategory.festivalPreparation: 'festivalPreparation',
};

_$SevaCategoryCustomImpl _$$SevaCategoryCustomImplFromJson(
        Map<String, dynamic> json) =>
    _$SevaCategoryCustomImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      iconName: json['iconName'] as String,
      colorValue: (json['colorValue'] as num).toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SevaCategoryCustomImplToJson(
        _$SevaCategoryCustomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconName': instance.iconName,
      'colorValue': instance.colorValue,
      'createdAt': instance.createdAt?.toIso8601String(),
      'runtimeType': instance.$type,
    };
