// Package imports:
import 'package:flutter/material.dart';
import '../core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
