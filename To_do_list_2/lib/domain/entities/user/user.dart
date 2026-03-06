import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// User profile entity
@freezed
class User with _$User {
  const User._();

  const factory User({
    required String id,
    required String email,
    required String fullName,
    String? phoneNumber,
    String? photoUrl,
    @Default(false) bool emailVerified,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? lastLoginAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Create a new user
  factory User.create({
    required String id,
    required String email,
    required String fullName,
    String? phoneNumber,
    String? photoUrl,
  }) {
    final now = DateTime.now();
    return User(
      id: id,
      email: email,
      fullName: fullName,
      phoneNumber: phoneNumber,
      photoUrl: photoUrl,
      createdAt: now,
      updatedAt: now,
      lastLoginAt: now,
    );
  }

  /// Get user's initials for avatar
  String get initials {
    final parts = fullName.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return fullName.isNotEmpty ? fullName[0].toUpperCase() : '';
  }

  /// Get display name
  String get displayName {
    final parts = fullName.trim().split(' ');
    if (parts.length > 2) {
      return '${parts[0]} ${parts[1]}';
    }
    return fullName;
  }
}
