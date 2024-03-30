// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'app/app.dart';
import 'app/core/core.dart';

class AppWrapper extends ConsumerWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      data: (_) => EasyLocalization(
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        supportedLocales: const [Locale('en', 'US')],
        child: const App(),
      ),
      error: (error, stackTrace) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              error.toString(),
            ),
          ),
        ),
      ),
      loading: () => const MaterialApp(
        home: Scaffold(
          body: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
