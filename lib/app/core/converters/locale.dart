import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class LocaleConverter implements JsonConverter<Locale, String> {
  const LocaleConverter();

  @override
  Locale fromJson(String json) => Locale(json.split('_').first,
      json.split('_').length > 1 ? json.split('_').last : null);

  @override
  String toJson(Locale locale) => locale.toString();
}
