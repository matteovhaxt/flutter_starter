// Package imports:
import 'package:easy_localization/easy_localization.dart';

extension EmailValidator on String {
  String? validateEmail() {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final isValid = RegExp(pattern).hasMatch(this);
    if (!isValid) {
      return 'validation.email'.tr();
    }
    return null;
  }

  bool isEmailValid() => validateEmail() == null;
}

extension PasswordValidator on String {
  String? validatePassword() {
    final patterns = {
      r'^(?=.*[A-Z])': 'validation.uppercase'.tr(),
      r'^(?=.*[a-z])': 'validation.lowercase'.tr(),
      r'^(?=.*?[0-9])': 'validation.digit'.tr(),
      r'^(?=.*?[!@#\$&*~])': 'validation.special_char'.tr(),
      r'^.{8,}': 'validation.min_8_char'.tr(),
    };

    for (var i in patterns.keys) {
      final isValid = RegExp(i).hasMatch(this);
      if (!isValid) {
        return patterns[i];
      }
    }
    return null;
  }

  bool isPasswordValid() => validatePassword() == null;
}
