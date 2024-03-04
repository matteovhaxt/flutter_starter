// Flutter imports:
import 'package:flutter/material.dart';

extension InheritedContext on BuildContext {
  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);
  ThemeData get theme => Theme.of(this);
  MediaQueryData get media => MediaQuery.of(this);
}
