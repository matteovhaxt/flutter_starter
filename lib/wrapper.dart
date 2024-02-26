import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/app/app.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: const [Locale('en', 'US')],
      child: App(),
    );
  }
}
