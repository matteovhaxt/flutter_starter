// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'app/app.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: EasyLocalization(
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        supportedLocales: const [Locale('en', 'US')],
        child: const App(),
      ),
    );
  }
}
