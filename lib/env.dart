// Package imports:
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'SUPABASE_API_URL', obfuscate: true)
  static String supabaseApiUrl = _Env.supabaseApiUrl;
  @EnviedField(varName: 'SUPABASE_ANON_KEY', obfuscate: true)
  static String supabaseAnonKey = _Env.supabaseAnonKey;
}
