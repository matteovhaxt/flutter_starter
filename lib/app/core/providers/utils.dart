// Package imports:
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'utils.g.dart';

@riverpod
Logger logger(LoggerRef ref) {
  return Logger();
}
