// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Project imports:
import '../core.dart';

extension InheritedContext on BuildContext {
  // inherited
  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);
  ThemeData get theme => Theme.of(this);
  MediaQueryData get media => MediaQuery.of(this);

  // constants
  Paddings get paddings => const Paddings();

  // methods
  void showSnackBar(String message) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      messenger.clearSnackBars();
      messenger.showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    });
  }
}
