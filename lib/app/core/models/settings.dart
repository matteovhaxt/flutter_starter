// Flutter imports:
// ignore_for_file: invalid_annotation_target

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import '../core.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @Default(ThemeMode.system) ThemeMode theme,
    @Default(Locale('en', 'US')) @LocaleConverter() Locale locale,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Settings;

  factory Settings.fromJson(Map<String, Object?> json) =>
      _$SettingsFromJson(json);
}
