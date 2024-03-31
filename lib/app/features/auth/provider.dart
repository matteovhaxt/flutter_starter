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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(supabaseProvider).auth.signInWithPassword(
            email: email,
            password: password,
          );
      if (response.session == null) {
        ref.read(loggerProvider).e('Failed to sign in with email');
        return null;
      } else {
        ref.read(userStateProvider.notifier).getUser(response.session!.user.id);
        return response.session;
      }
    });
  }

  void signUpWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(supabaseProvider).auth.signUp(
            email: email,
            password: password,
          );
      if (response.session == null) {
        ref.read(loggerProvider).e('Failed to sign up with email');
        return null;
      } else {
        return response.session;
      }
    });
  }

  void signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(supabaseProvider).auth.signOut();
      ref.read(userStateProvider.notifier).clearUser();
      return null;
    });
  }

  void updateUser(String email) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(supabaseProvider).auth.updateUser(
            UserAttributes(email: email),
          );
      if (response.user == null) {
        ref.read(loggerProvider).e('Failed to update user');
        return state.value;
      } else {
        final response = await ref.read(supabaseProvider).auth.refreshSession();
        return response.session;
      }
    });
  }
}
