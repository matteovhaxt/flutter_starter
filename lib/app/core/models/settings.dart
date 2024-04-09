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
    @Default(ThemeMode.system) ThemeMode theme,
    @Default(Locale('en', 'US')) @LocaleConverter() Locale locale,
  }) = _Settings;

  factory Settings.fromJson(Map<String, Object?> json) =>
      _$SettingsFromJson(json);
}
