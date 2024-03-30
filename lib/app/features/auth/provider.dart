// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Project imports:
import '../../core/core.dart';

part 'provider.g.dart';

@riverpod
class AuthState extends _$AuthState {
  @override
  AsyncValue<Session?> build() =>
      AsyncValue.data(ref.read(supabaseProvider).auth.currentSession);

  void signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(supabaseProvider).auth.signInWithPassword(
            email: email,
            password: password,
          );
      if (response.user == null) {
        throw UnimplementedError();
      } else {
        return response.session;
      }
    });
  }

  void signUpWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(supabaseProvider).auth.signUp(
            email: email,
            password: password,
          );
      if (response.user == null) {
        throw UnimplementedError();
      } else {
        return response.session;
      }
    });
  }

  void signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(supabaseProvider).auth.signOut();
      return null;
    });
  }
}
