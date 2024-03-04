// Package imports:
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'SUPABASE_URL', obfuscate: true)
  static String supabaseUrl = _Env.supabaseUrl;
  @EnviedField(varName: 'SUPABASE_KEY', obfuscate: true)
  static String supabaseKey = _Env.supabaseKey;
}
