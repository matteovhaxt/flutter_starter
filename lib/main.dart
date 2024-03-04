// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'wrapper.dart';

void main() {
  runApp(
    const ProviderScope(
      child: AppWrapper(),
    ),
  );
}
