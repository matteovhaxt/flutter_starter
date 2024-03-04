// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/web.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Project imports:
import 'env.dart';
import 'wrapper.dart';

void main() {
  // ignore: missing_provider_scope
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();

      await Supabase.initialize(
        url: Env.supabaseUrl,
        anonKey: Env.supabaseKey,
      );

      return const AppWrapper();
    },
    (error, stackTrace) {
      Logger().e(error);

      // ignore: missing_provider_scope
      runApp(const AppWrapper());
    },
  );
}
