// ignore_for_file: invalid_annotation_target

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:flutter_starter/app/core/core.dart';
import 'package:flutter_starter/app/core/models/models.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    @JsonKey(name: 'auth_id') required String authId,
    @JsonKey(name: 'name') required String name,
    required String email,
    @JsonKey(name: 'birth_date') required DateTime birthDate,
    @Default(Settings()) Settings settings,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
