import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'provider.g.dart';

@riverpod
class AuthState extends _$AuthState {
  @override
  AsyncValue<User?> build() => const AsyncValue.data(null);

  void signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw UnimplementedError();
      } else {
        return response.user;
      }
    });
  }

  void signUpWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw UnimplementedError();
      } else {
        return response.user;
      }
    });
  }
}
