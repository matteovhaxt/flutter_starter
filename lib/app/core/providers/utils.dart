// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Project imports:
import '../../../env.dart';

part 'utils.g.dart';

@riverpod
Logger logger(LoggerRef ref) {
  return Logger();
}

@Riverpod(keepAlive: true)
Future<void> appStartup(AppStartupRef ref) async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await Supabase.initialize(
    url: Env.supabaseApiUrl,
    anonKey: Env.supabaseAnonKey,
  );
}
